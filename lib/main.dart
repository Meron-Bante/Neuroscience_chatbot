import 'package:bits_bot/widget/animatedFABJump.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Uri _url = Uri.parse('http://www.application.bitscollege.edu.et/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.height * 0.4,
            child: const Image(image: AssetImage("bitslogo.png"))),
        actions: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.06),
            child: ElevatedButton(
              onPressed: () {
                // launch(_url.toString());
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0, // No shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.green[400]!),
                ),

                disabledBackgroundColor: Colors.green[200],
                disabledForegroundColor: Colors.green[200],
              ),
              child: const Text(
                'Apply Now',
                style: TextStyle(color: Colors.green),
              ),
            ),
          )
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      body: Center(
          child: Text(
        'WELCOME TO BITS COLLEGE',
        style: TextStyle(
          color: Colors.green[400],
          fontSize: MediaQuery.of(context).size.height * 0.1,
          fontFamily: 'Pacifico',
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      )),
      floatingActionButton: AnimatedFABJump(),
    );
  }
}
