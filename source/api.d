module source.api;

import source.defaults;

interface Api
{
    string      Name() const pure @property;
    string      SendRequest();
    JSONValue   GetJSON();
    double      ExtractPrice(in JSONValue json, in string symbol);
}