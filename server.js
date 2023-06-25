var fs = require('fs');

var privateKey  = fs.readFileSync('appscore.ml.key', 'utf8');
var certificate = fs.readFileSync('appscore.ml.crt', 'utf8');
var credentials = {key: privateKey, cert: certificate};

const express = require('express');

const app = express();

//const server = require('http').createServer(app);
const server = require('https').createServer(credentials, app);

const io = require('socket.io')(server, { cors: { origin: " *" } });

io.on('connection', (socket) => {
    console.log('Cliente Socket: ');

    // recivimos el mensaje del cliente y mandamos la respuesta
    socket.on('saludo', (user_id) => {
        console.log(user_id);
        const respuesta = "Welcome " + user_id;
        io.emit('saludo_respuesta', respuesta);
    });

    socket.on('data-diagram', function (data){
       io.emit('data-input', data)
    });

    socket.on('disconnect', () => {
        console.log("Disconnect: " + socket.id);
    });

});

/*server.listen(3000, () => {
    console.log('Servidor Conectado');
});*/

server.listen(3000, () => {
    console.log('Servidor Conectado');
});
