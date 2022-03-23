var mongoose = require("mongoose")
var Schema = mongoose.Schema

var login = new Schema({
    username: String,
    password: String
})

var Login = mongoose.model("login",login)
//
module.exports = Login