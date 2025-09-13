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
@display {label: "Get Current Time", iconPath: "icon.png"}
public isolated function now() returns time:Utc {
    return time:utcNow();
}

# Returns today's date
#
# This function can return an error value if the date calculation fails. Check logs for details.
#
# + return - Today's date at midnight UTC or an error
@display {label: "Get Today's Date", iconPath: "icon.png"}
public isolated function today() returns time:Utc {
    time:Civil civilTime = time:utcToCivil(time:utcNow());
    time:Civil todayCivil = {
        year: civilTime.year,
        month: civilTime.month,
        day: civilTime.day,
        hour: 0,
        minute: 0,
        second: 0.0d,
        utcOffset: {hours: 0, minutes: 0} // UTC timezone
    };
    // If this panics, it indicates a serious issue with the civil time conversion.
    time:Utc result = checkpanic time:utcFromCivil(todayCivil);
    return result;
}

# Returns the current UTC time
# + return - The current UTC time
@display {label: "Get Current UTC Time", iconPath: "icon.png"}
public isolated function Now() returns time:Utc {
    return time:utcNow();
}

# Creates a UTC time from individual components
#
# This function can return an error if the provided date/time values are invalid
# (e.g., February 30, hour 25, minute 65, etc.)
#
# + year - The year
# + month - The month (1-12)
# + day - The day (1-31)
# + hour - The hour (0-23), default is 0
# + minute - The minute (0-59), default is 0
# + second - The second (0-59.999...), default is 0.0
# + return - The UTC time or an error if invalid
@display {label: "Create Time", iconPath: "icon.png"}
public isolated function create(@display {label: "Year"} int year, @display {label: "Month"} int month, @display {label: "Day"} int day, @display {label: "Hour"} int hour = 0, @display {label: "Minute"} int minute = 0, @display {label: "Second"} decimal second = 0.0d) returns time:Utc|error {
    time:Civil civilTime = {
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        utcOffset: {hours: 0, minutes: 0} // UTC timezone
    };
    return time:utcFromCivil(civilTime);
}

# Parses an ISO 8601 formatted string
#
# This function can return an error if the time string is malformed or invalid
#
# + timeStr - The ISO 8601 time string
# + return - The parsed UTC time or an error
@display {label: "Parse ISO 8601", iconPath: "icon.png"}
public isolated function parseIso8601(@display {label: "Time String"} string timeStr) returns time:Utc|error {
    return fromString(timeStr, ISO_8601);
}

# Parses an RFC 3339 formatted string
#
# This function can return an error if the time string is malformed or invalid
#
# + timeStr - The RFC 3339 time string
# + return - The parsed UTC time or an error
@display {label: "Parse RFC 3339", iconPath: "icon.png"}
public isolated function parseRfc3339(@display {label: "Time String"} string timeStr) returns time:Utc|error {
    return fromString(timeStr, RFC_3339);
}

# Checks if a time falls within a specified range
#
# + timeToCheck - The time to check
# + startTime - The start time
# + endTime - The end time
# + inclusive - Whether the range is inclusive (default true)
# + return - True if the time is in range
@display {label: "Is In Range", iconPath: "icon.png"}
public isolated function isInRange(@display {label: "Time to Check"} time:Utc timeToCheck, @display {label: "Start Time"} time:Utc startTime, @display {label: "End Time"} time:Utc endTime, @display {label: "Inclusive Range"} boolean inclusive = true) returns boolean {
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
@display {label: "Clamp Time to Range", iconPath: "icon.png"}
public isolated function clamp(@display {label: "Time to Clamp"} time:Utc timeToClamp, @display {label: "Minimum Time"} time:Utc minTime, @display {label: "Maximum Time"} time:Utc maxTime) returns time:Utc {
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
@display {label: "Get Minimum Time", iconPath: "icon.png"}
public isolated function min(@display {label: "Time Array"} time:Utc[] times) returns time:Utc {
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
@display {label: "Get Maximum Time", iconPath: "icon.png"}
public isolated function max(@display {label: "Time Array"} time:Utc[] times) returns time:Utc {
    time:Utc maxTime = times[0];
    foreach time:Utc t in times {
        if isAfter(t, maxTime) {
            maxTime = t;
        }
    }
    return maxTime;
}
