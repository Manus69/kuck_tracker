module source.config;

import source.defaults;

private enum R_INTERVAL : ulong {MIN = 5, MAX = 1000}
private enum T_INTERVAL : ulong {MIN = 60, MAX = 2_592_000}
enum API_TYPE {BIN = 1, KUCK}

API_TYPE[string] APIS;

class Config
{
    ulong       request_interval;
    ulong       time_interval;
    ulong       number_of_data_points;
    string      input_file_name;
    string      sound_file_name;
    SysTime     time_modified;
    API_TYPE    api;

    this()
    {
        this.request_interval = DEFAULT_R_INTERVAL;
        this.time_interval = DEFAULT_T_INTERVAL;
        this.input_file_name = DEFAULT_FILE;
        this.sound_file_name = DEFAULT_S_FILE;
        this.api = API_TYPE.BIN;
        // this.api = API_TYPE.KUCK;
    }

    void SetTime()
    {
        this.time_modified = input_file_name.timeLastModified;
    }

    void SetApi(in string api)
    {
        if (api in APIS)
            this.api = APIS[api];
        else if (api)
            throw new Exception(INPUT_ERROR);
    }

    void SetIntervals(ulong request, ulong time) pure
    {
        if (request)
            this.request_interval = request;
            
        if (time)
            this.time_interval = time * SECONDS_PER_MINUTE;

        Validate();
    }

    ulong ComputeNDataPoints() pure
    {
        number_of_data_points = time_interval / request_interval;

        return number_of_data_points;
    }

    void Validate() pure
    {
        enforce(request_interval < time_interval);
        enforce(request_interval >= R_INTERVAL.MIN && request_interval <= R_INTERVAL.MAX);
        enforce(time_interval >= T_INTERVAL.MIN && request_interval <= T_INTERVAL.MAX);
    }

    bool InputModified()
    {
        SysTime time;
        
        time = input_file_name.timeLastModified;
        if (time > time_modified)
        {
            time_modified = time;

            return true;
        }

        return false;
    }
}

void ApiInit()
{
    APIS = ["binance" : API_TYPE.BIN, "kuck" : API_TYPE.KUCK];
}