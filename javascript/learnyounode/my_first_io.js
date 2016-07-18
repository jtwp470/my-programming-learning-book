var fs = require('fs');
var fname = process.argv[2];  // file name
var buf = fs.readFileSync(fname, 'utf8');
var str = buf.toString();
console.log(str.split('\n').length - 1);
