import 'package:flutter/material.dart';
import 'package:smart_checkout_system/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  static String id = 'registration';

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isTermsAccepted = false;
  String? _termOfUseError;
  String? email;
  String? password;

  //create a private FirebaseAuth instance
  final _auth = FirebaseAuth.instance;

  void _register() async {
    setState(() {
      _termOfUseError = _isTermsAccepted ? null : '  Please accept the terms of use.';
    });

    if (_formKey.currentState!.validate() && _isTermsAccepted) {
      try {
        var userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);

        if (userCredential != null && userCredential.user != null) {
          // 用户注册成功，弹出成功注册的对话框
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration success'),
                content: Text('You have successfully registered !'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // 注册成功后，您可以在这里进行其他操作，比如跳转到首页
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);

        // 如果 Firebase 返回错误，检查错误码以判断具体错误类型
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Registration Failed'),
                  content: Text('This email address is already in use by another account. Please try registering with a different email or log in with your existing account.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),
        centerTitle: true,),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,),
        ),
          child: Opacity(
            opacity: 0.5,
            child: Container(
              color: Colors.black,
            ),
          ),
      ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 600,
            width: 550,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Form(
            key: _formKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('Fill out the form for registration',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0), // 调整这里的数值以更改边框的圆角半径
                      ),
                      borderSide: BorderSide(
                        width: 1.0, // 调整这里的数值以更改边框的宽度
                      ),
                    ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter your username.';
                    }
                    return null;
                    },
                  ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 450,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value){
                      email = value;
                    },
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      } else if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 450,
                  child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter your phone number.';
                    }
                    return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 450,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 45, bottom: 20,),
                  child: Row(
                    children: [
                    Checkbox(
                      value: _isTermsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _isTermsAccepted = value ?? false;
                          _termOfUseError = null; // Clear the error when checkbox changes
                        });
                      },
                    ),
                    Text('I accept the terms of use.'),
                    if (_termOfUseError != null)
                      Text(
                        _termOfUseError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: _register,
                      child: Text('Register'),
                  ),
                )
              ],
            ),
          ),
        ),
        ),
    ],),
    );
  }
}
