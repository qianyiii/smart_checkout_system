import 'package:flutter/material.dart';
import 'package:smart_checkout_system/welcome.dart';

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

  void _register() {
    setState(() {
      _termOfUseError =
      _isTermsAccepted ? null : '  Please accept the terms of use.';
    });

    if (_formKey.currentState!.validate() && _isTermsAccepted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration success'),
            content: Text('You have successful registration！'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Welcome()),);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter your email.';
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Please enter your password.';
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
