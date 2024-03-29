# Returns the string `Hello` with the input string name.
#
# + name - name as a string
# + return - "Hello, " with the input string name
public function hello(string name) returns string {
    if !(name is "") {
        return "Hello, " + name;
    }
    return "Hello, World!";
}

public function emptyModuleFunction() {
}

public function emptyMainModuleTestFunction2() {
}

public function emptyMainModuleTestFunction3() {
}
