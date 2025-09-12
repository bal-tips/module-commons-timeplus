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

# Checks if the date falls on a weekend (Saturday or Sunday)
#
# + utcTime - The UTC time to check
# + return - True if it's a weekend
@display {label: "Is Weekend", iconPath: "icon.png"}
public isolated function isWeekend(@display {label: "UTC Time"} time:Utc utcTime) returns boolean {
    int dayOfWeek = getDayOfWeek(utcTime);
    return dayOfWeek == 0 || dayOfWeek == 1; // Saturday=0, Sunday=1
}

# Checks if the date falls on a weekday (Monday to Friday)
#
# + utcTime - The UTC time to check
# + return - True if it's a weekday
@display {label: "Is Weekday", iconPath: "icon.png"}
public isolated function isWeekday(@display {label: "UTC Time"} time:Utc utcTime) returns boolean {
    return !isWeekend(utcTime);
}

# Returns the next weekday (skips weekends)
#
# + utcTime - The UTC time
# + return - The next weekday
@display {label: "Get Next Weekday", iconPath: "icon.png"}
public isolated function nextWeekday(@display {label: "UTC Time"} time:Utc utcTime) returns time:Utc|time:Error {
    time:Utc nextDay = check addDays(utcTime, 1);
    while isWeekend(nextDay) {
        nextDay = check addDays(nextDay, 1);
    }
    return nextDay;
}

# Returns the previous weekday (skips weekends)
#
# + utcTime - The UTC time
# + return - The previous weekday
@display {label: "Get Previous Weekday", iconPath: "icon.png"}
public isolated function previousWeekday(@display {label: "UTC Time"} time:Utc utcTime) returns time:Utc|time:Error {
    time:Utc prevDay = check subtractDays(utcTime, 1);
    while isWeekend(prevDay) {
        prevDay = check subtractDays(prevDay, 1);
    }
    return prevDay;
}

# Adds business days (excludes weekends)
#
# + utcTime - The UTC time
# + businessDays - The number of business days to add
# + return - The resulting UTC time
@display {label: "Add Business Days", iconPath: "icon.png"}
public isolated function addBusinessDays(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Business Days"} int businessDays) returns time:Utc|time:Error {
    time:Utc result = utcTime;
    int remainingDays = businessDays;
    
    while remainingDays > 0 {
        result = check addDays(result, 1);
        if isWeekday(result) {
            remainingDays -= 1;
        }
    }
    
    while remainingDays < 0 {
        result = check subtractDays(result, 1);
        if isWeekday(result) {
            remainingDays += 1;
        }
    }
    
    return result;
}

# Calculates age from birth time to current time (or specified time)
#
# + birthTime - The birth time
# + currentTime - The current time (optional, defaults to now)
# + return - The age as a Duration
@display {label: "Calculate Age", iconPath: "icon.png"}
public isolated function age(@display {label: "Birth Time"} time:Utc birthTime, @display {label: "Current Time"} time:Utc? currentTime = ()) returns Duration {
    time:Utc compareTime = currentTime ?: now();
    return difference(birthTime, compareTime);
}

# Returns human-readable duration string with locale support
#
# + duration - The duration to format
# + locale - The locale to use (defaults to EN)
# + return - Human-readable duration string
@display {label: "Convert Duration to Human Readable", iconPath: "icon.png"}
public isolated function humanizeDuration(@display {label: "Duration"} Duration duration, @display {label: "Locale"} Locale locale = EN) returns string {
    string[] parts = [];
    
    if duration.years is int && duration.years > 0 {
        string unitName = getUnitName(YEAR, locale, duration.years == 1);
        parts.push(duration.years.toString() + " " + unitName);
    }
    
    if duration.months is int && duration.months > 0 {
        string unitName = getUnitName(MONTH, locale, duration.months == 1);
        parts.push(duration.months.toString() + " " + unitName);
    }
    
    if duration.days is int && duration.days > 0 {
        string unitName = getUnitName(DAY, locale, duration.days == 1);
        parts.push(duration.days.toString() + " " + unitName);
    }
    
    if duration.hours is int && duration.hours > 0 {
        string unitName = getUnitName(HOUR, locale, duration.hours == 1);
        parts.push(duration.hours.toString() + " " + unitName);
    }
    
    if duration.minutes is int && duration.minutes > 0 {
        string unitName = getUnitName(MINUTE, locale, duration.minutes == 1);
        parts.push(duration.minutes.toString() + " " + unitName);
    }
    
    if parts.length() == 0 {
        string unitName = getUnitName(SECOND, locale, false); // Always plural for "0 seconds"
        return "0 " + unitName;
    }
    
    if parts.length() == 1 {
        return parts[0];
    }
    
    // Join with commas and "and" for the last item
    string result = "";
    foreach int i in 0 ..< parts.length() - 1 {
        if i > 0 {
            result += ", ";
        }
        result += parts[i];
    }
    result += " and " + parts[parts.length() - 1];
    
    return result;
}

# Formats duration according to a custom format string
#
# Note: Currently supports "hh:mm:ss" and "human" formats.
# Additional format options are planned for future releases.
#
# + duration - The duration to format
# + format - The format string (basic implementation)
# + return - Formatted duration string
@display {label: "Format Duration", iconPath: "icon.png"}
public isolated function formatDuration(@display {label: "Duration"} Duration duration, @display {label: "Format String"} string format) returns string {
    // Basic format implementation - can be extended
    match format {
        "hh:mm:ss" => {
            int hours = duration.hours ?: 0;
            int minutes = duration.minutes ?: 0;
            decimal seconds = duration.seconds ?: 0.0d;
            int wholeSeconds = <int>seconds;
            string hourStr = hours < 10 ? "0" + hours.toString() : hours.toString();
            string minStr = minutes < 10 ? "0" + minutes.toString() : minutes.toString();
            string secStr = wholeSeconds < 10 ? "0" + wholeSeconds.toString() : wholeSeconds.toString();
            return string`${hourStr}:${minStr}:${secStr}`;
        }
        "human" => {
            return humanizeDuration(duration);
        }
        _ => {
            // Fallback to human-readable format
            return humanizeDuration(duration);
        }
    }
}
