module source.config;

import source.defaults;

class Config
{
    uint    request_interval;
    uint    time_interval;
    string  input_file_name;
    string  sound_file_name;

    this()
    {
        this.request_interval = DEFAULT_R_INTERVAL;
        this.time_interval = DEFAULT_T_INTERVAL;
        this.input_file_name = DEFAULT_FILE;
        this.sound_file_name = DEFAULT_S_FILE;
    }
}