// Copyright (c) 2025 Hasitha Aravinda. All Rights Reserved.
//
// This software may be modified and distributed under the terms
// of the MIT license. See the LICENSE file for details.

import ballerina/time;

# Converts JavaScript timestamp (milliseconds since epoch) to UTC time
#
# + milliseconds - JavaScript timestamp in milliseconds
# + return - The corresponding UTC time
public isolated function fromJsTimestamp(decimal milliseconds) returns time:Utc|time:Error {
    decimal seconds = milliseconds / 1000.0d;
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);
    
    // Add the seconds to epoch using time:utcAddSeconds
    return time:utcAddSeconds(epochUtc, seconds);
}

# Converts UTC time to JavaScript timestamp (milliseconds since epoch)
#
# + utcTime - The UTC time to convert
# + return - JavaScript timestamp in milliseconds
public isolated function toJsTimestamp(time:Utc utcTime) returns decimal|time:Error {
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);
    
    // Calculate difference in seconds and convert to milliseconds
    decimal diffSeconds = time:utcDiffSeconds(utcTime, epochUtc);
    return diffSeconds * 1000.0d;
}

# Converts Python timestamp (seconds since epoch) to UTC time
#
# + seconds - Python timestamp in seconds
# + return - The corresponding UTC time
public isolated function fromPythonTimestamp(decimal seconds) returns time:Utc|time:Error {
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);
    
    // Add the seconds to epoch using time:utcAddSeconds
    return time:utcAddSeconds(epochUtc, seconds);
}

# Converts UTC time to Python timestamp (seconds since epoch)
#
# + utcTime - The UTC time to convert
# + return - Python timestamp in seconds
public isolated function toPythonTimestamp(time:Utc utcTime) returns decimal|time:Error {
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);
    
    return time:utcDiffSeconds(utcTime, epochUtc);
}

# Converts Unix timestamp (seconds since epoch) to UTC time
#
# + seconds - Unix timestamp in seconds
# + return - The corresponding UTC time
public isolated function fromUnixTimestamp(int seconds) returns time:Utc|time:Error {
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);
    
    // Add the seconds to epoch using time:utcAddSeconds
    return time:utcAddSeconds(epochUtc, <decimal>seconds);
}

# Converts UTC time to Unix timestamp (seconds since epoch)
#
# + utcTime - The UTC time to convert
# + return - Unix timestamp in seconds
public isolated function toUnixTimestamp(time:Utc utcTime) returns int|time:Error {
    time:Civil epochCivil = {
        year: 1970, 
        month: 1, 
        day: 1, 
        hour: 0, 
        minute: 0, 
        second: 0.0,
        utcOffset: {hours: 0, minutes: 0}
    };
    time:Utc epochUtc = check time:utcFromCivil(epochCivil);

    decimal diffSeconds = time:utcDiffSeconds(utcTime, epochUtc);
    // Truncate to integer (remove fractional part by flooring)
    if (diffSeconds >= 0.0d) {
        return <int>decimal:floor(diffSeconds);
    } else {
        return <int>decimal:ceiling(diffSeconds);
    }
}
