 import 'dart:core';

import 'package:flutter/material.dart';

class UserStruct{


  String _roomName;
  String  _userName;
   String _id;
   Color _color;

  String get id => _id;

  UserStruct(this._id,this._userName,this._roomName,this._color);

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'roomName': _roomName,
      'userName': _userName,
    };
  }

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get roomName => _roomName;

  set roomName(String value) {
    _roomName = value;
  }
}
