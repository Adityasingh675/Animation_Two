import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  void myListener(status) {
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(myListener);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.fastOutSlowIn,
        ),
      );
      animationController.forward();
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    )..addStatusListener(
        myListener); // Append a listener to listen for the animation.
    super.initState();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Two'),
      ),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
