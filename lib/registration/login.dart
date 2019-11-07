import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/registration/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email, _password;
  bool remberMe = false;

  @override
  void initState() {
    // _email = getShearedPreferenceForEmail();
    super.initState();

    autoLogin();
  }

  autoLogin() async {
    String email = await getShearedPreferenceForEmail();
    String password = await getShearedPreferenceForPassword();

    setState(() {
      _emailController = TextEditingController(text: email);
      _passwordController = TextEditingController(text: password);
      if (email != null && password != null) {
        signIn();
      }
    });

    //signIn();
    // Fluttertoast.showToast(
    //     msg: 'Email: ${email},Password: ${password}',
    //     toastLength: Toast.LENGTH_SHORT);
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('password', null);

    setState(() {
      _emailController = null;
      _passwordController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        // backgroundColor: Color.fromRGBO(153, 132, 132, 1),
        appBar: new AppBar(
          title: Text('SignIn'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 15.0),
                        hintText: "Enter Your Email...",
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (input) {
                        if (_emailController.text.isEmpty) {
                          return 'Provide an email';
                        }
                      },
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 15.0),
                        hintText: "Enter Your Password...",
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      validator: (input) {
                        if (_passwordController.text.length < 6) {
                          return 'password must be greater then 6 character';
                        }
                      },
                      controller: _passwordController,
                      obscureText: true,
                      autocorrect: false,
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
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Color(0xff01A0C7),
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          onPressed: () async {
                            signIn();
                            Fluttertoast.showToast(
                                msg:
                                    'Email: ${await getShearedPreferenceForEmail()},Password: ${await getShearedPreferenceForPassword()}',
                                toastLength: Toast.LENGTH_SHORT);
                          },
                          minWidth: 200.0,
                          height: 45.0,
                          child: Text('Sign in'),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        if (remberMe == true) {
          setShearedPreferenceForEmail(_emailController.text);
          setShearedPreferenceForPassword(_passwordController.text);
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
