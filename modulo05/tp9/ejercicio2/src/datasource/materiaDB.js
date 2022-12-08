const mysql = require('mysql');
const config = require("../config/config.json");

//conectarnos a nuestra DB
var connection = mysql.createConnection(config.database);

connection.connect((err) => {
    if (err) {
        console.log(err);
    } else {
        console.log("Módulo Materia - DB Conectada correctamente");
    }
});
//fin de conexion db

var materiaDB = {};


materiaDB.getAll = function (funCallback) {
    connection.query("SELECT * FROM materias where estado >=1", function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            funCallback(undefined, result);
        }
    });
}


materiaDB.getIdmateria = function (idmateria,funCallback) {
    connection.query("SELECT * FROM materias WHERE idmateria=?",idmateria, function (err, result, fields) {
        if (err) {
            funCallback({
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            });
            console.error(err);
        } else {
            if(result.length>0){
                funCallback(undefined, result[0]);
            }else{
                funCallback({
                    message: "No se encontró la materia para este ID"
                });
            }
            
        }
    });
}


materiaDB.create = function (materias, funCallback) {
    var query = 'INSERT INTO materias (nombre,objetivo,plan_estudio) VALUES (?,?,?)'
    var dbParams = [materias.nombre, materias.objetivo, materias.plan_estudio];
    connection.query(query, dbParams, function (err, result, fields) {
        if (err) {
                funCallback({
                    message: "Surgio un problema, contactese con un administrador. Gracias",
                    detail: err
                })
                console.error(err);
        } else {
            funCallback(undefined, {
                message: `Se creo la materia ${materias.nombre} - ${materias.objetivo} - ${materias.plan_estudio} `,
                detail: result
            });
        }
    });
}

/**
 * 
 * @param {*} idmateria 
 * @param {*} nombre 
 * @param {*} funCallback 
 *         retorna:
 *              code = 1 (EXITO)
 *              code = 2 (NOT FOUND) (NO encontro elemento)
 *              code = 3 (ERROR)
 * 
 */


materiaDB.logdelete = function (idmateria, funCallback) {
    connection.query("UPDATE materias SET estado = 0 WHERE idmateria = ?",idmateria, function (err, result, fields) {
        if (err) {
            funCallback({
                code:3,
                message: "Surgio un problema, contactese con un administrador. Gracias",
                detail: err
            }); 
            console.error(err);
        } else {
            if (result.affectedRows == 0) {
                funCallback({
                    code:2,
                    message: `No se encontro el id  ${idmateria} del curso`,
                    detail: result
                }); 
            } else {
         //       console.error(err);
                    funCallback({
                    code:1,
                    message: `Se modifico el curso con el id ${idmateria}`,
                    detail: result
                }); 
            }
        }
    });
}

module.exports = materiaDB;