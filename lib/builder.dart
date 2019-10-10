import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import './generator.dart';

Builder inheritedBuilder(BuilderOptions options) =>
    SharedPartBuilder([InheritedGenerator()], 'inherited_generator');
