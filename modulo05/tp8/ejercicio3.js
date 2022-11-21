// a) Al utilizar JSON.stringify la salida es ilegible. Para que sea legible habría que agregar la opción de salitda de codificación UTF-8 en la función fs.readFile.
// b) Al utilizar console.log(data) a salida es de tipo binaria, en la manera que se alamcenaría en memoria.
"use strict";
const fs = require("fs");
fs.readFile("personas.json", (err, data) => {
  if (err) throw err;
  // console.log(JSON.parse(data));
  //console.log(JSON.stringify(data));
  console.log(data);
});


