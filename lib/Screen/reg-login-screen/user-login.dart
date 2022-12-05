import 'package:blog_app/Screen/reg-login-screen/login_screen.dart';
import 'package:blog_app/Screen/reg-login-screen/signup_screen.dart';
import 'package:blog_app/widget/btn.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "img/blog.png",
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                title: 'LogIn',
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LogInScreen()));
                },
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                title: 'Register',
                onPress: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
