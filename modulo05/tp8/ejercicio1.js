// Cuando utilizamos JSON.parse el contenido de la salida es legible, sin embargo con JSON.stringify (sin especificar en el tipo de codificación en la función readFileSync) la salida de la consulta es en forma JSON pero no es legible o útil para el humano.

const fs = require('fs');
let rawdata = fs.readFileSync('./personas.json');
// let persona = JSON.parse(rawdata);
// console.log(persona);
console.log(JSON.stringify(rawdata));