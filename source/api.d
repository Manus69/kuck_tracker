module source.api;

import source.defaults;

interface Api
{
    string      SendRequest();
    JSONValue   GetJSON();
    double      ExtractPrice(in JSONValue json, in string symbol);
}