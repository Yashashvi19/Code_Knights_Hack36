import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:convert';

import 'ChatPage.dart';


class ChatPage extends StatefulWidget {
var _username;

ChatPage(this._username);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  IO.Socket socket;
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController;
  final TextEditingController name = TextEditingController();
  final TextEditingController room = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'), centerTitle: true,
        ),
        body: Container(
          height: 300.0,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0,100.0,20.0,40.0),
                  child: TextFormField(
                    controller: room,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'RoomName',
                    ),),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              RaisedButton(
                  child:Text("Create Room"),
                  onPressed: () {
                print("clicked");

                try {
                  createSocketConnection(room.text, widget._username);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) =>
                  new Chat(userName:widget._username,roomName:room.text)));
                  // init();
                }
                catch (e) {
                  print("Error");
                }
              }),
            ],


          ),
        )
    );
  }

  createSocketConnection(room,name) {
    socket = IO.io('http://192.168.1.6:3000', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .setExtraHeaders({'foo': 'bar'}) // optional
        .build());
    socket.onConnect((_) {
      print('connect');
      socket.emit("join room", jsonEncode({'roomName':room,'userName': name}));
    });
    socket.on('event', (data) => print(data));
    socket.on('connect', (data) => print(data));
    socket.on('error', (data) => print(data));
    socket.on('connect_error', (data) => print(data));
    socket.on('connect_timeout', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

}