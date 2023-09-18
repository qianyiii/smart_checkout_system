import 'package:flutter/material.dart';
import 'package:smart_checkout_system/adminLogin.dart';
import 'package:smart_checkout_system/home.dart';
import 'package:smart_checkout_system/registration.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Welcome Back !',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 40,left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Access your account below or ',
                        style: TextStyle(fontSize: 16
                        ),
                      ),
                      //By pressing this text button, it will navigate to the register page.
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registration()),
                          );
                        }, child: Text(
                        'Create Account',
                        style: TextStyle(fontSize: 16,
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Your email...',
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14),
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                ),

                SizedBox(
                  width: 150,
                  height: 40,
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
                          MaterialPageRoute(builder: (context) => Home()),);
                      },
                    child: Text('Login'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextButton(onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminLogin()),);
                  },
                  child: Text('Login as admin',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline),
                  ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],),

    );
  }
}

