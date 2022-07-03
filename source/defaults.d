module source.defaults;

public import std.file;
public import std.conv;
public import std.stdio;
public import std.string;
public import std.exception;
public import std.range;
public import std.algorithm;
public import std.array;
public import std.format;
public import std.net.curl;
public import std.json;
public import std.getopt;
public import std.parallelism;
public import std.datetime;
public import core.thread;

enum COMMENT = "//";
enum DEFAULT_FILE = "input.txt";
enum DEFAULT_S_FILE = "alarm.wav";
enum INTERVAL_STR = "interval";
enum FILE_STR = "file";
enum DEFAULT_R_INTERVAL = 1u;
enum DEFAULT_T_INTERVAL = 60u;