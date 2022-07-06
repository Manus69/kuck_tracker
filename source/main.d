module source.main;

import source.defaults;
import source.asset;
import source.queue;
import source.config;
import source.run;
import source.startup;
import source.output;

string[string] StringToTable(in string str)
{
    string[] strings;
    string[string] table;

    strings = split(str[1 .. $], "},");

    JSONValue value;

    foreach (s; strings)
    {
        value = parseJSON(s ~ "}");
        table[value["symbol"].str] = value["price"].str;
    }
    
    return table;
}

void main(string[] args)
{
    Config     config;
    Asset[]    assets;

    try
    {
        config = GetConfig(args);
        assets = LoadAssets(config);
    }
    catch (Exception e)
    {
        return TerminalError(e.msg, STARTUP_FAILURE);
    }

    try
    {
        Run(config, assets);
    }
    catch (Exception e)
    {
        return TerminalError(e.msg, SHIT_THE_BED_ERROR);
    }
}
