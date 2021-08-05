import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}

final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());
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
            final incrementNotifier = watch(incrementProvider);
            return Text(incrementNotifier.value.toString());
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(incrementProvider).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

// Example 02

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Riverpod Tutorial',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Riverpod Tutorial"),
//         ),
//         body: Center(
//           child: Consumer(builder: (context, watch, child) {
//             final greeting = watch(greetingProvider);
//             return Text(greeting);
//           }),
//         ),
//       ),
//     );
//   }
// }

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
