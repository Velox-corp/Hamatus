
function habilitarCampo(ide){
    let campo = document.getElementById(ide);
    campo.disabled = !campo.disabled;
}

function alterarPuestos(){
    let selectJer = document.getElementById("newPriv");
    let selectDiv = document.getElementById("newDiv");
    let index = selectDiv.selectedIndex;
    let opcion = selectDiv.options[index].value;
    switch(opcion){
        case "Direccion general":
            let directivo =new Option("Directivo","2");
            selectJer.options[1] = directivo;
            selectJer.options[2] = null;
            break;
        case "Dirección general":
            let directivoprima =new Option("Directivo","2");
            selectJer.options[1] = directivoprima;
            selectJer.options[2] = null;
            break;
        case "DirecciÃ³n general":
            let directivobiprima =new Option("Directivo","2");
            selectJer.options[1] = directivobiprima;
            selectJer.options[2] = null;
            break;
        case "0":
            selectJer.options[1] = null;
            selectJer.options[2] = null;
            break;
        default:
            let liderDiv =new Option("Jefe de área","3");
            let empleadoG =new Option("Empleado general","4");
            selectJer.options[1] = liderDiv;
            selectJer.options[2] = empleadoG;
            break;
    }
    selectJer.style.display = 'block';
}


