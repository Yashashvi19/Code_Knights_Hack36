
import 'package:study_hub/student/SignUpPage.dart';
  import "package:flutter/material.dart";
import 'package:study_hub/student/StudentDetails.dart';
 import 'package:http/http.dart' as http;
 import 'dart:convert' as convert;
import 'HomePage.dart';

const REGISTER_API_URL = 'http://192.168.1.4:3000/student';

  class SignInPage extends StatefulWidget {
    SignInPage({Key key}) : super(key: key);

    @override
    _SignInPageState createState() => _SignInPageState();
  }

  class _SignInPageState extends State<SignInPage> {
    bool vis = true;
    StudentDetails studentDetails;
    final _globalkey = GlobalKey<FormState>();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    String errorText;
    bool circular = false;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.lightBlueAccent],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Form(
            key: _globalkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SIGN IN here",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  usernameTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  passwordTextField(),
                  SizedBox(
                    height: 20,
                  ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Text(
                          "New User? SIGN UP",
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),


                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });
                      if(_globalkey.currentState.validate()){
                        // we will send the data to rest server
                        studentDetails =
                            StudentDetails(username: _usernameController.text, password: _passwordController.text);
                        findUser(studentDetails);
                        setState(() {
                          //actually we'll move to dashboard "HomePage.dart" now
                          circular=false;
                        });
                      }
                      else
                      {
                        setState(() {
                          circular=false;
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: circular
                            ? CircularProgressIndicator()
                            : Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(
                  //   height: 50,
                  //   thickness: 1.5,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget usernameTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
        child: Column(
          children: [
            Text("Username"),
            TextFormField(
              controller: _usernameController,
              validator: (value)
              {
                if(value.isEmpty)
                  return "username field cannot be empty!";
                return null;
              },
              decoration: InputDecoration(
                //errorText: validateUsername ? null : errorText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget passwordTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
        child: Column(
          children: [
            Text("Password"),
            TextFormField(
              controller: _passwordController,
             /* validator: (value)
              {
                if(value.isEmpty)
                  return "password field cannot be empty!";
                if(value.length<8)
                  return "password length must be>=8";
                return null;
              },*/

              obscureText: vis,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      vis = !vis;
                    });
                  },
                ),
                helperText: "Password length should have >=8",
                helperStyle: TextStyle(
                  fontSize: 14,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    findUser(StudentDetails userDetails) async {
      var url2 = REGISTER_API_URL+"/signin";
      StudentDetails signinDetails;
      try {
        final http.Response response = await http.post(url2,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(<String, String>{
              'username': studentDetails.username,
              'password': studentDetails.password,
            }));
        print(response.statusCode);
        var jsonResponse;
        if (response.statusCode == 200) {
          jsonResponse = convert.jsonDecode(response.body)['result'];
          print(jsonResponse);
          setState(() {
            signinDetails =new StudentDetails(
                name: jsonResponse['name'],
              username: jsonResponse['username'],
              email: jsonResponse['email'],
              course: jsonResponse['course'],
                specialization: jsonResponse['specialization'],
              institute: jsonResponse['institute']
            );
          });
          print(signinDetails.username);
          print('Sign in sucessfully');
          final snackBar = SnackBar(
              content: Text(signinDetails.username + " Signed in successfully"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(signinDetails)));
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
        } else {
          jsonResponse=convert.jsonDecode(response.body);
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          final snackBar = SnackBar(
              content: Text(jsonResponse['msg']));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          throw Exception('Wrong email or password');
        }
      }
      catch(Exception){
        print(Exception);
      }
    }
  }

