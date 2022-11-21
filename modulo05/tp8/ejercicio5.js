// OBTENER NOMBRES
const fs = require("fs");
const rawdata = fs.readFileSync("./departamentos.json", "utf8");
var departamentos = JSON.parse(rawdata);


function getEmpleados(arreglo) {
  for (var i = 0; i < arreglo['departamentos']['tecnologia'].length; i++) {
    console.log(arreglo['departamentos']['tecnologia'][i]['nombre'] + " - " + 
                arreglo['departamentos']['tecnologia'][i]['puesto'] + " - trabaja en Tecnología"
    )
  }
}

getEmpleados(departamentos)
