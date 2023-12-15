import ballerina/http;
import ballerina/test;

final http:Client httpClient = check new ("http://localhost:" + port.toString() + "/stocks");
const string SMP = "SMP";

@test:Config
function testGetQuote() returns error? {
    Quote res = check httpClient->/quote/[SMP];

    test:assertEquals(res.symbol, SMP, "Mismatch Symbol");
    test:assertEquals(res.name, string `${SMP} Company`, "Mismatch Symbol Data");
}

@test:Config
function testFullQuote() returns error? {
    FullQuote res = check httpClient->/fullQuote/[SMP];

    test:assertEquals(res.tradeHistory.length(), 365, "Mismatch History Count");
    test:assertEquals(res.tradeHistory[0].quote.symbol, SMP, "Mismatch symbol");
}

@test:Config
function testMarketActivity() returns error? {
    final string[] symbols = ["SMP", "Example", "Foo", "Bar"];
    final MarketActivityRequest req = {symbols};
    MarketActivityResponse res = check httpClient->/market\-activity.post(req);

    test:assertEquals(res.quotes.length(), symbols.length(), "Mismatch Quote Count");
    foreach var [index, symbol] in symbols.enumerate() {
        test:assertEquals(res.quotes[index].symbol, symbol, "Mismatch Symbol Name");
    }
}

@test:Config
function testOrder() returns error? {

    test:assertEquals(orderCount, 0, "Mismatch order count, No Orders expected");

    PlaceOrderRequest req = {symbol: SMP, price: 10, quantity: 50};
    () _ = check httpClient->/'order.put(req);

    test:assertEquals(orderCount, 1, "Mismatch order count");
}
