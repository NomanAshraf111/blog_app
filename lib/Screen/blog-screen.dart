import 'package:blog_app/Screen/addpostscreen.dart';
import 'package:blog_app/Screen/reg-login-screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final datRef = FirebaseDatabase.instance.ref().child('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("New Blog"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddPostScreen())));
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                await auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LogInScreen())));
                });
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: datRef.child('Post List'),
              itemBuilder: (context, snapshot, animation, index) {
                var data = snapshot.value as Map;

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              width: 190.0,
                              height: 190.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          data['pImage'])))),
                        ),

                        // Image.network(data['pImage']),

                        // FadeInImage.assetNetwork(
                        //     height: 200,
                        //     width: 200,
                        //     placeholder: 'img/blog.png',
                        //     image: data['pImage' ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              data['pTitle'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 26),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data['pDescr'],
                              style: TextStyle(
                                  color: Colors.grey.withRed(1), fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
