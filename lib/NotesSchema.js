var mongoose = require("mongoose");
var crypto = require("crypto");
//Define a schema
var Schema = mongoose.Schema;
const ObjectId = mongoose.Schema.Types.ObjectId;

var NotesSchema = new Schema({
  username: String,
  content: String,
});

var Note = mongoose.model("Notes", NotesSchema);
module.exports = Note;
