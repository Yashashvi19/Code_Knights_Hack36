 import 'dart:core';

import 'package:flutter/material.dart';

class UserStruct{


  String roomName;
  String  userName;

  UserStruct(this.roomName, this.userName);
  Map<String, dynamic> toJson() {
    return {
      'roomName': roomName,
      'userName': userName,
    };
  }
}
