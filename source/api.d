module source.api;

import source.defaults;

interface Api
{
    string      SendRequest();
    JSONValue   GetJSON();
    double      GetPrice(in string symbol);
}