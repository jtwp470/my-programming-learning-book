// POSTメソッドで送られてくるデータを大文字にして返す
var http = require('http');
var map = require('through2-map');

var server = http.createServer(function(req, res) {
    if (req.method != 'POST') {
        return res.end("Plz date to use POST method");
    }

    req.pipe(map(function (chunk) {
        return chunk.toString().toUpperCase()
    })).pipe(res)
})
server.listen(Number(process.argv[2]));
