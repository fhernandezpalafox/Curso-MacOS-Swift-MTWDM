var express = require('express');
var router = express.Router();


const MongoClient = require("mongodb").MongoClient;
const url  = "mongodb://localhost:27017";
const dbName = "BDPrueba1";

var ObjectId = require("mongodb").ObjectId;

var prettyjson = require('prettyjson');

router.get('/v1/api/getMaterias',function(req, res, next) {
  
    MongoClient.connect(url, function(err,client){
        if (err) throw err;

        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        var query = {};

        db.collection("materias").find(query).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            
            res.json(result);

            client.close();
        });
    
   });

});



router.get('/v1/api/getUniversidades',function(req, res, next) {
  
    MongoClient.connect(url, function(err,client){
        if (err) throw err;

        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        var query = {};

        db.collection("universidades").find(query).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);

            client.close();
        });
    
   });

});


router.get('/v1/api/getUniversidadesAlumnos',function(req, res, next) {
  
    MongoClient.connect(url, function(err,client){
        if (err) throw err;

        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        var query = {};

        db.collection("alumnos").aggregate(
            [
               {
                $lookup: {
                    from: "universidades",
                    localField: "_idUniversidades",
                    foreignField: "_id",
                    as: "universidades"
                 }
               } 
            ]
        ).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);

            client.close();
        });
    
   });

});


router.get('/v1/api/getMateriasAlumnos',function(req, res, next) {
  
    MongoClient.connect(url, function(err,client){
        if (err) throw err;

        console.log("Connected correctly to server");
       
        const db = client.db(dbName);

        var query = {};

        db.collection("materiasAlumnos").aggregate(
            [
                {
                    $lookup: {
                        from: "materias",
                        localField: "idMateria",
                        foreignField: "_id",
                        as: "dbmateria"
                    }
                },
                {
                    $lookup: {
                        from: "alumnos",
                        localField: "idAlumno",
                        foreignField: "_id",
                        as: "dbalumno"
                    }
                } 
            ]
        ).toArray(function(err,result){
            if (err) throw err;

            console.log(result);
            res.json(result);

            client.close();
        });
    
   });

});

module.exports = router;