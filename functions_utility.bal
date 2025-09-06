// Copyright (c) 2025 Hasitha Aravinda. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import ballerina/time;

# Returns the current UTC time
#
# + return - The current UTC time
public isolated function now() returns time:Utc {
    return time:utcNow();
}

# Returns the current time in the specified timezone
#
# + zoneId - The timezone identifier
# + return - The current time in the specified timezone or an error
public isolated function nowInZone(string zoneId) returns time:Civil|error {
    time:Utc currentUtc = time:utcNow();
    return toZone(currentUtc, zoneId);
}

# Returns today's date at 00:00:00 UTC
#
# + return - Today's date at midnight UTC
public isolated function today() returns time:Utc|time:Error {
    time:Civil civilTime = time:utcToCivil(time:utcNow());
    time:Civil todayCivil = {
        year: civilTime.year,
        month: civilTime.month,
        day: civilTime.day,
        hour: 0,
        minute: 0,
        second: 0.0d,
        utcOffset: {hours: 0, minutes: 0}  // UTC timezone
    };
    return time:utcFromCivil(todayCivil);
}

# Returns today's date at 00:00:00 in the specified timezone
#
# + zoneId - The timezone identifier
# + return - Today's date at midnight in the specified timezone or an error
public isolated function todayInZone(string zoneId) returns time:Civil|error {
    time:Utc todayUtc = check today();
    return toZone(todayUtc, zoneId);
}

# Creates a UTC time from individual components
#
# + year - The year
# + month - The month (1-12)
# + day - The day (1-31)
# + hour - The hour (0-23), default is 0
# + minute - The minute (0-59), default is 0
# + second - The second (0-59.999...), default is 0.0
# + return - The UTC time or an error if invalid
public isolated function create(int year, int month, int day, int hour = 0, int minute = 0, decimal second = 0.0d) returns time:Utc|error {
    time:Civil civilTime = {
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        utcOffset: {hours: 0, minutes: 0}  // UTC timezone
    };
    return time:utcFromCivil(civilTime);
}

# Creates a UTC time from components in the specified timezone
#
# + year - The year
# + month - The month (1-12)
# + day - The day (1-31)
# + zoneId - The timezone identifier
# + hour - The hour (0-23), default is 0
# + minute - The minute (0-59), default is 0
# + second - The second (0-59.999...), default is 0.0
# + return - The UTC time or an error if invalid
public isolated function createInZone(int year, int month, int day, string zoneId, int hour = 0, int minute = 0, decimal second = 0.0d) returns time:Utc|error {
    time:Civil civilTime = {
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        utcOffset: {hours: 0, minutes: 0}  // UTC timezone for now
    };
    return fromZone(civilTime, zoneId);
}

# Parses an ISO 8601 formatted string
#
# + timeStr - The ISO 8601 time string
# + return - The parsed UTC time or an error
public isolated function parseIso8601(string timeStr) returns time:Utc|error {
    return fromString(timeStr, ISO_8601);
}

# Parses an RFC 3339 formatted string
#
# + timeStr - The RFC 3339 time string
# + return - The parsed UTC time or an error
public isolated function parseRfc3339(string timeStr) returns time:Utc|error {
    return fromString(timeStr, RFC_3339);
}

# Checks if a time falls within a specified range
#
# + timeToCheck - The time to check
# + startTime - The start time
# + endTime - The end time
# + inclusive - Whether the range is inclusive (default true)
# + return - True if the time is in range
public isolated function isInRange(time:Utc timeToCheck, time:Utc startTime, time:Utc endTime, boolean inclusive = true) returns boolean {
    if inclusive {
        return isBetween(timeToCheck, startTime, endTime);
    } else {
        return isAfter(timeToCheck, startTime) && isBefore(timeToCheck, endTime);
    }
}

# Clamps a time to fall within specified bounds
#
# + timeToClamp - The time to clamp
# + minTime - The minimum time
# + maxTime - The maximum time
# + return - The clamped time
public isolated function clamp(time:Utc timeToClamp, time:Utc minTime, time:Utc maxTime) returns time:Utc {
    if isBefore(timeToClamp, minTime) {
        return minTime;
    } else if isAfter(timeToClamp, maxTime) {
        return maxTime;
    } else {
        return timeToClamp;
    }
}

# Returns the earliest time from a list of times
#
# + times - The array of times to compare
# + return - The earliest time
public isolated function min(time:Utc[] times) returns time:Utc {
    time:Utc minTime = times[0];
    foreach time:Utc t in times {
        if isBefore(t, minTime) {
            minTime = t;
        }
    }
    return minTime;
}

# Returns the latest time from a list of times
#
# + times - The array of times to compare
# + return - The latest time
public isolated function max(time:Utc[] times) returns time:Utc {
    time:Utc maxTime = times[0];
    foreach time:Utc t in times {
        if isAfter(t, maxTime) {
            maxTime = t;
        }
    }
    return maxTime;
}
