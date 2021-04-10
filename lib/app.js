const express = require("express");
var router = express.Router();
var mongoose = require("mongoose");
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

app.listen(port, () => {
  console.log(`Listening at port : ${port}`);
});
