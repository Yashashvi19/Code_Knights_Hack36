import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/chat/Socket.dart';

import 'dart:math' as math;

import 'UserStruct.dart';
import 'message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  var myObject;
  var userName;
  var recieverid;
  var roomName;
  var id;
  Chat({
    this.myObject, this.userName, this.roomName,this.id,this.recieverid
});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages;
  double height, width;
  TextEditingController textController;
  ScrollController scrollController = ScrollController();
  HashMap<String,UserStruct> users;
  HashMap<String,Color> userColors;
  UserStruct u;
  IO.Socket _socket;

  @override
  void initState() {
    // TODO: implement initState
    print("hii");
    int flag=0;
    messages = List<Message>();
    users = HashMap();
    userColors = HashMap();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    print("Connecting to server socket");
    _socket = IO.io('http://192.168.1.6:3000', IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .setExtraHeaders({'foo': 'bar'}) // optional
        .build());
    _socket.onConnect((_) {
      print('connect');
    });
    _socket.emit("join room", jsonEncode({'roomName':widget.roomName,'userName': widget.userName}));
    _socket.on('assign-id',(data) {
      print(data);
      u= UserStruct(data['id'], data['userName'], data['roomName'], Colors.lightBlue[200]);
    });
    _socket.on('user-joined', (data) {

    }
    );
    addUserIfNotPresent(userId,userName){
    if(!users.containsKey(userId)) {
      Color assignedColor = Color(
          (math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      users[userId] = UserStruct(userId, userName, u.roomName, assignedColor);
    }
      }
    _socket.on('chat message', (data) {
      addUserIfNotPresent(data['id'], data['user']);
      this.setState(() {
        messages.add(Message(data['msg'], users[data['id']]));
      });
      // scrollController.animateTo(
      //   scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 600),
      //   curve: Curves.ease,
      // );
    });
    super.initState();
  }

  Widget buildSingleMessage(int index) {
    print( messages[index].sender.id == u.id);
    return Container(
      alignment: messages[index].sender.id == u.id?Alignment.centerLeft:Alignment.centerRight ,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: messages[index].sender.color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            children: [
              Text(
                messages[index].sender.userName,
                style: TextStyle(color: Colors.red[600], fontSize: 10.0),
              ),
              Text(
                messages[index].text,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),

            ]
        ),
      ),
    );
  }

  Widget buildSingleMessageRec(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            children: [
              Text(
                messages[index].sender.userName,
                style: TextStyle(color: Colors.red[600], fontSize: 10.0),
              ),
              Text(
                messages[index].text,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),

            ]
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return
      Container(
        height: height * 0.8,
        width: width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {

                return buildSingleMessage(index);

              },
            ),
          ),
        ),

      );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          //Send the message as JSON data to send_message event
          _socket.emit(
              'send_message', json.encode(
              {'msg': textController.text, 'roomName':widget.roomName, 'user': widget.userName,'id':u.id}));
          //Add the message to the list
          this.setState((){
            messages = [...messages]..add(Message(textController.text, u));
            Timer(Duration(milliseconds: 3000),() {
              print("scrolled");
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            });
          });
          textController.text = '';
          // Scrolldown the list to show the latest message
          //   scrollController.position.maxScrollExtent,

        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return MaterialApp(
        home: Scaffold(
          // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(widget.roomName.toString()),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  buildMessageList(),
                  buildInputArea(),
                ],
              ),
            )
        )
    );
  }

  int sender(String id) {
    if (widget.id==null||id==null) {

         return 1;
    }
   else if(id.compareTo(widget.id) == 0){
     return 1;
   }
      return 0;

  }

  // @override
  // void dispose() {
  //   print("emitting disconnect");
  //   _socket.disconnect();
  //   super.dispose();
  // }
}