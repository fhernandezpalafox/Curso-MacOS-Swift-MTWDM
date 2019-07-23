// Setup basic express server
var express = require('express');
var app = express();
var path = require('path');
var server = require('http').createServer(app);
var io = require('socket.io')(server);
var port = process.env.PORT || 3000;

const uuidv1 = require('uuid/v1');


// Load the full build.
var _ = require('lodash');
// Load the core build.
var _ = require('lodash/core');
// Load the FP build for immutable auto-curried iteratee-first data-last methods.
var fp = require('lodash/fp');

// Load method categories.
var array = require('lodash/array');
var object = require('lodash/fp/object');


server.listen(port, () => {
  console.log('Server listening at port %d', port);
});

// Routing
app.use(express.static(path.join(__dirname, 'public')));

// Chatroom
io.on('connection', (socket) => {
  var addedUser = false;

  // when the client emits 'new message', this listens and executes
  socket.on('new message', (data) => {
    // we tell the client to execute 'new message'
    socket.broadcast.emit('new message', {
      username: socket.username,
      message: data
    });
  });

  // when the client emits 'add user', this listens and executes
  socket.on('add user', (username) => {
    if (addedUser) return;

 
    //Se agrega este codigo adicional
    var  idUnico =  uuidv1();

    var objUser = {
      id:idUnico,
      usuario:username
    };
 
    listaUsuarios.push(objUser);

    socket.emit('usuariosConectados', {
      usuariosConectados: listaUsuarios
    });

    // we store the username in the socket session for this client
    socket.username = username;
    addedUser = true;

    socket.emit('login', {
      numUsers: listaUsuarios.length
    });
    // echo globally (all clients) that a person has connected
    socket.broadcast.emit('user joined', {
      username: socket.username,
      numUsers: listaUsuarios.length
    });

  });

  // when the client emits 'typing', we broadcast it to others
  socket.on('typing', () => {
    socket.broadcast.emit('typing', {
      username: socket.username
    });
  });

  // when the client emits 'stop typing', we broadcast it to others
  socket.on('stop typing', () => {
    socket.broadcast.emit('stop typing', {
      username: socket.username
    });
  });

  // when the user disconnects.. perform this
  socket.on('disconnect', () => {
    if (addedUser) {

      eliminarUsuario(socket.username);

      // echo globally that this client has left
      socket.broadcast.emit('user left', {
        username: socket.username,
        numUsers: listaUsuarios.length
      });
    }
  });
});

//Se crea una arreglo donde tendra los objetos
var listaUsuarios = [];

//Funcion para eliminar usuarios usando lodash
function eliminarUsuario(item) {
  var objUsuarioIndex  = listaUsuarios.findIndex(function(o) { return o.usuario == item; });
  listaUsuarios.splice( objUsuarioIndex, 1 );
  console.log(listaUsuarios);
}


