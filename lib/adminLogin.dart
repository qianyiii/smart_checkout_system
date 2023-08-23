import 'package:flutter/material.dart';
import 'package:smart_checkout_system/adminHome.dart';

class AdminLogin extends StatefulWidget {
  static String id = 'adminlogin';

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),
        centerTitle: true,),
      body: Stack(children: [
        Container(
          //Used to decorate the container widget with an image as its background.
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bckimg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Opacity(
            opacity: 0.5, // 50% opacity
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 450,
            width: 550,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      'Welcome Back !',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Your email...',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),

                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();


                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter email and password.')),
                        );
                        return;
                      }

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminHome()),);
                    },
                    child: Text('Login'),
                  ),
                )
              ],
            ),
          ),
        )
      ],),

    );
  }
}

