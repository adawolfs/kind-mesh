// Simple HTTP Server

var http = require('http');
var fs = require('fs');

console.log("Starting Server on port 8080");
http.createServer(function (req, res) {
    res.writeHead(200, {'Language': 'JS'});
    res.end('Hola desde JS!');
    }
).listen(8080);
