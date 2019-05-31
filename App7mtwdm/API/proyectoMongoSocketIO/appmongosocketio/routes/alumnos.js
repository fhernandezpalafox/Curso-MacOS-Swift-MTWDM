var express = require('express');
var router = express.Router();

const MongoClient = require("mongodb").MongoClient;
const url  = "mongodb://localhost:27017";
const dbName = "BDPrueba1";

var ObjectId = require("mongodb").ObjectId;


router.get('/v1/api/getAllAlumnos',function(req, res, next) {
  
    MongoClient.connect(url, function(err,client){
        if (err) throw err;

        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        var query = {};

        db.collection("alumnos").find(query).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);

            client.close();
        });
    
   });

});

router.get('/v1/api/getAlumno/:id', function(req, res, next) {
     
    console.log(req.params.id);
    var oId = new ObjectId(req.params.id);
    var query = {"_id": oId};

    console.log(query);

    MongoClient.connect(url, function(err,client){
        if (err) throw err;
        
        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        db.collection("alumnos").find(query).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);
            
            client.close();
        });
    
   });

});

router.post('/v1/api/addAlumno', function(req, res, next) {
  
   var nombre = req.body.nombre;
   var apellido = req.body.apellido;
   var edad = req.body.edad;
   var ciudad =  req.body.ciudad;


   MongoClient.connect(url, function(err,client){
    if (err) throw err;

    console.log("Connected correctly to server");
   
    const db = client.db(dbName);

    var query = {"nombre":nombre,"apellido":apellido,"edad":edad,"ciudad":ciudad};

    db.collection("alumnos").insert(query,function(err,result){
        if (err) throw err;

        console.log(result);

        res.json(result);

        client.close();
    });

});

});

router.put('/v1/api/updateAlumno', function(req, res, next) {
  
    var nombre = req.body.nombre;
    var apellido = req.body.apellido;
    var edad = req.body.edad;
    var ciudad =  req.body.ciudad;
    var id = req.body.id;
    
    var oId = new ObjectId(id);
    var query = {"_id": oId};

    MongoClient.connect(url, function(err,client){
     if (err) throw err;
 
     console.log("Connected correctly to server");
    
     const db = client.db(dbName);
 
     var valores = {"nombre":nombre,
                    "apellido":apellido,
                    "edad":edad,"ciudad":ciudad};
 
     db.collection("alumnos").update(query,valores,function(err,result){
         if (err) throw err;
 
         console.log(result);
         
         res.json(result);
 
         client.close();
     });
 
 });

});

 router.delete('/v1/api/deleteAlumno/:id', function(req, res, next) {
  

    console.log(req.params.id);
    var oId = new ObjectId(req.params.id);
    var query = {"_id": oId};

    console.log(query);

    MongoClient.connect(url, function(err,client){
        if (err) throw err;
        
        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        db.collection("alumnos").deleteOne(query,function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);
            
            client.close();
        });
    
   });

});

module.exports = router;
