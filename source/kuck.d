module source.kuck;

import source.defaults;
import source.api;
import source.response;

enum REQUEST = "https://api.kucoin.com/api/v1/prices?base=USD";
enum DATA = "data";

class KuckApi : Api
{
    static string SendRequest()
    {
        return get(REQUEST).idup;
    }
}

double GetKuckPrice(in JSONValue json, in string symbol)
{
    string str_value;

    str_value = GetStringValue(json, DATA, symbol);

    return to!double(str_value);
}