import 'package:flutter/material.dart';
import 'widgets/game_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '15',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
            ),
            headline6: TextStyle(
              fontSize: 26.0,
              fontStyle: FontStyle.italic,
            ),
            bodyText1: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Raleway',
              color: Color.fromARGB(255, 17, 18, 17),
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              fontFamily: 'RobotoCondenced',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 12, 14, 14),
            ),
            headline2: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Raleway',
              color: Color.fromARGB(255, 246, 248, 246),
              //fontWeight: FontWeight.bold,
              backgroundColor: Colors.black54,
            ),
            headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondenced',
              color: Color.fromARGB(255, 12, 14, 14),
            )),
      ),
      home: const MyHomePage(title: '15'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GameField(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
