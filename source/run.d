module source.run;

import source.defaults;
import source.asset;
import source.config;
import source.kuck;
import source.storage;
import source.response;
import source.api;
import source.output;

void GetData(Api api, Storage!double storage, in Asset[] assets)
{
    double price;

    api.GetJSON();

    foreach (ref asset; parallel(assets))
    {
        price = api.GetPrice(asset.symbol);
        storage.Store(asset.symbol, price);
    }
}

Asset[] CheckData(in Storage!double storage, in Asset[] assets)
{
    Asset[] result;
    double  price0;
    double  price1;

    foreach (ref asset; assets)
    {
        if (!storage.FullCapacity(asset.symbol))
            continue ;
        
        price0 = storage.GetFirst(asset.symbol);
        price1 = storage.GetLast(asset.symbol);

        if (asset.CheckPriceDiff(price0, price1))
            result ~= asset;
    }

    return result;
}

private ulong _compute_n(in Config config) pure
{
    return config.time_interval / config.request_interval;
}

void Run(in Config config, in Asset[] assets)
{
    Storage!double  storage;
    Asset[]         results;
    Api             api;

    api = new KuckApi();
    storage = Storage!double(_compute_n(config));

    while (true)
    {
        GetData(api, storage, assets);
        results = CheckData(storage, assets);

        if (results.length > 0)
        {
            Output(results);
        }

        Thread.sleep(config.request_interval.minutes);
    }
}
