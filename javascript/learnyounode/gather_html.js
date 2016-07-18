var http = require('http');
var url = process.argv[2];

http.get(url, function(res) {
    res.setEncoding("utf8");
    var out = "";
    res.on("data", function(b) {
        out += b;
    })
    res.on("error", function(err) {
        console.error(err);
    })
    res.on("end", function() {
        console.log(out.length);
        console.log(out);
    })
})
