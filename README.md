# Inherited Builder

Autogenerated state management and dependency inhection with inherited widgets

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=42)](https://lesnitsky.dev?utm_source=inherited_builder)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/inherited_builder.svg?style=social)](https://github.com/lesnitsky/inherited_builder)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

## ToC

- [Motivation](#motivation)
- [App Reference Architecture](#app-reference-architecture)
- [Installation](#installation)
- [Usage](#usage)
  - [Define your model](#define-your-model)
  - [Execute build_runner](#execute-build-runner)
  - [Place Builder in your widget tree](#place-builder-in-your-widget-tree)
  - [Access values using Provider](#access-values-using-provider)
  - [Access instance of your model using Provider](#access-instance-of-your-model-using-provider)
  - [React to changes](#react-to-changes)
  - [Define actions on your model](#define-actions-on-your-model)
- [License](#license)

## Motivation

[InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) is a powerful concept which allows you to inject values and pass them down the widget tree as well as subscribe to updates, but it requires a lot of boilerplate

This package allows you to get advantage of this awesome concept w/o boilerplate, it will be autogenerated for you

## App Reference Architecture

[Check out app reference architecture](./app_reference_architecture)

## Installation

```yaml
dev_dependencies:
  build_runner: <version>
  inherited_builder: ^1.0.0
```

## Usage

### Define your model

`app_state.dart`

```dart
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'app_state.g.dart'

@Inherited()
class AppState {
    final int count;

    const AppState({ this.count });

    String toString() {
        return 'Count is $count';
    }
}
```

### Execute build_runner

```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This will generate `AppStateBuilder` and `AppStateProvider` classes

### Place Builder in your widget tree

```dart
import 'package:flutter/material.dart';

class ParentWidget extends StatelessWidget {
  final Widget child;

  const ParentWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const initialValue = 0;

    return AppStateBuilder(
      count: initialValue,
      child: child,
    );
  }
}
```

### Access values using Provider

```dart
class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateProvider = AppStateProvider.of(context);

    return Scaffold(
      body: Center(child: Text(appStateProvider.count.toString())),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final count = appStateProvider.count;
          appStateProvider.setcount(count + 1);
        },
      ),
    );
  }
}
```

### Access instance of your model using Provider

```diff
class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateProvider = AppStateProvider.of(context);
+   final appState = appStateProvider.model;

    return Scaffold(
-     body: Center(child: Text(appStateProvider.count.toString())),
+     body: Center(child: Text(appState.toString())),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final count = appStateProvider.count;
          appStateProvider.setcount(count + 1);
        },
      ),
    );
  }
}
```

### React to changes

You can use `didChangeDepencies()` to react to changes of your model (e.g. `appStateProvider.setCount(newCount)`)

Example:

```dart
import 'package:flutter/material.dart';

class StatePersistance extends StatefulWidget {
  final Widget child;

  const StatePersistance({Key key, this.child}) : super(key: key);

  @override
  _StatePersistanceState createState() => _StatePersistanceState();
}

class _StatePersistanceState extends State<StatePersistance> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() async {
    final appStateProvider = AppStateProvider.of(context);

    final currentState = appStateProvider.model;
    final prevState = appStateProvider.oldModel;

    if (currentState.count != prevState.count) {
        persist(currentState);
    }

    super.didChangeDependencies();
  }
}
```

### Define actions on your model

> requires dart >2.7.0

```dart
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

@Inherited()
class AppState {
    final int count;

    const AppState({ this.count });

    String toString() {
        return 'Count is $count';
    }
}

extension CounterActions on AppStateProvider {
    increment() {
        this.setCount(this.count + 1);
    }
}

// somewhere in the widget tree:

final appStateProvider = AppStateProvider.of(context);
appStateProvider.increment();
```

## License

MIT

[![lesnitsky.dev](https://lesnitsky.dev/icons/shield.svg?hash=42)](https://lesnitsky.dev?utm_source=inherited_builder)
[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/inherited_builder.svg?style=social)](https://github.com/lesnitsky/inherited_builder)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)
