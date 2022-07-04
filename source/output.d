module source.output;

import source.defaults;
import source.asset;

version (linux)
{
    string COMMAND = "open ";
}

version (Windows)
{
    string COMMAND = "start ";
}

void Output(in Asset[] assets)
{
    writeln(assets);
}

void PlaySound(in string file_name)
{
    executeShell(COMMAND ~ file_name);
}

void KuckError(in string error_msg, in string msg)
{
    stderr.writeln(error_msg, "\n", msg);
}

void TerminalError(in string error_msg, in string msg)
{
    stderr.writeln(error_msg, "\n", msg, " terminating");
}
