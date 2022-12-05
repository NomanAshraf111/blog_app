import 'dart:async';

import 'package:blog_app/Screen/reg-login-screen/user-login.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  blogapp() {
    Timer(
        Duration(seconds: 4),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => UserRegister()))
            );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogapp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "img/blog.png",
              filterQuality: FilterQuality.low,
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Blog",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}
