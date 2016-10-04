var through = require('through2');
var split = require('split');

var c = 0;
var tr = through(function(buf, _, next) {
    var line = buf.toString();
    var m = "";
    if (c % 2 === 0) {}
    this.push(c % 2 === 0
        ? line.toLowerCase() + '\n'
        : line.toUpperCase() + '\n');
    c++;
    next();
});

process.stdin
    .pipe(split())
    .pipe(tr)
    .pipe(process.stdout);