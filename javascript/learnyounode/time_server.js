var net = require('net');
var dateformat = require('dateformat');
var port = process.argv[2];

var server = net.createServer(function(socket){
    var r = dateformat(new Date(), "yyyy-mm-dd HH:MM");
    socket.end(r + "\n");
})
server.listen(Number(port));
