import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grp_study/ChatPage.dart';
import 'package:grp_study/UserStruct.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:convert';

import 'message.dart';


class ChatPage extends StatefulWidget {

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
                child: TextFormField(
                  controller: room,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'RoomName',
                  ),),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'userName',
                ),),
              RaisedButton(onPressed: () {
                print("clicked");
                try {
                  createSocketConnection(room.text, name.text);
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) =>
                          new Chat(myObject: socket, userName: name.text,roomName: room.text)));
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