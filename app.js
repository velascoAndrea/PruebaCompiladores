$(document).ready(function() {
    $("#btnejecutarcodigo").click(function() {
        try {
            raiz = gramatica.parse(`${editor.getValue()}`);
            /**Evaluar[1+1];
               Evaluar[1+1*2];
               Evaluar[-(1+1*6/3-5+7)];
               Evaluar[-(1+1*6/3-5+1*-2)];
               Evaluar[-(1.6+1.45)]; */
            //var result = gramatica.parse(`${editor.getValue()}`);
            //console.log(editor.getValue());
            // editor2.setValue(result.toString());
            console.log(raiz);

            construirarbol();
            //alert("El resultado es :" + result);
            //$("#myTextarea2").val(result.toString());
        } catch (e) {
            alert("Error en algun lado del programa");
        }
    });
});

//https://developer.mozilla.org/es/docs/Web/JavaScript/Referencia/Classes

const children = [];
var raiz;
const url_node = "https://201503378.loca.lt/";
class Nodo {
    constructor(token, valor, fila, columna, idNodo) {
        this.token = token;
        this.valor = valor;
        this.fila = fila;
        this.columna = columna;
        this.idNodo = idNodo;
    }

    addHijo(hijo) {
        children.push(hijo);
    }
}

function construirarbol() {
    var cadena = "hola hola";
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("POST", url_node + 'escibir/' + cadena, true);
    xmlhttp.send();


    //    var xhr = new XMLHttpRequest();

    //  xhr.open('GET', 'http://192.168.1.22:3000/AST', true);
    /** 
    xhr.onloadend = function() {
        var img = new Image();
        var response = xhr.responseText;
        var binary = ""

        for (i = 0; i < response.length; i++) {
            binary += String.fromCharCode(response.charCodeAt(i) & 0xff);
        }

        img.src = 'data:image/jpeg;base64,' + btoa(binary);
        var canvas = document.getElementById('showImage');
        var context = canvas.getContext('2d');

        context.drawImage(img, 0, 0);
        //var snapshot = canvas.toDataURL("image/png");
        //var twinImage = document.getElementById('twinImg');
        // twinImage.src = snapshot;

    }

    xhr.overrideMimeType('text/plain; charset=x-user-defined');
    xhr.send() */
    window.open(url_node + '/AST', '_blank');
}