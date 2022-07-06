module source.manager;

import source.defaults;
import source.api;
import source.asset;
import source.storage;
import source.config;
import source.kuck;
import source.binance;

struct Manager
{
    private Storage!double  storage;
    private Api             api;
    private JSONValue       json;

    this(in Config config)
    {
        this.storage = new Storage!double(config.number_of_data_points);
        if (config.api == API_TYPE.KUCK)
            this.api = new KuckApi();
        else
            this.api = new BinanceApi();
    }

    private void _get_json()
    {
        string response;

        response = api.SendRequest();
        json = parseJSON(response);
    }

    void GetData(in Asset[] assets)
    {
        string[string]  table;
        Asset[]         unique_assets;
        double          price;

        writefln(MESSAGE, api.Name);
        table = api.GetTable();
        unique_assets = cast(Asset[])uniq(assets).array;

        foreach (ref asset; unique_assets)
        {
            // price = api.ExtractPrice(json, asset.symbol);
            price = to!double(table[asset.symbol]);
            storage.Store(asset.symbol, price);
        }
    }

    double GetDiff(in string symbol) const pure
    {
        double p0;
        double p1;

        p0 = storage.GetFirst(symbol);
        p1 = storage.GetLast(symbol);

        return ((p1 - p0) * 100) / p0;
    }

    bool AtCapacity(in string symbol) const pure
    {
        return storage.FullCapacity(symbol);
    }

    string toString() const
    {
        return storage.toString();
    }
}