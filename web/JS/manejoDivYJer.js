let selectJer = document.querySelector("#jerarquia");
let selectDiv = document.getElementById("division");
selectJer.style.display = 'none';
function alterarPuestos(){
    let selectJer = document.getElementById("jerarquia");
    let selectDiv = document.getElementById("division");
    let index = selectDiv.selectedIndex;
    let opcion = selectDiv.options[index].value;
    console.log(opcion == "Dirección general");
    switch(opcion){
        case "Dirección general":
            let directivo =new Option("Directivo","2");
            selectJer.options[0] = directivo;
            selectJer.options[1] = null;
            break;
        case "cero":
            selectJer.options[0] = null;
            selectJer.options[1] = null;
            break;
        default:
            let liderDiv =new Option("Jefe de área","3");
            let empleadoG =new Option("Empleado general","4");
            selectJer.options[0] = liderDiv;
            selectJer.options[1] = empleadoG;
            break;
    }
    selectJer.style.display = 'block';
}

