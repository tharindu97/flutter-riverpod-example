import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

final greetingProvider = Provider((ref) => 'Hellow Riverpod1!');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Tutorial',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Riverpod Tutorial"),
        ),
        body: Center(
          child: Consumer(builder: (context, watch, child) {
            final greeting = watch(greetingProvider);
            return Text(greeting);
          }),
        ),
      ),
    );
  }
}

// Example 01

// class MyApp extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final greeting = watch(greetingProvider);
//     return MaterialApp(
//       title: 'Flutter Riverpod Tutorial',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Riverpod Tutorial"),
//         ),
//         body: Center(
//           child: Text(greeting),
//         ),
//       ),
//     );
//   }
// }
