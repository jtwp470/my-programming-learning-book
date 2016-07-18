// HTTP を集めるによく似た問題
// 3つのURLを受け取り順番に表示する
var http = require('http');
var result = []
var cnt = 0;

var httpGet = function(index) {
    url = process.argv[2+index];
    http.get(url, function(res) {
        var out = "";
        res.setEncoding("utf8");
        res.on("data", function(chunk) {
            out += chunk;
        })
        res.on("error", function(err) {
            console.error(err);
        })
        res.on("end", function() {
            result[index] = out;
            cnt++;
            if (cnt == 3) {
                for (var i = 0; i < 3; i++) {
                    console.log(result[i]);
                }
            }
        })
    });
}

for (var i = 0; i < 3; i++) {
    httpGet(i);
}
