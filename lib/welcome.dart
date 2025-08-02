import 'package:flutter/material.dart';
import 'package:smart_checkout_system/registration.dart';

import 'UserScreens/home.dart';

class Welcome extends StatefulWidget {
  static String id = 'welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  final Color brownColor = Color(0xFF6D543F);
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(parent: controller!, curve: Curves.decelerate);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Align left
            children: [
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Amaranth',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Access your account below',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close bottom sheet
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Registration()));
                    },
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: brownColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined, color: brownColor),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline, color: brownColor),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => Home()),);
                  },
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brownColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RFID Smart One-Time Checkout System',
          style: TextStyle(
              fontFamily: 'Amaranth',
              fontSize: 25,
              fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF3A2517),
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
            width: 150,
            child: ElevatedButton.icon(
              icon: Icon(Icons.login, color: brownColor),
              label: Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: brownColor,
                ),
              ),
              onPressed: () => showLoginBottomSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: brownColor.withOpacity(0.4),
                elevation: 10,
                padding: EdgeInsets.symmetric(vertical: 12),
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
              label: Text(
                'Register',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: brownColor,
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registration()));
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
      ]),
    );
  }
}
