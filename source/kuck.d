module source.kuck;

import source.defaults;
import source.api;
import source.response;

private enum API = "https://api.kucoin.com/api";
private enum REQUEST = "https://api.kucoin.com/api/v1/prices?base=USD";
private enum DATA_KEY = "data";

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

        str_value = GetStringValue(json, DATA_KEY, symbol);

        return to!double(str_value);
    }

    string[string] GetTable()
    {
        string[string]  table;
        JSONValue       json;

        json = GetJSON()[DATA_KEY];

        foreach (string key, JSONValue value; json)
        {
            table[key] = value.str;
        }

        return table;
    }
}