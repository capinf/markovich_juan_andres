require("rootpath")();
const express = require('express');
const app = express();

const materiaDB = require("../datasource/materiaDB.js");


app.get('/', getAll);

app.get('/:idmateria', getIdmateria);

app.post('/', create);

app.delete('/:idmateria', eliminacionlogica);

// Metododo para listar todas los cursos 
function getAll(req, res) {
    materiaDB.getAll(function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para buscar cursos por su id
function getIdmateria(req, res) {
    materiaDB.getIdmateria(req.params.idmateria,function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para agregar cursos
function create(req, res) {
    materiaDB.create(req.body, function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo par eliminar personas cambiando el estado a 0
function eliminacionlogica(req, res) {
    materiaDB.logdelete(req.params.idmateria, function (result) {
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