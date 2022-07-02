module source.input;

import source.defaults;

string[] GetInput(in string file_name)
{
    string[] lines;

    foreach (line; File(file_name).byLineCopy())
    {
        if (!startsWith(line, COMMENT))
            lines ~= line;
    }

    return lines;
}
