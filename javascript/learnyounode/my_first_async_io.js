var fs = require('fs');
var fname = process.argv[2];  // file name

fs.readFile(fname, 'utf8', function(err, contents) {
    var lines = contents.toString().split('\n').length - 1
    console.log(lines);
});
