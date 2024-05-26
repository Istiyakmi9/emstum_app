import 'package:bot_org_manage/screens/login/widgets/action_view.dart';
import 'package:bot_org_manage/screens/login/widgets/signin_view.dart';
import 'package:flutter/material.dart';

class LoginIndex extends StatefulWidget {
  const LoginIndex({super.key});

  @override
  State<LoginIndex> createState() => _LoginIndexState();
}

class _LoginIndexState extends State<LoginIndex> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: LoginClipper(),
            child: Container(
              width: double.infinity,
              height: 650,
              color: Theme.of(context).colorScheme.primary,
              child: Center(
                child: SingInView(),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ActionView(),
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
