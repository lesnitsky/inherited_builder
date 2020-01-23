import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

String capitalize(String str) => '${str[0].toUpperCase()}${str.substring(1)}';
String uncapitalize(String str) => '${str[0].toLowerCase()}${str.substring(1)}';

String generateCallbackName(String name) => 'on${capitalize(name)}Changed';
String getFieldNameFromCallbackName(String name) =>
    name.substring(0, name.length - 'Changed'.length).replaceFirst('on', '');

bool isCallback(Field f) => f.type.symbol.startsWith('Function');

List<Field> getDataFields(List<Field> fields) =>
    fields.where((f) => !isCallback(f)).toList();
List<Field> getCallbackFields(List<Field> fields) =>
    fields.where((f) => isCallback(f)).toList();

List<Field> generateFields(ClassElement element) {
  final fields = element.fields.where((f) => !f.isStatic);

  return [
    ...fields.map((field) {
      return Field(
        (b) => b
          ..name = field.name
          ..modifier = FieldModifier.final$
          ..type = refer(field.type.toString()),
      );
    }).toList(),
    ...fields.map((field) {
      return Field((b) => b
        ..name = generateCallbackName(field.name)
        ..modifier = FieldModifier.final$
        ..type = refer('Function(${field.type.toString()})'));
    }).toList(),
  ];
}

Constructor generateConstructor(
  List<Field> fields, {
  callsSuper = true,
  superRequiresChild = true,
  hasOwnChild = false,
  requiredExclude = const [],
}) {
  return Constructor(
    (b) {
      b.optionalParameters
        ..add(
          Parameter(
            (b) => b
              ..name = 'key'
              ..type = refer('Key'),
          ),
        )
        ..addAll(
          fields.map(
            (f) => Parameter(
              (b) {
                b
                  ..name = f.name
                  ..named = true
                  ..toThis = true;

                if (requiredExclude.length > 0 &&
                    requiredExclude.indexOf(f.name) == -1) {
                  b..annotations.add(refer('required'));
                }
              },
            ),
          ),
        );

      if (superRequiresChild || hasOwnChild) {
        b.optionalParameters
          ..add(
            Parameter(
              (b) => b
                ..name = 'child'
                ..type = hasOwnChild ? null : refer('Widget')
                ..toThis = hasOwnChild,
            ),
          );
      }

      if (callsSuper) {
        final superArgs = ['key', if (superRequiresChild) 'child'];

        b.initializers
          ..add(
            Code(
              'super(${superArgs.map((arg) => "$arg : $arg").join(",")})',
            ),
          );
      }
    },
  );
}

class InheritedGenerator extends GeneratorForAnnotation<Inherited> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      final inheritedWidgetClassName = '${element.displayName}Provider';
      final fields = generateFields(element);
      final dataFields = getDataFields(fields);
      final callbackFields = getCallbackFields(fields);
      final modelField = Field(
        (b) => b
          ..name = 'model'
          ..modifier = FieldModifier.final$
          ..type = refer(element.displayName),
      );

      final modelCtor =
          '${element.name}(${dataFields.map((f) => "${f.name}: ${f.name}").join(",")});';

      final inheritedWidget = Class(
        (b) => b
          ..name = inheritedWidgetClassName
          ..extend = refer('InheritedWidget', 'package:flutter/widgets.dart')
          ..constructors.add(
            generateConstructor([...fields, modelField],
                requiredExclude: ['key']),
          )
          ..fields.addAll([
            ...fields,
            modelField,
            Field(
              (b) => b
                ..name = '_oldModel'
                ..static = true
                ..type = refer(element.displayName),
            ),
          ])
          ..methods.addAll([
            Method(
              (b) => b
                ..type = MethodType.getter
                ..name = 'oldModel'
                ..returns = refer(element.displayName)
                ..lambda = true
                ..body = Code(
                  '$inheritedWidgetClassName._oldModel',
                ),
            ),
            Method(
              (b) => b
                ..annotations.add(refer('override'))
                ..name = 'updateShouldNotify'
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'oldWidget'
                      ..type = refer(inheritedWidgetClassName),
                  ),
                )
                ..body = Code(
                  '''
                    final shouldNotify = ${dataFields.map((f) => 'oldWidget.${f.name} != ${f.name}').join('||')};

                    if (shouldNotify) {
                      _oldModel = oldWidget.model;
                    }

                    return shouldNotify;
                    ''',
                ),
            ),
            Method(
              (b) => b
                ..name = 'of'
                ..static = true
                ..returns = refer(inheritedWidgetClassName)
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type = refer('BuildContext'),
                  ),
                )
                ..body = Code(
                    'return context.dependOnInheritedWidgetOfExactType<$inheritedWidgetClassName>();'),
            ),
            ...dataFields.map((f) {
              final name = f.name;
              final capitalizedName =
                  '${name[0].toUpperCase()}${name.substring(1)}';

              return Method(
                (b) => b
                  ..name = 'set$capitalizedName'
                  ..requiredParameters.add(
                    Parameter((b) => b
                      ..name = 'new$capitalizedName'
                      ..type = f.type),
                  )
                  ..body = Code(
                    '${generateCallbackName(name)}(new$capitalizedName);',
                  ),
              );
            }),
          ]),
      );

      final statefulWidgetClassname = '${element.displayName}Builder';
      final stateClassname = '_${statefulWidgetClassname}State';

      final builderField = Field(
        (b) => b
          ..name = 'builder'
          ..modifier = FieldModifier.final$
          ..type =
              refer('Widget Function(BuildContext, ${element.displayName})'),
      );

      final statefulWidget = Class(
        (b) => b
          ..name = statefulWidgetClassname
          ..extend = refer('StatefulWidget', 'package:flutter/widgets.dart')
          ..constructors.add(
            generateConstructor(
              [...dataFields, builderField],
              superRequiresChild: false,
              hasOwnChild: true,
              requiredExclude: ['key', 'builder'],
            ),
          )
          ..fields.addAll([
            ...dataFields,
            Field(
              (b) => b
                ..name = 'child'
                ..modifier = FieldModifier.final$
                ..type = refer('Widget'),
            ),
            builderField,
          ])
          ..methods.addAll([
            Method(
              (b) => b
                ..annotations.add(refer('override'))
                ..returns = refer(stateClassname)
                ..name = 'createState'
                ..body = Code('return $stateClassname();'),
            ),
          ]),
      );

      final statefulWidgetState = Class(
        (b) => b
          ..name = stateClassname
          ..extend = refer(
              'State<$statefulWidgetClassname>', 'package:flutter/widgets.dart')
          ..fields.addAll(
            // remove final modifier
            dataFields.map(
              (_f) => Field((f) => f
                ..name = _f.name
                ..type = _f.type),
            ),
          )
          ..methods.add(
            Method((b) => b
              ..annotations.add(refer('override'))
              ..name = 'initState'
              ..body = Code('''
                ${dataFields.map((f) => "${f.name} = widget.${f.name};").join("")}
                super.initState();
                ''')),
          )
          ..methods.add(
            Method(
              (b) => b
                ..annotations.add(refer('override'))
                ..returns = refer('Widget', 'package:flutter/widgets.dart')
                ..name = 'build'
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'context'
                      ..type =
                          refer('BuildContext', 'package:flutter/widgets.dart'),
                  ),
                )
                ..body = Code('''final model = $modelCtor
                
                return $inheritedWidgetClassName(
                  model: model,
                  child: (widget.builder ?? (_, __) => widget.child)(context, model),
                    ${dataFields.map((f) {
                  return "${f.name}: ${f.name}";
                }).join(",")}
                ,
                  ${callbackFields.map((f) {
                  return "${f.name}: (newValue) { setState(() { ${uncapitalize(getFieldNameFromCallbackName(f.name))} = newValue; }); }";
                }).join(",")}
                );'''),
            ),
          )
          ..methods.add(
            Method((b) => b
              ..annotations.add(refer('override'))
              ..name = 'didUpdateWidget'
              ..requiredParameters.add(
                Parameter(
                  (b) => b
                    ..name = 'oldWidget'
                    ..type = refer('Widget'),
                ),
              )
              ..body = Code('''
                ${dataFields.map((f) => "${f.name} = widget.${f.name};").join("")}

                super.didUpdateWidget(oldWidget);
                ''')),
          ),
      );

      final emitter = DartEmitter();
      final formatter = DartFormatter();

      return '''
        ${formatter.format('${inheritedWidget.accept(emitter)}')}
        ${formatter.format('${statefulWidget.accept(emitter)}')}
        ${formatter.format('${statefulWidgetState.accept(emitter)}')}
      ''';
    }

    return '// Something went wrong';
  }
}
