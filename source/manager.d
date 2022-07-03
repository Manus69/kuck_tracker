module source.manager;

import source.defaults;
import source.api;
import source.asset;
import source.storage;
import source.config;
import source.kuck;

struct Manager
{
    private Storage!double  storage;
    private Api             api;
    private JSONValue       json;

    this(in Config config)
    {
        this.storage = Storage!double(config.number_of_data_points);
        this.api = new KuckApi();
    }

    private void _get_json()
    {
        string response;

        response = api.SendRequest();
        json = parseJSON(response);
    }

    void GetData(in Asset[] assets)
    {
        double price;

        _get_json();

        // foreach (ref asset; parallel(assets))
        foreach (ref asset; assets)
        {
            price = api.ExtractPrice(json, asset.symbol);
            storage.Store(asset.symbol, price);
        }
    }

    double GetDiff(in Asset asset) const pure
    {
        double p0;
        double p1;

        p0 = storage.GetFirst(asset.symbol);
        p1 = storage.GetLast(asset.symbol);

        return ((p1 - p0) * 100) / p0;
    }
}