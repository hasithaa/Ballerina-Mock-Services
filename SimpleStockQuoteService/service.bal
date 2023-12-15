import ballerina/http;
import ballerina/log;
import ballerina/random;
import ballerina/time;

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

type PlaceOrderRequest record {
    string symbol;
    decimal price;
    int quantity;
};

type FullQuote record {|
    TradingDay[] tradeHistory;
|};

type TradingDay record {|
    int day = 0;
    Quote quote;
|};

type Quote record {|
    string symbol;
    decimal last;
    string lastTradeTimestamp;
    decimal change;
    decimal open;
    decimal high;
    decimal low;
    int volume;
    decimal marketCap;
    decimal prevClose;
    decimal percentageChange;
    decimal earnings;
    decimal peRatio;
    string name;
|};

type MarketActivityRequest record {
    string[] symbols;
};

type MarketActivityResponse record {|
    Quote[] quotes;
|};

isolated function getRandomFullQuote(string symbol) returns FullQuote {
    TradingDay[] tradeHistory = from int i in 0 ..< 365
        select {day: i, quote: getRandomQuote(symbol)};
    return {tradeHistory};
}

isolated function getRandomMarketActivity(string[] symbols) returns MarketActivityResponse {
    Quote[] quotes = from string symbol in symbols
        select getRandomQuote(symbol);
    return {quotes};
}

isolated function getRandomQuote(string symbol) returns Quote {
    decimal last = getRandom(100, 0.9, true);
    decimal change = getRandom(3, .5, false);
    decimal prevClose = getRandom(last, 0.15, false);
    Quote quote = {
        symbol,
        last: <decimal>last,
        lastTradeTimestamp: time:utcToString(time:utcNow()),
        change,
        open: getRandom(last, 0.05, false),
        high: getRandom(last, 0.05, false),
        low: getRandom(last, 0.05, false),
        volume: <int>getRandom(100000, 1, true),
        marketCap: getRandom(10E6, 5.0, false),
        prevClose,
        percentageChange: change / prevClose * 100,
        earnings: getRandom(10, 0.4, false),
        peRatio: getRandom(20, 0.3, false),
        name: symbol + " Company"
    };
    return quote;
}

isolated function getRandom(decimal base, decimal variance, boolean positive) returns decimal {
    decimal rand = <decimal>random:createDecimal();
    decimal result = (base + ((rand > 0.5d ? 1 : -1) * variance * base * rand))
            * (positive ? 1 : (rand > 0.5d ? 1 : -1));
    return result;
}
