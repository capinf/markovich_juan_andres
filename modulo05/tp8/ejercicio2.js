// Al utilizar JSON.stringify la salida es de una sola línea. Sin embargo haciendo un console log del archivo JSON la salida es idéntica a la del archivo.
'use strict';
let jsonData = require('./personas.json');
// console.log(jsonData);
console.log(JSON.stringify(jsonData));

