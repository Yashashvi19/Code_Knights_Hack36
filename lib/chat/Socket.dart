// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class Socket {
//  static IO.Socket? _socket;
//   static getSocket(){
//     if(_socket == null){
//       _socket = IO.io('http://192.168.1.6:3000', IO.OptionBuilder()
//           .setTransports(['websocket']) // for Flutter or Dart VM
//           .setExtraHeaders({'foo': 'bar'}) // optional
//           .build());
//       _socket.onConnect((_) {
//         print('connect');
//       });
//     }
//     return _socket;
//   }
// }