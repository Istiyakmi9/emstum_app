import 'dart:io';
import 'dart:ui';

import 'package:bot_org_manage/modal/user.dart';
import 'package:bot_org_manage/modal/utils.dart';
import 'package:bot_org_manage/service/ajax.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/Configuration.dart';
import '../../modal/appData.dart';
import '../../utilities/NavigationPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User _user = User();
  var util = Util();
  Ajax ajax = Ajax.getInstance();
  bool isSubmitted = false;
  SharedPreferences? _preferences;
  bool _isLoading = true;

  void _onSubmitted() {
    _formKey.currentState?.save();
    ajax.login("Login/Authenticate", {
      "Mobile": _user.Mobile,
      "Password": _user.Password,
      "CompanyCode": _user.CompanyCode
    }).then((value) {
      Fluttertoast.showToast(msg: "Login successfully.");
      var result = Ajax.getResponseResult(value);
      _user = User.fromJson(result["UserDetail"]);
      util.setUserDetail(result);

      Provider.of<AppData>(context, listen: false).updateUser(_user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        NavigationPage.HomePage,
        (route) => false,
      );
    }).catchError((e) {
      setState(() {
        isSubmitted = false;
      });
    });
  }

  void initConfiguration() {
    Configuration.width = MediaQuery.of(context).size.width;
    Configuration.height = MediaQuery.of(context).size.height;
    Configuration.isAndroid = Platform.isAndroid;

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initConfiguration();
      var prefs = Util.getSharedPreferences();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getLoginForm() {
    Widget formBox = Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: double.infinity,
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.blueAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Enter email or mobile no#",
                  ),
                  initialValue: "",
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _user.Mobile = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    prefixIcon: Icon(
                      Icons.corporate_fare_rounded,
                      color: Colors.blueAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Enter company code",
                  ),
                  initialValue: "",
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _user.CompanyCode = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    prefixIcon: Icon(
                      Icons.key_outlined,
                      color: Colors.blueAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    hintText: "Enter password",
                  ),
                  initialValue: "",
                  obscureText: true,
                  obscuringCharacter: "*",
                  onSaved: (value) {
                    _user.Password = value!;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 18,
                ),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );

    return formBox;
  }

  Widget getBottomActions() {
    return Container(
      child: ElevatedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              vertical: 10,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.primary,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 0,
              ),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            isSubmitted = true;
          });
          _onSubmitted();
        },
        label:
            !isSubmitted ? const Text("Sign in") : const Text("Please wait..."),
        icon: !isSubmitted
            ? const Icon(
                Icons.rocket_launch_rounded,
              )
            : SizedBox.fromSize(
                size: const Size(20, 20),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: LoginClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 650,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: getLoginForm(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: getBottomActions(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Need help!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text("By continuing, you agree with our terms & condition"),
                  SizedBox(
                    height: 5,
                  ),
                  const Text("Version: 1.0.5"),
                ],
              ),
            ),
    );
  }
}

class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
