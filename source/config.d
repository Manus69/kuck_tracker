module source.config;

import source.defaults;

class Config
{
    uint    request_interval;
    uint    time_interval;
    uint    number_of_data_points;
    string  input_file_name;
    string  sound_file_name;
    SysTime time_modified;

    this()
    {
        this.request_interval = DEFAULT_R_INTERVAL;
        this.time_interval = DEFAULT_T_INTERVAL;
        this.input_file_name = DEFAULT_FILE;
        this.sound_file_name = DEFAULT_S_FILE;
        this.time_modified = input_file_name.timeLastModified;
    }

    uint ComputeNDataPoints() pure
    {
        number_of_data_points = time_interval / request_interval;

        return number_of_data_points;
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