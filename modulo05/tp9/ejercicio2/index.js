require("rootpath")();
const express = require('express');
const app = express();
const morgan = require('morgan');
const config = require("./src/config/config.json");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan('tiny'));
morgan(':method :url :status :res[content-length] - :response-time ms');
  


app.get("/", function (req, res) {
    res.send("ALPHA-SILICON");
});

const personaCont = require("./src/controller/personaController.js");
const cursoCont = require("./src/controller/cursoController.js");
const materiaCont = require("./src/controller/materiaController.js");
const sedeCont = require("./src/controller/sedeController.js");
const usuarioCont = require("./src/controller/usuarioController.js");

app.use("/api/persona",personaCont);
app.use("/api/curso",cursoCont);
app.use("/api/materia",materiaCont);
app.use("/api/sede",sedeCont);
app.use("/api/usuario",usuarioCont);

/*
const userCont = require("userController.js");
app.use("/api/usuario",userCont);
*/

app.listen(config.server.port, function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log(`Server iniciado en puerto:${config.server.port}`);
    }
});
