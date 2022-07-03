module source.kuck;

import source.defaults;
import source.api;
import source.response;

enum REQUEST = "https://api.kucoin.com/api/v1/prices?base=USD";
enum DATA = "data";

class KuckApi : Api
{
    JSONValue   json;
    string      response;

    string SendRequest()
    {
        response = get(REQUEST).idup;

        return response;
    }

    JSONValue GetJSON()
    {
        SendRequest();
        json = parseJSON(response);

        return json;
    }

    double GetPrice(in string symbol)
    {
        string str_value;

        str_value = GetStringValue(json, DATA, symbol);

        return to!double(str_value);
    }
}