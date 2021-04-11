import 'package:flutter/material.dart';
import 'SearchPeerPage.dart';
import 'SelectedCoursePage.dart';
import 'StudentDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:study_hub/chat/Client.dart';
import 'WelcomePage.dart';
String name;
String username;
String email;
String course;
String specialization;
String institute;
String password;
String selected;

class DashboardDrawer extends StatefulWidget {

  DashboardDrawer(StudentDetails studentDetails){
    name=studentDetails.name;
    username=studentDetails.username;
    email=studentDetails.email;
    course=studentDetails.course;
    specialization=studentDetails.specialization;
    institute=studentDetails.institute;
    password=studentDetails.password;
  }

  @override
  _DashboardDrawerState createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  List listCourse=[
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.lightBlue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage('https://cdn1.iconfinder.com/data/icons/instagram-ui-colored/48/JD-17-512.png'
                          ),
                          fit: BoxFit.fill
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      //left: 10,
                     // right: 30,
                     // top: 5,
                      bottom: 5,
                    ),
                  child: Text("@"+username, style:TextStyle(fontSize: 22,color: Colors.white
                  ),
                  ),
            ),
                  Text(name, style:TextStyle(color: Colors.white
                  ),
                  ),

                  Text(course, style:TextStyle(color: Colors.white
                  ),
                  ),
                  Text(specialization, style:TextStyle(color: Colors.white
                  ),
                  ),
                  Text(institute, style:TextStyle(color: Colors.white
                  ),
                  ),

                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: InkWell(
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchPeerPage(username,course),
                ));
              },
              child: Text('Find Peers from same course',

                style:TextStyle(fontSize: 18
                ),
              ),
            ),
            // onTap: null,
          ),

          ListTile(
            leading: Icon(Icons.group),
            title: DropdownButton(
              hint: Text(
                  "Find students from different courses",

                style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // dropdownColor: Color.,

              icon: Icon(Icons.arrow_drop_down),
              iconSize: 25,
              isExpanded: true,
              //value: selected,
              onChanged: (newValue){
                setState(() {
                  selected=newValue;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SelectedCoursePage(selected),
                  ));
                });
              },
              items: listCourse.map((valueItem){
                //coursechosen=valueItem.toString();

                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );

              }).toList(),
            ),
            // onTap: null,
          ),

          /*ListTile(
            leading: Icon(Icons.school),
            title: Text('Find Teachers', style:TextStyle(fontSize: 18,
            ),
            ),
            onTap: null,
          ),*/

          ListTile(
            leading: Icon(Icons.video_call),
            title: Text('Your Notes', style:TextStyle(fontSize: 18,
            ),
            ),
            onTap:  null,
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('StudyRoom-Chat', style:TextStyle(fontSize: 18,
            ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(username),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Logout', style:TextStyle(fontSize: 18,
            ),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder:
                          (context) => WelcomePage()),
                      (Route route)=>false
              );
            },
          ),


        ],
      ),

    );

  }
}
