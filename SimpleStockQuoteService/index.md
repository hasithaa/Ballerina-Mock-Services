---
title : "Stock Quote Rest Service"
description : "The famous Stock Quote Service"
tags : ["REST Services"]
date: 2023-12-15
series: ["REST Services"]
categories: [Examples]
series_weight: 2
---

{{< example output=false test=true repo="https://github.com/hasithaa/Ballerina-Mock-Services/" repoPath="SimpleStockQuoteService" hr="down" default="service.bal" >}}

## Overview

This sample contains a simple REST service that accepts HTTP requests at:

1. GET `http://localhost:8082/stocks/quote/{symbol}`
2. GET `http://localhost:8082/stocks/fullQuote/{symbol}`
3. POST `http://localhost:8082/stocks/market-activity` with a JSON payload like below

```json
{
    "symbols" : ["SMP", "Example", "Foo", "Bar"]
}
```
4. PUT `http://localhost:8082/stocks/order` with a JSON payload like below

```json
{
    "symbol" : "SMP",
    "price" : 100,
    "quantity" : 100,
}
```