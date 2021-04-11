import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:study_hub/chat/ChatPage.dart';
String course;
String _username;

const REGISTER_API_URL = 'http://192.168.1.6:3000/student';
class SearchPeerPage extends StatefulWidget {

  SearchPeerPage(String username,String _course){
    course = _course;
    _username = username;
  }

  @override
  _SearchPeerPageState createState() => _SearchPeerPageState();
}

class _SearchPeerPageState extends State<SearchPeerPage> {
  //String clgs;
 // String clgchosen;
  List listItem=[];
   String selectedValue;

 Future getList() async {
    var url=REGISTER_API_URL+"/list";
    //StudentDetails studentDetails;
    print(course);
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
          title: Text('Students in the same course'),
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

                new Text("MailId:  "+listItem[i]["email"]),

              ],
            ),
            //new Text("INSTITUTE:  "+listItem[i]["institute"]),
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage('https://cdn1.iconfinder.com/data/icons/instagram-ui-colored/48/JD-17-512.png'),
            ),
          onTap: (){
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (__){
                      var jUsers = [];
                      jUsers.add(_username);
                      jUsers.add(listItem[i]['username']);
                      jUsers.sort();
                      String roomname = jUsers.join("-");

                     return new Chat(userName:_username,roomName:roomname);
          }));

          },

          );
          }
      ),

    );

  }
}
