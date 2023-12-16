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
