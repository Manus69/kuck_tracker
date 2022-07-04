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

    config = new Config();
    getopt(cmd_args, R_INTERVAL_STR, &r_interval, 
            T_INTERVAL_STR, &t_interval, FILE_STR, &config.input_file_name);
    config.SetIntervals(r_interval, t_interval);
    config.ComputeNDataPoints();

    return config;
}

Asset[] LoadAssets(in Config config)
{
    string[]    lines;

    lines = GetInput(config.input_file_name);

    return GetAssets(lines);
}
