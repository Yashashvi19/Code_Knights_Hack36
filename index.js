// const express = require("express");
// const app = express();
// // var http = require("http").createServer(app);

// const { joinUser, removeUser } = require("./user");
// const PORT = 3000;
// const server = app.listen(PORT, function () {
//   console.log(`Listening on port ${PORT}`);
//   console.log(`http://localhost:${PORT}`);
// });

// var io = require("socket.io")(server);

// // http.listen(PORT);

// // const serverSocket = socket(server);
// // serverSocket.on("connection", function (socket) {
// //   console.log("Made socket connection");
// // });

// // serverSocket.on("join room", (data) => {
// //   console.log("in room");
// //   let newUser = joinUser(Serversocket.id, data.userName, data.roomName);
// //   serverSocket.emit("send-data", {
// //     id: socket.id,
// //     userName: newUser.userName,
// //     roomName: newUser.roomName,
// //   });
// //   room = newUser.roomName;
// //   console.log(room);
// //   socket.join(newUser.roomName);
// // });

const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const io = require("socket.io")(server);
// var socket = io();
const { joinUser, removeUser } = require("./user");
app.get("/", (req, res) => {
  res.send("<h1>Hello world</h1>");
});
server.listen(3000, () => {
  console.log("listening on *:3000");
});
let room = "";
io.on("connection", (socket) => {
  console.log("a user connected");

  socket.on("join room", (data) => {
    data = JSON.parse(data);
    console.log(`in room ${data}`);
    console.log(data);
    let newUser = joinUser(socket.id, data.userName, data.roomName);
    socket.broadcast.emit("user-joined", newUser);
    socket.emit("assign-id", newUser);
    room = newUser.roomName;
    console.log("room" + JSON.stringify(newUser));
    socket.join(newUser.roomName);
  });

  socket.on("send_message", (data) => {
    data = JSON.parse(data);
    console.log(data);
    socket.to(room).emit("chat message", {
      msg: data.msg,
      user: data.user,
      id: data.id,
    });
  });
  socket.on("disconnect", () => {
    const user = removeUser(socket.id);
    console.log(user);
    if (user) {
      console.log(user.username + " has left");
    }
    console.log("disconnected");
  });
});
