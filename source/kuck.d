module source.kuck;

import source.defaults;
import source.api;
import source.response;

enum API = "https://api.kucoin.com/api";
enum REQUEST = "https://api.kucoin.com/api/v1/prices?base=USD";
enum DATA = "data";

class KuckApi : Api
{
    string Name() pure const @property
    {
        return API;
    }
    
    string SendRequest()
    {
        return get(REQUEST).idup;
    }

    JSONValue GetJSON()
    {
        return parseJSON(SendRequest());
    }

    double ExtractPrice(in JSONValue json, in string symbol)
    {
        string str_value;

        str_value = GetStringValue(json, DATA, symbol);

        return to!double(str_value);
    }
}