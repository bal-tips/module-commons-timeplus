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

# Converts JavaScript timestamp (milliseconds since epoch) to UTC time
#
# + milliseconds - JavaScript timestamp in milliseconds
# + return - The corresponding UTC time
@display {label: "Convert from JS Timestamp", iconPath: "icon.png"}
public isolated function fromJsTimestamp(@display {label: "Milliseconds"} decimal milliseconds) returns time:Utc|time:Error {
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
@display {label: "Convert to JS Timestamp", iconPath: "icon.png"}
public isolated function toJsTimestamp(@display {label: "UTC Time"} time:Utc utcTime) returns decimal|time:Error {
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
@display {label: "Convert from Python Timestamp", iconPath: "icon.png"}
public isolated function fromPythonTimestamp(@display {label: "Seconds"} decimal seconds) returns time:Utc|time:Error {
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
@display {label: "Convert to Python Timestamp", iconPath: "icon.png"}
public isolated function toPythonTimestamp(@display {label: "UTC Time"} time:Utc utcTime) returns decimal|time:Error {
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
@display {label: "Convert from Unix Timestamp", iconPath: "icon.png"}
public isolated function fromUnixTimestamp(@display {label: "Seconds"} int seconds) returns time:Utc|time:Error {
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
@display {label: "Convert to Unix Timestamp", iconPath: "icon.png"}
public isolated function toUnixTimestamp(@display {label: "UTC Time"} time:Utc utcTime) returns int|time:Error {
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
