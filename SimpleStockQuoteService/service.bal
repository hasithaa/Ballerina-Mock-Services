import ballerina/http;
import ballerina/log;

configurable int port = 8082;

int orderCount = 0;

service /stocks on new http:Listener(port) {

    resource function get quote/[string symbol]() returns Quote|http:NotFound {
        if symbol == "ERR" {
            return http:NOT_FOUND;
        }
        log:printInfo("Received quote request for symbol: " + symbol);
        return getRandomQuote(symbol);
    }

    resource function get fullQuote/[string symbol]() returns FullQuote {
        log:printInfo("Received full quote request for symbol: " + symbol);
        return getRandomFullQuote(symbol);
    }

    resource function post market\-activity(MarketActivityRequest request) returns MarketActivityResponse {
        log:printInfo("Received market activity request for symbols: " + request.symbols.toString());
        return getRandomMarketActivity(request.symbols);
    }

    resource function put 'order(PlaceOrderRequest request) returns http:Accepted {
        log:printInfo("Received order" + request.toString());
        orderCount += 1;
        return http:ACCEPTED;
    }
}
