

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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated,
                ),
              ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Text(
                  'Any student from any corner of the world is just a click away.\nStart a discussion on any topic, '+
                  'discuss your doubts and much more!',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                SizedBox(
                  //height: 10,
                  height: 40,
                ),
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
              ]
            )
          )
          );
    
  }
  
}


