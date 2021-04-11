import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'CreateNote.dart';

const REGISTER_API_URL = 'http://192.168.43.41:3000/student';
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
                builder: (context) => CreateNote(username),
              ));
            },)
        ],
      ),
    );
  }

}