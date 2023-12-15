import ballerina/http;
import ballerina/test;

final http:Client httpClient = check new ("http://localhost:" + port.toString() + "/stocks");

@test:Config
function testHelloWorld() returns error? {

    json response = check httpClient->/quote/SMP;
    test:assertEquals(response, RESPONSE, "Mismatched response");
}
