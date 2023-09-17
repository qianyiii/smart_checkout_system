import 'package:flutter/services.dart';
import 'package:smart_checkout_system/login.dart';
import 'package:smart_checkout_system/registration.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class Welcome extends StatefulWidget {
  static String id = 'welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

//Add with SingleTickerProviderStateMixin to enable this state to act as the ticker provider for the AnimationController
class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  //Create an AnimationController object
  AnimationController? controller;

  //Create an Animation object
  Animation? animation;

  //Override the initState() method
  @override
  void initState() {
    super.initState();

    //Create an AnimationController, setting its duration and vsync
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //Initialize the Animation object to a new CurvedAnimation()
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);

    //Call the forward() method - this is going to propel or start the animation
    controller!.forward();

    //Call the addListener() method, the setState() - this is the one that is going to update the animation of the UI
    controller!.addListener(() {
      setState(() {});
    });
  }

  //Override the dispose() method
  @override
  void dispose() {
    super.dispose();
    //Dispose the AnimationController object - to release the resources use for the animation
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RFID Smart One-Time Checkout System'),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          Container(
            //Used to decorate the container widget with an image as its background.
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/home.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            bottom: 240,
            right: 60,
            child: TextButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login()),);
            },
              child: Text('Login',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          Positioned(
            bottom: 195,
            right: 50,
            child: TextButton(onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()),);
            },
              child: Text('Register',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            right: 60,
            child: TextButton(onPressed: (){
              html.window.close();
              SystemNavigator.pop(); // 直接退出应用程序
            },
              child: Text('Exit',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],)
    );
  }
}
