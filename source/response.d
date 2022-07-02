module source.response;

import source.defaults;

JSONValue StringToJson(in string str)
{
    return parseJSON(str);
}

string GetStringValue(in JSONValue j_value, in string[] tags...)
{
    if (tags.length == 1)
        return j_value[tags[0]].str;
    
    return GetStringValue(j_value[tags[0]], tags[1 .. $]);
}
