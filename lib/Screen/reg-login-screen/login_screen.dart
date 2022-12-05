import 'package:blog_app/Screen/blog-screen.dart';
import 'package:blog_app/widget/Utils.dart';
import 'package:blog_app/widget/btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool showSpiner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("LogIn"),
          centerTitle: true,
        ),
        body: Center(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      InkWell(
                        onTap: (){
                          auth.sendPasswordResetEmail(email: emailController.text);
                        },
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text("Forgot Password?"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  title: 'LogIn',
                  onPress: () {
                    // setState(() {
                    //   showSpiner = true;
                    // });
                    if (formKey.currentState!.validate()) {
                      setState(() {
                      showSpiner = true;
                    });
                      auth
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        setState(() {
                          showSpiner = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => BlogScreen())));
                      }).onError((error, stackTrace) {
                        setState(() {
                          showSpiner = false;
                        });
                        Utils.showmessage(error.toString());
                      });
                    }
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
