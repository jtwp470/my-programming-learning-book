function foo() {
    var bar = false;
    quux = 0;
    function zip() {
        var quux = 1;
        bar = true;
    }
    return zip;
}