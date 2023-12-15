import ballerina/http;

configurable int port = 8080;

service /HelloService on new http:Listener(port) {

    resource function get greet/[string name]() returns string {
        return string `Hello, ${name} !!!`;
    }

    resource function get greet() returns string {
        return "Hello, World !!!";
    }
}
