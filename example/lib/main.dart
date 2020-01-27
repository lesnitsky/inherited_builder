import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'main.g.dart';

void main() => runApp(MyApp());

@Inherited()
class AppState {
  final int count;

  AppState({this.count});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppStateBuilder(
      count: 0,
      child: MaterialApp(
        title: 'Inherited Builder demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Inherited Builder demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateProvider = AppStateProvider.of(context);
    final count = appStateProvider.count;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appStateProvider.setCount(appStateProvider.count + 1);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
