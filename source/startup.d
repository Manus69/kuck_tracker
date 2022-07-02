module source.startup;

import source.defaults;
import source.config;
import source.asset;
import source.input;

Config GetConfig(string[] cmd_args)
{
    Config config;

    config = new Config();
    getopt(cmd_args, INTERVAL_STR, &config.time_interval, FILE_STR, &config.input_file_name);

    return config;
}

Asset[] LoadAssets(in Config config)
{
    string[]    lines;

    lines = GetInput(config.input_file_name);

    return GetAssets(lines);
}
