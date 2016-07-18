var fs = require('fs');
var path = require('path');

var dirname = process.argv[2]
var ext = process.argv[3]
fs.readdir(dirname, function(err, files) {
    files.forEach(function(file) {
        if (path.extname(file) === '.' + ext) {
            console.log(file);
        }
    })
})
