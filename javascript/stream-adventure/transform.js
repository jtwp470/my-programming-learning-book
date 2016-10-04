var through = require('through2');

var tx = through(function(buffer, _, next) {
    this.push(buffer.toString().toUpperCase())
    next();
});

process.stdin.pipe(tx).pipe(process.stdout);