import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/registration/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool remberMe = false;

  @override
  void initState() {
    // _email = getShearedPreferenceForEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide an email';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (input) {
                      _email = input;
                      //setShearedPreferenceForEmail(input);
                    }),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'password must be greater then 6 character';
                    }
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  onSaved: (input) {
                    _password = input;
                    //setShearedPreferenceForPassword(input);
                  },
                  obscureText: true,
                ),
                Row(
                  children: <Widget>[
                    Text("Remember me"),
                    Checkbox(
                      value: remberMe,
                      onChanged: (bool value) {
                        setState(() {
                          remberMe = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(
                          "Create New Account",
                        ),
                        onTap: () {
                          navigateToSignUp();
                        },
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () async {
                    signIn();
                    Fluttertoast.showToast(
                        msg:
                            'Email: ${await getShearedPreferenceForEmail()},Password: ${await getShearedPreferenceForPassword()}',
                        toastLength: Toast.LENGTH_SHORT);
                  },
                  child: Text('Sign in'),
                ),
              ],
            )),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (remberMe == true) {
          setShearedPreferenceForEmail(_email);
          setShearedPreferenceForPassword(_password);
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  setShearedPreferenceForEmail(String email) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("email", email);
  }

  setShearedPreferenceForPassword(String password) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("password", password);
  }

  getShearedPreferenceForEmail() async {
    final pref = await SharedPreferences.getInstance();

    //print("${pref.getString("email")}");
    return pref.getString("email");
  }

  getShearedPreferenceForPassword() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("password");
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
