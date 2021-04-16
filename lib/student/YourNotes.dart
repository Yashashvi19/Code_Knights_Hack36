
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'CreateNote.dart';

const REGISTER_API_URL = 'http://192.168.1.4:3000/student';
String username;

class YourNotes extends StatefulWidget {

  YourNotes(String _username){
    username=_username;
  }

  //WelcomePage({Key key}) : super(key:key);
  @override
  _YourNotesState createState() => _YourNotesState();
}

class _YourNotesState extends State<YourNotes> {
  List listItem=[];

  Future getList() async {
    var url=REGISTER_API_URL+"/findNotes";
    //StudentDetails studentDetails;
    final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'username':username,
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
        title: Text("Your Notes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed:() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateNote(username,""),
              ));
            },)
        ],
      ),
      body: new ListView.builder(
          itemCount: listItem==null? 0:listItem.length,
          itemBuilder: (BuildContext context, i){
            return new ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  new Text(listItem[i]["topic"])
                ],),
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateNote(username,listItem[i]["content"]),
                ));
              },

            );
          }
      ),
    );
  }

}