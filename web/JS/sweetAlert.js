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

function confirmation_del(){
    Swal.fire({
        position: 'top-end',
        title: "Documento correctamente borrado",
        icon:'success',
        showConfirmButton: false,
        timer: 1500
    });
}

function error(){
    Swal.fire({
        
        title: "Hubo un error",
        text:'Contacte al administrador',
        icon:'error'
    });
}

function wrong_pass(){
    Swal.fire({
        title: "Contraseña incorrecta",
        text:'Ingrese otra vez la contraseña',
        icon:'error'
    });
}

function copy_link(id){
    const text = window.location.host + "/Hamatus/" + id;
    console.log(text);
    navigator.clipboard.writeText(text).then(function() {
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

function deleteFile(id_m, fileName){
    Swal.fire({
        title: 'Estas seguro de que quieres borrar el archivo?',
        text: "Recuerda que no podras recuperarla",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si por favor',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
          window.location = "deleteFile?id_M="+id_m+"&fileName="+fileName;
        }
    });
}

window.onload = function(){
    if (getParameterByName('flag') == 'true') {
        confirmation();
    }else if(getParameterByName('flag') == 'false'){
        error();
    }else if(getParameterByName('flag_del') == 'false'){
        error();
    }else if(getParameterByName('flag_del') == 'true'){
        confirmation_del();
    }else if(getParameterByName('flag') == 'exist'){
        Swal.fire({
            title:"Lo sentimos, el archivo ya existe",
            icon:'warning'
        });
    }else if(getParameterByName('flag') == 'wrong_pass'){
        wrong_pass();
    }else if(getParameterByName('flag') == 'true_pass'){
        var pass = getParameterByName('pass');
        Swal.fire({
        position: 'top-end',
        title: "Documento correctamente guardado",
        text:"La contraseña es:" + pass,
        icon:'success',
    });
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