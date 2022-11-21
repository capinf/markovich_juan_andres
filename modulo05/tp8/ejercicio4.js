// OBTENER NOMBRES
const fs = require("fs");
const rawdata = fs.readFileSync("./personas.json", "utf8");
var persona = JSON.parse(rawdata);


function getNombre(arreglo) {
  for (var i = 0; i < arreglo["personas"].length; i++) {
    let NuevoArreglo = arreglo["personas"][i]["localidad"];
    if (arreglo["personas"][i]["localidad"] === "Posadas") {
      console.log(
        arreglo["personas"][i]["nombre"] +
          " " +
        arreglo["personas"][i]["apellido"] +
          " Vive en " +
        arreglo["personas"][i]["localidad"]
      );
    }
  }
}

getNombre(persona);
