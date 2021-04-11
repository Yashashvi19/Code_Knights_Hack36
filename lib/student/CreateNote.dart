
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:study_hub/student/YourNotes.dart';
import 'package:zefyr/zefyr.dart';
import 'package:http/http.dart' as http;

const _API_URL = 'http://192.168.1.100:3000/student';
String username;

class CreateNote extends StatefulWidget {

  CreateNote(String _username){
    username=_username;
  }

  //WelcomePage({Key key}) : super(key:key);
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  ZefyrController _controller;
  FocusNode _focusNode;
  TextEditingController _textFieldController = TextEditingController();
  String topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ZefyrScaffold(
          child: ZefyrEditor(
            padding: EdgeInsets.all(5),
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context){
          return FloatingActionButton(
              child: Icon(Icons.save),
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AlertDialog(
                        title: Text("Save your note"),
                        content: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                              hintText: "Enter the topic"),),
                        actions: <Widget>[
                          FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: Text('Confirm'),
                              onPressed: () {
                                setState(() {
                                  topic=_textFieldController.text;
                                  save(topic);
                                });
                              }
                            //save(),
                          )
                        ])));
              });
        },
      ),
    );
  }

  @override
  void initState(){
    final document=_loadDocument();
    _controller=ZefyrController(document);
    _focusNode=FocusNode();
  }

  NotusDocument _loadDocument(){
    final Delta delta=Delta()..insert("Insert text here\n");
    return NotusDocument.fromDelta(delta);
  }

  void save(String topic) async {
    final content=jsonEncode(_controller.document).toString();
    var url2 = _API_URL+"/saveNote";
    try {
      final http.Response response = await http.post(url2,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'content': content,
            'topic': topic
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final snackBar = SnackBar(
            content: Text("Note Saved"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => YourNotes(username)));
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
      } else {
        final snackBar = SnackBar(
            content: Text("Something went wrong"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    catch(Exception){
      print(Exception);
    }
  }

}