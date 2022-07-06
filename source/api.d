module source.api;

import source.defaults;

interface Api
{
    string          Name() const pure @property;
    string          SendRequest();
    JSONValue       GetJSON();
    string[string]  GetTable();
}