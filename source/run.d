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

void GetData(Manager manager, in Asset[] assets)
{
    manager.GetData(assets);
}

Asset[] CheckData(in Manager manager, in Asset[] assets)
{
    Asset[] result;
    double  diff;

    foreach (ref asset; assets)
    {
        if (manager.AtCapacity(asset.symbol))
            diff = manager.GetDiff(asset.symbol);
        
        // writeln(diff);

        if (CheckPriceDiff(asset, diff))
            result ~= asset;
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
        GetData(manager, assets);
        results = CheckData(manager, assets);

        writeln(manager);

        if (results.length > 0)
        {
            Output(results);
        }

        // Thread.sleep(config.request_interval.minutes);
        Thread.sleep(5.seconds);

        if (config.InputModified())
            assets = LoadAssets(config);
    }
}
