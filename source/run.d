module source.run;

import source.defaults;
import source.asset;
import source.config;
import source.kuck;
import source.response;
import source.output;
import source.manager;
import source.startup;

bool CheckPriceDiff(in Asset asset, double diff) pure
{
    return asset.target >= 0 ? diff >= asset.target : diff <= asset.target;
}

bool GetData(Manager manager, in Asset[] assets)
{
    try
    {
        manager.GetData(assets);

        return true;
    }
    catch (Exception e)
    {
        KuckError(e.msg, DATA_ERROR);

        return false;
    }
}

Asset[] CheckData(in Manager manager, in Asset[] assets)
{
    Asset[] result;
    double  diff;

    foreach (ref asset; parallel(assets))
    {
        if (manager.AtCapacity(asset.symbol))
            diff = manager.GetDiff(asset.symbol);
        
        if (CheckPriceDiff(asset, diff))
        {
            result ~= asset;
        }
    }

    return result;
}

void Run(Config config, Asset[] assets)
{
    Asset[] results;
    Manager manager;

    manager = Manager(config);

    while (true)
    {
        if (GetData(manager, assets))
            results = CheckData(manager, assets);

        if (results.length > 0)
        {
            // PlaySound(config.sound_file_name);
            Output(results);
        }

        Thread.sleep(config.request_interval.seconds);

        if (config.InputModified())
            assets = LoadAssets(config);
    }
}
