module source.main;

import source.defaults;
import source.input;
import source.api;
import source.kuck;
import source.response;
import source.asset;
import source.queue;
import source.storage;
import source.config;
import source.run;
import source.startup;

void main(string[] args)
{
    Config     config;
    Asset[]    assets;

    config = GetConfig(args);
    assets = LoadAssets(config);
    Run(config, assets);
}
