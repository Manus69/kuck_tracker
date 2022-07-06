module source.binance;

import source.defaults;

import source.api;
import source.response;

private enum API = "https://api.binance.com/api/";
private enum REQUEST = "https://api.binance.com/api/v3/ticker/price";
private enum SEP = "},";
private enum SYMBOL_KEY = "symbol";
private enum PRICE_KEY = "price";

class BinanceApi : Api
{
    string Name() const pure @property
    {
        return API;
    }

    string SendRequest()
    {
        return get(REQUEST).idup;
    }

    JSONValue GetJSON()
    {
        string response;

        response = SendRequest();

        return parseJSON(response);
    }

    double ExtractPrice(in JSONValue json, in string symbol)
    {
        return double.nan;
    }

    string[string] GetTable()
    {
        string[string]  table;
        string[]        data;
        string          response;
        JSONValue       json;

        response = SendRequest();
        if (!response || response.length < 5)
            return null;

        response = response[1 .. $];
        data = split(response, SEP);

        foreach(str; data)
        {
            str = str ~ "}";
            json = parseJSON(str);
            table[json[SYMBOL_KEY].str] = json[PRICE_KEY].str;
        }

        return table;
    }
}