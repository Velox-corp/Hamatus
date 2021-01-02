let selectJer = document.querySelector("#jerarquia");
console.log(selectJer);
let selectDiv = document.getElementById("division");
selectJer.style.display = 'none';
function alterarPuestos(){
    let selectJer = document.getElementById("jerarquia");
    let selectDiv = document.getElementById("division");
    let index = selectDiv.selectedIndex;
    let opcion = selectDiv.options[index].value;
    console.log(opcion);
    selectJer.style.display = 'block';
    if(opcion=="Dirección General"){
        let directivo =new Option("Directivo","2");
        selectJer.options[0] = directivo;
        selectJer.options[1] = null;
    }else{
        let liderDiv =new Option("Lider Division","3");
        let empleadoG =new Option("Empleado General","4");
        selectJer.options[0] = liderDiv;
        selectJer.options[1] = empleadoG;
    }
}

