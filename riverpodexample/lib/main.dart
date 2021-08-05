import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Tutorial',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Riverpod Tutorial"),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyFirstClass(),
      child: ProxyProvider<MyFirstClass, MySecondClass>(
        update: (context, firstClass, previous) => MySecondClass(firstClass),
        child: Builder(
          builder: (context) {
            return Text(Provider.of<MySecondClass>(context).myFirstClass.value);
          },
        ),
      ),
    );
  }
}

class MyFirstClass {
  final value = "tharindu";
}

class MySecondClass {
  final MyFirstClass myFirstClass;
  MySecondClass(this.myFirstClass);
}
