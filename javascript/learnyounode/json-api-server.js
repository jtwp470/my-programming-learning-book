var http = require('http');
var url = require('url');

var server = http.createServer(function(req, res) {
    // GET /api/parsetime?iso=2013-08-10T12:10:15.474Z
    var ret = "";
    var r = url.parse(req.url, true);
    var d = new Date(r.query.iso);
    if (r.pathname === "/api/parsetime") {
        ret = {
            hour: d.getHours(),
            minute: d.getMinutes(),
            second: d.getSeconds()
        };
    } else if (r.pathname === "/api/unixtime") {
        ret = {
            unixtime: d.getTime()
        };
    } else {
        res.writeHead(404);
        res.end();
    }
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(ret));

})

server.listen(Number(process.argv[2]));
