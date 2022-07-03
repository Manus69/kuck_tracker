module source.test;

void TransformIntoDick(ref string str)
{
    str = "Dick";
}

void Apply(void function(ref string) f, ref string str)
{
    f(str);
}