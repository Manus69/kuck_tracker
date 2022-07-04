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
public import std.process : executeShell;
public import core.thread;

enum COMMENT = "//";
enum MESSAGE = "Sending request to %s";
enum DEFAULT_FILE = "input.txt";
enum DEFAULT_S_FILE = "alarm.wav";
enum R_INTERVAL_STR = "request_interval";
enum T_INTERVAL_STR = "time_interval";
enum FILE_STR = "file";
enum STARTUP_FAILURE = "Failed to start up";
enum DATA_ERROR = "Failed to fetch data";
enum SHIT_THE_BED_ERROR = "The program shit the bed unexpectedly";
enum DEFAULT_R_INTERVAL = 60u;
enum DEFAULT_T_INTERVAL = DEFAULT_R_INTERVAL * 60;
enum SECONDS_PER_MINUTE = 60u;