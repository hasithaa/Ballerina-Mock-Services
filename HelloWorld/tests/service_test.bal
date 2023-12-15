import ballerina/http;
import ballerina/test;

final http:Client httpClient = check new ("http://localhost:" + port.toString() + "/HelloService");

@test:Config
function testHelloWorld() returns error? {

    http:Response response = check httpClient->/greet;
    test:assertEquals(response.statusCode, 200, "Status code should be 200");
    test:assertEquals(response.getTextPayload(), "Hello, World !!!", "Response should be Hello, World!");
}

@test:Config
function testHelloWithName() returns error? {

    final string name = "Alice";
    http:Response response = check httpClient->/greet/[name];
    test:assertEquals(response.statusCode, 200, "Status code should be 200");
    test:assertEquals(response.getTextPayload(), string `Hello, ${name} !!!`, "Response should be Hello, Alice!");
}
