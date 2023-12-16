import ballerina/random;
import ballerina/time;

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
