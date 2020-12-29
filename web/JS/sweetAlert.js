/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function confirmation(){
    Swal.fire({
        position: 'top-end',
        title: "Documento correctamente guardado",
        icon:'success',
        showConfirmButton: false,
        timer: 1500
    });
}

function error(){
    Swal.fire({
        position: 'bottom-end',
        title: "Hubo un error",
        text:'Contacte al administrador',
        icon:'error'
    });
}

function copy_link(id){
    navigator.clipboard.writeText(id).then(function() {
    /* clipboard successfully set */
        Swal.fire({
            text:'Comparta el link para poder mostrar este archivo a otros colaboradores de la empresa',
            position: 'top-end',
            icon:'success',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true
        });
    }, function() {
      /* clipboard write failed */
      Swal.fire({
            text:'A sucedido un error contacte al administrador',
            position: 'top-end',
            icon:'error',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true
        });
    });
}

window.onload = function(){
    if (getParameterByName('flag') == 'true') {
        confirmation();
    }else if(getParameterByName('flag') == 'false'){
        error();
    }
}

/**
 * @param String name
 * @return String
 */
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
    results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}