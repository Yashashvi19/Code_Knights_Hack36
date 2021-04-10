var mongoose = require("mongoose");
var crypto = require("crypto");
//Define a schema
var Schema = mongoose.Schema;
const ObjectId = mongoose.Schema.Types.ObjectId;

var StudentSchema = new Schema({
  email: String,
  password: String,
  username: String,
  name: String,
  course: String,
  specialization: String,
  institute: String,
  //isverified: { type: Boolean, default: false },
 // token: { type: String },
});

var Student = mongoose.model("Students", StudentSchema);
module.exports = Student;
