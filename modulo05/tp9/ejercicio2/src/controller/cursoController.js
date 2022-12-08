require("rootpath")();
const express = require('express');
const app = express();

const cursoDb = require("../datasource/cursoDb.js");


app.get('/', getAll);

app.get('/:idcurso', getIdcurso);

app.post('/', create);

app.delete('/:idcurso', eliminacionlogica);

// Metododo para listar todas los cursos 
function getAll(req, res) {
    cursoDb.getAll(function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para buscar cursos por su id
function getIdcurso(req, res) {
    cursoDb.getIdcurso(req.params.idcurso,function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo para agregar cursos
function create(req, res) {
    cursoDb.create(req.body, function (err, result) {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(result);
        }
    });
}


// Metodo par eliminar personas cambiando el estado a 0
function eliminacionlogica(req, res) {
    cursoDb.logdelete(req.params.idcurso, function (result) {
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