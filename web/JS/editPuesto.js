/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
            let directivo =new Option("Directivo","2");
            selectJer.options[1] = directivo;
            selectJer.options[2] = null;
            break;
        case "DirecciÃ³n general":
            let directivo =new Option("Directivo","2");
            selectJer.options[1] = directivo;
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

function habilitarCampo(ide){
    let campo = document.getElementById(ide);
    campo.disabled = !campo.disabled;
    return false;
}



