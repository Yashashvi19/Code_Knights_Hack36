const express = require("express");
var router = express.Router();

//var crypto = require("crypto");
var nodemailer = require("nodemailer");

var Student = require("./StudentSchema");

var Note = require("./NotesSchema");
var mongoose = require("mongoose");

var url = `mongodb://localhost:27017/`;

router.route("/signup").post((req, res) => {
//console.log("name");
  Student.findOne({ email: req.body.email }, function (err, user) {
    if (err) {
    }
    if (user) {

      return res.status(400).send({
        msg: "The email address is already associated with other account ",
      });
    }
  Student.findOne({ username: req.body.username }, function (err, user) {
    if (err) {
    }
    if (user) {

      return res.status(401).send({
        msg: "The username is already associated with other account ",
      });
    }
    Student.create(
      {
        email: req.body.email,
        username: req.body.username,
        password: req.body.password,
       // token: crypto.randomBytes(16).toString("hex"),
        name: req.body.name,
        course: req.body.course,
        specialization: req.body.specialization,
        institute: req.body.institute
      },
      (err, result) => {
        if (err) {
          console.log(err);
          return err;
        }
        res.json(result);
      }
    );
  });
  });
});

router.route("/signin").post((req, res) => {
  Student.findOne({ username: req.body.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result === null) {
      return res.status(403).json({msg: "Incorrect username"});
    }
    if (result.password === req.body.password) {
      res.status(200).json({
        result,
        msg: "success"
      } );
    } else {
      res.status(402).json({msg: "password is incorrect"});
    }
  });
});

router.route("/list").post((req, res) => {
  Student.find({course: req.body.course}, (err, result) => {
    if (err) return res.status(500).json({ msg: err});
    if (result === null) {
      return res.status(403).json({msg: "error"});
    }
    console.log(result);
       return res.status(200).json(result);

  });
});




var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'goyal2000yashashvi@gmail.com',
    pass: '12345678'
  }
});




router.route("/sendMail").get((req,res) => {
  Student.find({course: req.body.course},{projection:{password:0}},(err,result)=>{
    if(err) return res.status(500).json({msg: err});
    if(result==null){
      return res.status(404).json({msg: "no such results found"});
    }
    console.log(result);
    //return res.json(result);
    result.forEach(function(record){
      if(record.username!=req.body.username){

      var mailOptions = {
        from: 'goyal2000yashashvi@gmail.com',
        to: record.email,
        subject: 'Invitation to join a discussion',
        text: req.body.username + "has started a discussion on the topic " + req.body.topic + " You "+
        "can join the discussion with meeting room: -"+req.body.room
      };

      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
          return res.json({msg: "success"});
        }
      });
    }
    });
  });
});


router.route("/saveNotes").post((req, res) => {
//console.log("name");
    Note.create(
      {
        username: req.body.username,
        content: req.body.content,
       },
      (err, result) => {
        if (err) {
          console.log(err);
          return err;
        }
        res.json(result);
      }
    );
  });


router.route("/findNotes").post((req, res) => {
  Note.find({username: req.body.username}, (err, result) => {
    if (err) return res.status(500).json({ msg: err});
    if (result === null) {
      return res.status(403).json({msg: "error"});
    }
    console.log(result);
       return res.status(200).json(result);

  });
});

module.exports = router;