require("rootpath")();
const express = require('express');
const app = express();

const sedeDb = require("../datasource/sedeDb.js");


app.get('/', getAll);

app.get('/:idsede', getIdsede);

app.post('/', create);

app.delete('/:idsede', eliminacionlogica);

// Metododo para listar todas los sedes 
function getAll(req, res) {
    sedeDb.getAll(function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para buscar sedes por su id
function getIdsede(req, res) {
    sedeDb.getIdsede(req.params.idsede,function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para agregar sedes
function create(req, res) {
    sedeDb.create(req.body, function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo par eliminar personas cambiando el estado a 0
function eliminacionlogica(req, res) {
    sedeDb.logdelete(req.params.idsede, function (result) {
        if (result.code == 3) {
            res.status(500).send(err);
        } else if (result.code == 2) {
                res.status(404).json(result);  
        } else if (result.code == 1) {      
            res.json(result);
        }
    });
}

module.exports = app;