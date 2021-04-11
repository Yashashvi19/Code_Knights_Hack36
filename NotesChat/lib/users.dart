import 'package:grp_study/UserStruct.dart';

class Users {
   List<UserStruct> users=[];

   List<UserStruct> joinUser(String roomName,String userName) {
     users.add(new UserStruct(roomName, userName));
    return users;
  }

   List<UserStruct> removeUser(chatId) {
     final index=users.indexOf(chatId);
    if(index != -1){
     users.removeAt(index);
     return users;
    }
  }
}