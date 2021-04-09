class Message{
   String text;
   String sender;

  Message(this.text,this.sender);
  Message.fromJson(Map<String, dynamic> json)
      : text = json['msg'],
        sender = json['user'];

}