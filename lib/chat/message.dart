
import 'UserStruct.dart';

class Message{
   String text;
   UserStruct sender;

  Message(this.text,this.sender);

   Map<String, dynamic> toJson() {
     return {
       'msg': text,
       'sender': sender,
     };
   }
  Message.fromJson(Map<String, dynamic> json)
      : text = json['msg'],
        sender = json['user'];

}