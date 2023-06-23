const express = require('express');

const app = express();

const server = require('http').createServer(app);

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

server.listen(3000, () => {
    console.log('Servidor Conectado');
});
