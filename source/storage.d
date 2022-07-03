module source.storage;

import source.queue;
import source.defaults;

class Storage(T)
{
    private ulong           capacity;
    private Queue!T[string] table;

    this(ulong queue_capacity)
    {
        capacity = queue_capacity;
    }

    bool FullCapacity(in string symbol) const pure @property
    {
        return table[symbol].FullCapacity;
    }

    void Store(in string symbol, in T value)
    {
        if (!(symbol in table))
        {
            table[symbol] = Queue!T(capacity);
        }

        table[symbol].Push(value);
    }

    T GetFirst(in string symbol) const pure
    {
        return table[symbol].Front();
    }

    T GetLast(in string symbol) pure const
    {
        return table[symbol].Back();
    }

    override string toString() const
    {
        return format("%s", table);
    }
}