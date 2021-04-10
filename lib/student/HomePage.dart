

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/student/DashboardDrawer.dart';
import 'package:study_hub/student/StudentDetails.dart';

import 'JoinMeeting.dart';
class HomePage extends StatelessWidget{
  StudentDetails details;
  HomePage(StudentDetails detials){
    this.details=detials;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
      ),
          drawer: DashboardDrawer(details),
          body: Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartMeeting(details)));
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            "Start a discussion",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JoinMeeting(details)));
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: Center(
                          child: Text(
                            "Join a discussion",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Welcome to the Dashboard!',
                  style: TextStyle(
                  ),
                ),

              ]
            )
          )
          );
    
  }
  
}


