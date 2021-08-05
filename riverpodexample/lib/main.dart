import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Response from $url';
  }
}

final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
final responseProvider =
    FutureProvider.family<String, String>((ref, url) async {
  final httpClient = ref.read(fakeHttpClientProvider);
  return httpClient.get(url);
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Tutorial',
      home: Scaffold(
        body: Center(
          child: Consumer(
            builder: (context, watch, child) {
              final responseAsyncValue =
                  watch(responseProvider('https://resocoder.com'));
              return responseAsyncValue.map(
                data: (_) => Text(_.value),
                loading: (_) => CircularProgressIndicator(),
                error: (_) => Text(
                  _.error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//  Example 05

// class FakeHttpClient {
//   Future<String> get(String url) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return 'Response from $url';
//   }
// }

// final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
// final responseProvider = FutureProvider<String>((ref) async {
//   final httpClient = ref.read(fakeHttpClientProvider);
//   return httpClient.get('https://resocoder.com');
// });

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Riverpod Tutorial',
//       home: Scaffold(
//         body: Center(
//           child: Consumer(
//             builder: (context, watch, child) {
//               final responseAsyncValue = watch(responseProvider);
//               return responseAsyncValue.map(
//                 data: (_) => Text(_.value),
//                 loading: (_) => CircularProgressIndicator(),
//                 error: (_) => Text(
//                   _.error.toString(),
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// Example 04

// final firstStringProvider = Provider((ref) => 'First');
// final secondStringProvider = Provider((ref) => 'Second');

// class MyApp extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {

//     final first = watch(firstStringProvider);
//     final second = watch(secondStringProvider);

//     return MaterialApp(
//       title: 'Flutter Riverpod Tutorial',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Riverpod Tutorial"),
//         ),
//         body: Column(
//           children: [
//             Text(first),
//             Text(second),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  Example 03 ChangeNotifier

// class IncrementNotifier extends ChangeNotifier {
//   int _value = 0;
//   int get value => _value;

//   void increment() {
//     _value++;
//     notifyListeners();
//   }
// }

// final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());
// final greetingProvider = Provider((ref) => 'Hellow Riverpod1!');

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
//             final incrementNotifier = watch(incrementProvider);
//             return Text(incrementNotifier.value.toString());
//           }),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             context.read(incrementProvider).increment();
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// Example 02 Provider

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

// Example 01 Provider

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
