import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNmber = 2;
  int rightDiceNumber = 5;
  AnimationController _controller;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        new AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
    // _controller.forward();
    animation.addListener(() {
      setState(() {});
      // print(_controller.value);
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNmber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        // print("Completed");
        _controller.reverse();
      }
    });
  }

  void roll() {
    setState(() {
      _controller.forward();
      // leftDiceNmber = Random().nextInt(6) + 1;
      // rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dicee"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200 - animation.value * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$leftDiceNmber.png')),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: roll,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image(
                        height: 200 - animation.value * 200,
                        image: AssetImage(
                            'assets/images/dice-png-$rightDiceNumber.png')),
                  ),
                ))
              ],
            ),
            RaisedButton(
              onPressed: roll,
              child: Text('Roll'),
            )
          ],
        ),
      ),
    );
  }
}
