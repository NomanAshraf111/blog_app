import 'package:blog_app/Screen/reg-login-screen/login_screen.dart';
import 'package:blog_app/widget/Utils.dart';
import 'package:blog_app/widget/btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  bool showSpiner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpiner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  
                  title: 'SignUp',
                  onPress: () {
                    
                    if (formKey.currentState!.validate()) {
                      setState(() {
                      showSpiner = true;
                    });
                      auth
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        setState(() {
                          showSpiner = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => LogInScreen())));
    
                    
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
