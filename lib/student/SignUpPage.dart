
import 'package:flutter/material.dart';
import 'package:study_hub/student/SignInPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'HomePage.dart';
import 'StudentDetails.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

const REGISTER_API_URL = 'http://192.168.1.4:3000/student';

class SignUpPage extends StatefulWidget {

  //WelcomePage({Key key}) : super(key:key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
  }

  class _SignUpPageState extends State<SignUpPage> {
    final cryptor = new PlatformStringCryptor();
  bool vis=true;
  String valuechoose;
  String coursechosen;
  List listItem=[
    "class 1",
    "class 2",
    "class 3",
    "class 4",
    "class 5",
    "class 6",
    "class 7",
    "class 8",
    "class 9",
    "class 10",
    "class 11",
    "class 12",
    "BA",
    "BSc",
    "BCom",
    "BTech",
    "BMS/BBA/BBS"
    "LLB",
    "MBBS",
  ];
  final _globalkey= GlobalKey<FormState>();
  StudentDetails studentDetails;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _instituteController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  String errorText;
  bool circularLoading=false;
    @override
    Widget build(BuildContext context){
      return Scaffold(

        body:SingleChildScrollView(
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
         child: Form(
           key: _globalkey,
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
            "SIGN UP here",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          SizedBox(
            //height: 10,
            height: 5,
          ),


          nameTextField(),
          courseTextField(),
          specializationTextField(),

          instituteTextField(),
          usernameTextField(),
          emailTextField(),
          passwordTextField(),

          SizedBox(
            //height: 20,
            height: 10,
          ),

              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInPage()));
                },
                child: Text(
                  "ALready have an account? SIGN IN",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(
                //height: 30,
                height: 15,
              ),


InkWell(
  onTap: () async{
    setState(() {
      circularLoading=true;
    });
   if(_globalkey.currentState.validate()){
     // we will send the data to rest server
     studentDetails = StudentDetails(name:_nameController.text,course: valuechoose,specialization: _specializationController.text,institute:_instituteController.text,email: _emailController.text,
         username:_usernameController.text,password: _passwordController.text);
     createUser(studentDetails);
     setState(() {
       //actually we'll move to dashboard "HomePage.dart" now
       circularLoading=false;
     });
   }
   else
     {
       setState(() {
         circularLoading=false;
       });
     }
  },
                child: circularLoading?CircularProgressIndicator():
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
)]
        ),
      ),
      ),
        ),
      );
    }

  Widget nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
      child: Column(
        children: [
          Text("Your full name"),
          TextFormField(
            validator: (value)
            {
              if(value.isEmpty)
                return "Name field cannot be empty!";
              return null;
            },
             controller: _nameController,
            decoration: InputDecoration(
              //errorText: validate ? null : errorText,
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

  Widget courseTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
      child: Column(
        children: [
          //Text("Select your Grade/ graduation course"),
          DropdownButton(
            hint: Text("Select your Grade/ graduation course"),
           // dropdownColor: Color.,

            icon: Icon(Icons.arrow_drop_down),
            iconSize: 25,
            isExpanded: true,
            value: valuechoose,
            onChanged: (newValue){
              setState(() {
                valuechoose=newValue;
              });
            },
            items: listItem.map((valueItem){
              coursechosen=valueItem.toString();

              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );

            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget specializationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
      child: Column(
        children: [
          Text(
              "Enter your branch/specialization(eg:Mechanical Engineering)"),
          TextFormField(
            //controller: _specializationController,
            validator: (value)
            {
              if(value.isEmpty)
                return "Specialization field cannot be empty!...Enter NA if not valid";
              return null;
            },
            controller: _specializationController,
            decoration: InputDecoration(
              //errorText: validate ? null : errorText,
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

  Widget instituteTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
      child: Column(
        children: [
          Text("Institute/School/College"),
          TextFormField(
            //controller: _instituteController,
            validator: (value)
            {
              if(value.isEmpty)
                return "institute field cannot be empty!";
              return null;
            },
            controller: _instituteController,
            decoration: InputDecoration(
              //errorText: validate ? null : errorText,
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




    Widget usernameTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
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

    Widget emailTextField() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
        child: Column(
          children: [
            Text("Email"),
            TextFormField(
              controller: _emailController,
              validator: (value)
              {
                if(value.isEmpty)
                  return "email field cannot be empty!";
                if(!value.contains("@"))
                  return "email is invalid!";
                return null;
              },
              decoration: InputDecoration(
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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 1.0),
        child: Column(
          children: [
            Text("Password"),
            TextFormField(
              controller: _passwordController,
              validator: (value)
              {
                if(value.isEmpty)
                  return "password field cannot be empty!";
                if(value.length<8)
                  return "password length must be>=8";
                return null;
              },

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

  createUser(StudentDetails studentDetails) async {
    var url=REGISTER_API_URL+"/signup";
    //StudentDetails studentDetails;
    final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'name':studentDetails.name,
          'course': studentDetails.course,
          'specialization': studentDetails.specialization,
          'institute': studentDetails.institute,
          'username': studentDetails.username,
          'email':studentDetails.email,
          'password':studentDetails.password,
        }));
    var jsonResponse=convert.jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final snackBar = SnackBar(content: Text(studentDetails.username+" registered sucessfully"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(studentDetails)));
    }
    else{
      final snackBar = SnackBar(content: Text(jsonResponse['msg']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //Navigator.of(context).popAndPushNamed('/main');
      throw Exception('Failed to load details');
    }
  }

  }
