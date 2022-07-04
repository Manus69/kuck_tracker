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
        enforce(target != 0);
    }

    bool opEquals(in Asset rhs) const pure
    {
        return this.symbol == rhs.symbol;
    }

    string toString() const
    {
        return raw_string;
    }
}

Asset[] GetAssets(in string[] lines)
{
    Asset[] assets;

    foreach (line; lines)
        assets ~= Asset(line);

    return assets;
}