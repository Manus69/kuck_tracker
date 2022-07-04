module source.main;

import source.defaults;
import source.asset;
import source.queue;
import source.config;
import source.run;
import source.startup;
import source.output;

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
