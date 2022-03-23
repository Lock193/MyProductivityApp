const ObjectID = require('mongodb').Db
const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./noteSchema')
var Login =require('./loginSchema') 
var loginSuccessful = true

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", () => {
    console.log("Connected to DB!")
}).on("error", (error) => {
    console.log("Failed to connect " + error)
})

//POST request
//Login
app.post("/login", (req,res) => {
    //console.log("id:" + req.get("id"))
    Login.findOne({
        username: req.get("username"),
        password: req.get("password")
    }, function (err, obj) {
        if (err || obj==null){
            res.send("Failed")
        }
        else{
            res.send("OK")
        }
    });
    /*Login.findOne({
        username: req.get("username"),
        password: req.get("password")
    }, (err) => {
        console.log("Failed " + err)
        loginSuccessful=false
    })
    if (loginSuccessful) res.send("OK")
    else res.send("Failed")*/
    
})

//CREATE A NOTE
//POST request
app.post("/create", (req,res) => {
    console.log("ss:" + req.get("note"))
    var note = new Data ({

        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date"),
        folder: req.get("folder")
    })

    note.save().then(() => {

        if(note.isNew == false) {
            console.log("Saved data!")
            res.send("Saved data!")
        } else {
            console.log("Failed to save data")
        }
    })

})

// http://192.168.86.250:8081/create
// 192.168.86.34 for mini mac
var server = app.listen(8081, "192.168.86.250", () => {
    console.log("Server is running!")

})


//FETCH ALL NOTES
//GET request
app.post("/fetch", (req,res) => {
    Data.find({}, function (err, obj) {
        if (err || obj==null){
            res.send("Failed")
        }
        else{
            res.send(obj)
        }
    })
})

//DELETE A NOTE
//POST request
app.post("/delete", (req,res) => {
    console.log("id:" + req.get("id"))
    Data.findOneAndRemove({
        _id: req.get("id")
    }, (err) => {
        console.log("Failed " + err)
    })
    res.send("Deleted!")
    
})

//UPDATE A NOTE
//POST request
app.post('/update', (req,res) => {
    Data.findOneAndUpdate({
        _id: req.get("id")
    }, {
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date"),
        folder: req.get("folder")
    }, (err) => {
        console.log("Failed to update " + err)
    })
    res.send("Updated!")
})