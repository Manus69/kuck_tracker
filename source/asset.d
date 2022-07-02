module source.asset;

import source.defaults;

struct Asset
{
    string raw_string;
    string symbol;
    double target;

    this(in string str)
    {
        string[] substrings;

        scope(failure) stderr.writefln("Failed to process: \"%s\"", raw_string);

        substrings = split(str);
        enforce(substrings.length == 2);

        this.raw_string = str;
        this.symbol = substrings[0];
        this.target = to!double(substrings[1]);
    }

    bool CheckPriceDiff(double price0, double price1) const pure
    {
        double diff;

        diff = ((price1 - price0) * 100) / price0;

        return target >= 0 ? diff >= target : diff <= target;
    }
}

Asset[] GetAssets(in string[] lines)
{
    Asset[] assets;

    foreach (line; lines)
        assets ~= Asset(line);

    return assets;
}