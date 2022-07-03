module source.test;

void TransformIntoDick(ref string str)
{
    str = "Dick";
}

void Apply(void function(ref string) f, ref string str)
{
    f(str);
}

string GetString() pure
{
    return "The Jews";
}

int CountChars(in string str) pure
{
    return cast(int)(str.length);
}

int GetInt(string function() pure f, int function(string) pure g) pure
{
    return g(f());
}

