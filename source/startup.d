module source.startup;

import source.defaults;
import source.config;
import source.asset;
import source.input;

Config GetConfig(string[] cmd_args)
{
    Config  config;
    ulong   r_interval;
    ulong   t_interval;
    string  api;

    ApiInit();
    config = new Config();
    getopt(cmd_args, R_INTERVAL_STR, &r_interval, API_STR, &api,
            T_INTERVAL_STR, &t_interval, FILE_STR, &config.input_file_name);
    
    config.SetTime();
    config.SetIntervals(r_interval, t_interval);
    config.SetApi(api);
    config.ComputeNDataPoints();

    return config;
}

Asset[] LoadAssets(in Config config)
{
    string[]    lines;
    Asset[]     assets;

    lines = GetInput(config.input_file_name);
    assets = GetAssets(lines);

    if (config.api == API_TYPE.BIN)
    {
        foreach (ref asset; assets)
        {
            asset.symbol ~= SUFFIX_STR;
        }
    }

    return assets;
}
