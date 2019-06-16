import 'package:flutter/material.dart';
import 'main_page/animated_add_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "QuickDiv Alpha", // Not sure what this title means
            theme: ThemeData(
                primaryColor: Colors.pink[200],
            ),
            home: MyHomePage(),
        );
    }
}
