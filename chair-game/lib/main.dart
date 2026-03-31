import 'dart:async';
import 'dart:math';

import 'package:chair_game/chair.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var width = 0.0;
  var height = 0.0;
  var chairColorList = [Colors.red,Colors.yellow,Colors.blue];
  var colorList = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
  var rotationList = [0];
  var angleList = [0.0];
  var offsetX = 0.0;
  var duration = Duration(milliseconds: 50);
  var isSpining = false;
  var temp = 10;
  @override
  void initState() {
    super.initState();
    Timer.periodic(duration, (timer){
      angleList[0] += pi * 0.05;
      offsetX = angleList[0] > pi ? offsetX +  75.0 / 20.0 :offsetX -  75.0 / 20.0;
      if (angleList[0] >= 2 * pi){
        angleList[0] = 0.0;
      }
      if (isSpining){
        for(int x = 0; x < chairColorList.length; x++){
          chairColorList[x] = colorList[Random().nextInt(4)];
        }
      }
      setState(() {});
    });
    Timer.periodic(Duration(milliseconds: 400), (timer){
      if (isSpining){
        if (temp < 50){
          temp += 5;
          duration = Duration(milliseconds: temp);
          setState(() {});
        }else {
          isSpining = false;
          temp = 10;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Row(
          children: [
            Text("十八椅子"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          isSpining = true;
        },
        child: Icon(Icons.play_arrow),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(),
            Container(
              width: 50,
              height: 20,
            ),
            SizedBox(
              width:300,
              height:height,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                return SizedBox(
                  width: 300,
                  height: 200,
                  child: Stack(
                    children: [
                      Visibility(
                        visible: true,
                        child: Positioned(
                          left: offsetX + 125,
                          child: Transform(
                              transform: Matrix4.rotationY(angleList[0]),
                              alignment: Alignment.center,
                              child: chair(chairColorList[index],rotationList[0])
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Positioned(
                          left: offsetX + 125,
                          child: Transform(
                              transform: Matrix4.rotationY(angleList[0] + pi * 0.5),
                              alignment: Alignment.center,
                              child: chair(chairColorList[index],rotationList[0])
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Positioned(
                          left:offsetX + 125,
                          child: Transform(
                              transform: Matrix4.rotationY(angleList[0] + pi * 0.5),
                              alignment: Alignment.center,
                              child: chair(chairColorList[index],rotationList[0])
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      )
    );
  }
}
