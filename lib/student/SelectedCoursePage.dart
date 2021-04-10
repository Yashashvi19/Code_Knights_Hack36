import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String course;
const REGISTER_API_URL = 'http://192.168.1.4:3000/student';
class SelectedCoursePage extends StatefulWidget {

  SelectedCoursePage(String _course){
    course = _course;
  }

  @override
  _SelectedCoursePageState createState() => _SelectedCoursePageState();
}

class _SelectedCoursePageState extends State<SelectedCoursePage> {
  //String clgs;
  // String clgchosen;
  List listItem=[];
  String selectedValue;

  Future getList() async {
    var url=REGISTER_API_URL+"/list";
    //StudentDetails studentDetails;
    final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'course':course,
        }));


    setState(() {
      var jsonResponse=convert.jsonDecode(response.body);
      if (response.statusCode == 200)
        print(jsonResponse);
      else print("error");
      listItem=jsonResponse;
      //print(listItem[0]['name']);
    });
  }


  @override
  void initState(){
    super.initState();
    this.getList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students in "+ course+" course"),
      ),
      body: new ListView.builder(
          itemCount: listItem==null? 0:listItem.length,
          itemBuilder: (BuildContext context, i){
            return new ListTile(

              isThreeLine: true,
              title: new Text(listItem[i]["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  new Text("Institute:  "+listItem[i]["institute"]),
                  new Text("Specialization:  "+listItem[i]["specialization"]),
                  new Text("email:  "+listItem[i]["email"]),

                ],
              ),
              //subtitle: new Text("INSTITUTE:  "+listItem[i]["institute"]),
              leading: new CircleAvatar(
                backgroundImage: new NetworkImage('https://cdn1.iconfinder.com/data/icons/instagram-ui-colored/48/JD-17-512.png'),
              ),
              onTap: (){},

            );
          }
      ),

    );

  }
}
