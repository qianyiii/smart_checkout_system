import 'package:smart_checkout_system/login.dart';
import 'package:smart_checkout_system/registration.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  static String id = 'welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

//Add with SingleTickerProviderStateMixin to enable this state to act as the ticker provider for the AnimationController
class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {

  final Color brownColor = Color(0xFF6D543F);

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
          backgroundColor: Color(0xFF3A2517),  // dark brown color
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/home.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // Login Button
          Positioned(
            bottom: 195,
            right: 40,
            child: SizedBox(
              width: 150,  // 统一宽度
              child: ElevatedButton.icon(
                icon: Icon(Icons.login, color: brownColor),
                label: Text('Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: brownColor.withOpacity(0.4),
                  elevation: 10,
                  padding: EdgeInsets.symmetric(vertical: 12), // 水平由 SizedBox 控制
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: brownColor),
                  ),
                ),
              ),
            ),
          ),

          // Register Button
          Positioned(
            bottom: 130,
            right: 40,
            child: SizedBox(
              width: 150,
              child: ElevatedButton.icon(
                icon: Icon(Icons.person_add_rounded, color: brownColor),
                label: Text('Register',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: brownColor.withOpacity(0.4),
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: brownColor),
                  ),
                ),
              ),
            ),
          ),
        ])

    );
  }
}
