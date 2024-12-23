import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream_Fitri',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const StreamHomepage(),
    );
  }
}

class StreamHomepage extends StatefulWidget {
  const StreamHomepage({super.key});

  @override
  State<StreamHomepage> createState() => _StreamHomepageState();
}

class _StreamHomepageState extends State<StreamHomepage> {
  late StreamController numberStreamController;
  late NumberStream numberStream;
  int lastNumber = 0;

  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  @override
  void initState() {
    super.initState();

    numberStream = NumberStream();
    numberStreamController = numberStream.controller;

    Stream stream = numberStreamController.stream;
    stream.listen((event) {
      setState(() {
        lastNumber = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(lastNumber.toString()),
          ElevatedButton(
              onPressed: () => addRandomNumber(),
              child: Text('New Random Number')),
        ],
      ),
    )
        // appBar: AppBar(
        //   title: const Text('Stream'),
        // ),
        // body: Container(
        //   decoration: BoxDecoration(color: bgColor),
        // )
        );
  }

  // Mengubah warna latar belakang berdasarkan stream
  void changeColor() async {
    colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor; // Mengubah latar belakang
      });
    });
  }

  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    numberStream.addNumberToSink(myNum);
  }

  @override
  void dispose() {
    numberStreamController.close();
    super.dispose();
  }
}
