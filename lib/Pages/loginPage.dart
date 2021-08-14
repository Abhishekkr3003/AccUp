import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    print("here3");
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print("here3");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VxArc(
                height: 50,
                child: Image.asset(
                  "assets/images/signin.png",
                  fit: BoxFit.cover,
                ),
              ),
              // "AccUP"
              //     .text
              //     .xl6
              //     .fontFamily("Pacifico")
              //     .bold
              //     .make()
              //     .pOnly(top: 50),
              Text(
                "AccUP",
                style: GoogleFonts.pacifico(fontSize: 100),
              ),
              SizedBox(
                height: 20.0,
              ),
              // "Sign In"
              //     .text
              //     .bold
              //     .color(context.accentColor)
              //     .xl5
              //     .make()
              //     .pOnly(top: 50),
              SignInButton(
                Buttons.Google,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 20),
                onPressed: () async {
                  print("here");

                  await signInWithGoogle();
                  print("here2");
                  String userId =
                      FirebaseAuth.instance.currentUser!.uid.toString();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (!documentSnapshot.exists) {
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(userId)
                          .set({});
                    }
                  });
                  Fluttertoast.showToast(
                      msg: "Logged in as " +
                          FirebaseAuth.instance.currentUser!.email.toString());
                },
              ).pOnly(bottom: 50),
            ],
          ),
        ),
      ),
    );
  }
}
