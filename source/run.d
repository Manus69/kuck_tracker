module source.run;

import source.defaults;
import source.asset;
import source.config;
import source.kuck;
import source.response;
import source.output;
import source.manager;

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
        diff = manager.GetDiff(asset);
        if (CheckPriceDiff(asset, diff))
            result ~= asset;
    }

    return result;
}

void Run(in Config config, in Asset[] assets)
{
    Asset[] results;
    Manager manager;

    manager = Manager(config);

    while (true)
    {
        GetData(manager, assets);
        results = CheckData(manager, assets);

        if (results.length > 0)
        {
            Output(results);
        }

        Thread.sleep(config.request_interval.minutes);
    }
}
