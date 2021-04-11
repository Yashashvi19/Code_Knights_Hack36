const express = require("express");
var router = express.Router();
var mongoose = require("mongoose");
const http = require("http");
const { joinUser, removeUser } = require("./user");

//var signin = require("./signin");
//Set up default mongoose connection
var mongoDB = "mongodb://127.0.0.1/Study_Hub";
mongoose.connect(mongoDB, { useNewUrlParser: true, useUnifiedTopology: true });

var student = require("./Student");

var app = express();
//middleware
app.use(express.json());
app.use("/student", student);
//app.use("/", signin);
const port = process.env.port || 3000;

const server = http.createServer(app);
const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log("a user connected");

  socket.on("join room", (data) => {
    data = JSON.parse(data);
    console.log(`in room ${data}`);
    console.log(data);
    let newUser = joinUser(socket.id, data.userName, data.roomName);
    socket.broadcast.emit("user-joined", newUser);
    socket.emit("assign-id", newUser);
    let room = newUser.roomName;
    console.log("room" + JSON.stringify(newUser));
    socket.join(newUser.roomName);
  });

  socket.on("send_message", (data) => {
    data = JSON.parse(data);
    console.log(data);
    socket.to(data.roomName).emit("chat message", {
      msg: data.msg,
      user: data.user,
      id: data.id,
    });
  });
  socket.on("disconnect", () => {
    // socket.disconnect(true);
    const user = removeUser(socket.id);
    console.log(user);
    if (user) {
      console.log(user.username + " has left");
    }
    console.log("disconnected");
  });
});

server.listen(port, () => {
  console.log(`Listening at port : ${port}`);
});
