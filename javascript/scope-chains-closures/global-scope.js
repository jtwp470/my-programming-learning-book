function foo() {
    var bar = 1; // lexical scope
    quux = 1;
    function zip() {
        var quux = 2;
    }
}