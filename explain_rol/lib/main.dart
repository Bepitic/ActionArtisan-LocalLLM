import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'start.dart';

Future<void> main() async {
  // try {
  //   await dotenv.load();
  // } on Exception catch (_) {
  //   // print("dotenv error");
  //   dotenv.env['foo'] = 'asdfasdfasdf';
  //   print(dotenv.env['foo']);
  //   // throw Exception("Error on server");
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Action Narrator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (BuildContext ctx) => const DataForm(),
        },
        initialRoute: '/');
  }
}
