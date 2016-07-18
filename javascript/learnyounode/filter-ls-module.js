var fs = require('fs');
var path = require('path');


module.exports = function(dir, ext, callback) {
    fs.readdir(dir, function(err, files) {
        if (err) { return callback(err); }
        var res = [];
        files.forEach(function(file) {
            if (path.extname(file) === '.' + ext) {
                res.push(file);
            }
        })
        callback(null, res); // err に null を入れることでerrなく終わったという意味になるらしい.
    });
}
