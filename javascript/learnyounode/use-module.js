var mymodule = require('./filter-ls-module');

var path = process.argv[2];
var ext = process.argv[3];

mymodule(path, ext, function(err, files) {
    if (err) { return console.error("ERROR"); }

    files.forEach(function(file) {
        console.log(file);
    })
})
