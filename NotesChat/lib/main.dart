
import 'package:flutter/material.dart';
import 'Client.dart';

void main() {
  runApp(MaterialApp(home: Home(),
    routes: <String, WidgetBuilder>{
      '/Client': (BuildContext context) => new ChatPage(),
    },));

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test-User'),centerTitle: true),
      body: Column(
        children: [
          Feature(name:"MENU",buildcontext: context),
          Feature(name : "CLIENT",buildcontext: context,page:'/Client'),
        ],
      ),
    );
  }
}

Widget Feature({String name,BuildContext buildcontext,String page}){
  return Card(
      margin:EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side:BorderSide(color: Colors.cyan[300],)
      ),
      child: new InkWell(
        onTap:(){
          Navigator.of(buildcontext).pushNamed(page);
        },
        child:Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),

            child: (
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children :[Text(name,textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Colors.black,
                      fontSize:20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  ],)
            ),
          ),
        ),
      )
  );
}



