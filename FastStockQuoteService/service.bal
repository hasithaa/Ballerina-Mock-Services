import ballerina/http;

const RESPONSE = {
    "getQuoteResponse": {
        "return": {
            "change": "-2.57",
            "earnings": "12.72",
            "high": "181.57",
            "last": "79.93",
            "lastTradeTimestamp": "Thu Jan 25 17:39:12 IST 2007",
            "low": "9.93",
            "marketCap": "5.93",
            "name": "Sample Company",
            "open": "15.93",
            "peRatio": "24.28",
            "percentageChange": "-2.33",
            "prevClose": "-179.58",
            "symbol": "SMP",
            "volume": "7618"
        }
    }
};

configurable int port = 8081;

service /stocks on new http:Listener(port) {

    resource function get quote/[string name]() returns RESPONSE {
        return RESPONSE;
    }
}
