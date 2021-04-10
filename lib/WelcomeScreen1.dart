
import 'package:flutter/material.dart';
import 'package:study_hub/student/WelcomePage.dart';


import 'package:study_hub/student/SignInPage.dart';

class WelcomeScreen1 extends StatefulWidget {
  @override
  _WelcomeScreen1State createState() => _WelcomeScreen1State();
}

class _WelcomeScreen1State extends State<WelcomeScreen1> {

  bool _isLogin = false;
  Map data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.lightBlueAccent],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                Text(
                  "STUDY HUB",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(
                  //height: MediaQuery.of(context).size.height / 6,
                  height: 40,
                ),

                Text(
                  " Come together to experience virtual study sessions with your peers and teachers like never before!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  // height: 45,
                ),

                Text(
                  "Are you a student?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WelcomePage(),
                    ));
                  },
                  child: Text(
                    "Proceed as a STUDENT-->",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /* boxContainer(
                "",
                "Sign up with Email",
                onEmailClick,
              ),*/
                SizedBox(
                  height: 30,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you a teacher?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ));
                      },
                      child: Text(
                        "Proceed as a TEACHER-->",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),



                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



  /*onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }*/

  Widget boxContainer(String path, String text, onClick) {

    child: InkWell(
      onTap: onClick,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 140,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Image.asset(
                  path,
                  height: 25,
                  width: 25,
                ),
                SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
