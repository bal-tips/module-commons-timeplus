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

# Gets the year component from a UTC time
#
# + utcTime - The UTC time
# + return - The year
public isolated function getYear(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    return civilTime.year;
}

# Gets the month component from a UTC time
#
# + utcTime - The UTC time
# + return - The month (1-12)
public isolated function getMonth(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    return civilTime.month;
}

# Gets the day component from a UTC time
#
# + utcTime - The UTC time
# + return - The day of month (1-31)
public isolated function getDay(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    return civilTime.day;
}

# Gets the hour component from a UTC time
#
# + utcTime - The UTC time
# + return - The hour (0-23)
public isolated function getHour(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    return civilTime.hour;
}

# Gets the minute component from a UTC time
#
# + utcTime - The UTC time
# + return - The minute (0-59)
public isolated function getMinute(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    return civilTime.minute;
}

# Gets the second component from a UTC time
#
# + utcTime - The UTC time
# + return - The second (0-59.999...)
public isolated function getSecond(time:Utc utcTime) returns decimal {
    time:Civil civilTime = time:utcToCivil(utcTime);
    decimal? second = civilTime.second;
    return second ?: 0.0;
}

# Gets the day of week from a UTC time
#
# + utcTime - The UTC time
# + return - The day of week as integer (0=Saturday, 1=Sunday, 2=Monday, etc.)
public isolated function getDayOfWeek(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Use Zeller's congruence algorithm to calculate day of week
    int year = civilTime.year;
    int month = civilTime.month;
    int day = civilTime.day;
    
    // Adjust month and year for Zeller's congruence (January and February are counted as months 13 and 14 of the previous year)
    if month < 3 {
        month += 12;
        year -= 1;
    }
    
    // Zeller's congruence formula
    int century = year / 100;
    int yearOfCentury = year % 100;
    int dayOfWeek = (day + ((13 * (month + 1)) / 5) + yearOfCentury + (yearOfCentury / 4) + (century / 4) - (2 * century)) % 7;
    
    return dayOfWeek;
}

# Gets the day of week name from a UTC time with locale support
#
# + utcTime - The UTC time
# + locale - The locale to use (defaults to EN)
# + return - The day of week name
public isolated function getDayOfWeekName(time:Utc utcTime, Locale locale = EN) returns string {
    int dayOfWeek = getDayOfWeek(utcTime);
    
    // Convert Zeller's result (0=Saturday, 1=Sunday, 2=Monday, ..., 6=Friday) to day names
    match locale {
        EN|EN_US|EN_CA|EN_AU|EN_NZ|EN_GB => {
            match dayOfWeek {
                0 => { return "Saturday"; }
                1 => { return "Sunday"; }
                2 => { return "Monday"; }
                3 => { return "Tuesday"; }
                4 => { return "Wednesday"; }
                5 => { return "Thursday"; }
                6 => { return "Friday"; }
                _ => { return "Sunday"; } // Default fallback
            }
        }
        _ => {
            // Default fallback to EN
            return getDayOfWeekName(utcTime, EN);
        }
    }
}

# Gets the day of year from a UTC time
#
# + utcTime - The UTC time
# + return - The day of year (1-366)
public isolated function getDayOfYear(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Calculate day of year
    int[] daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    // Check if leap year
    boolean isLeap = (civilTime.year % 4 == 0 && civilTime.year % 100 != 0) || (civilTime.year % 400 == 0);
    if isLeap {
        daysInMonth[1] = 29; // February has 29 days in leap year
    }
    
    int dayOfYear = civilTime.day;
    int monthIndex = 0;
    while monthIndex < civilTime.month - 1 {
        dayOfYear += daysInMonth[monthIndex];
        monthIndex += 1;
    }
    
    return dayOfYear;
}

# Gets the week of year from a UTC time
#
# + utcTime - The UTC time
# + return - The week of year (1-53)
public isolated function getWeekOfYear(time:Utc utcTime) returns int {
    int dayOfYear = getDayOfYear(utcTime);
    
    // Simple week calculation (can be improved)
    return (dayOfYear - 1) / 7 + 1;
}

# Gets the localized name for a time unit
#
# + unit - The unit enum value
# + locale - The locale to use (defaults to EN)  
# + singular - Whether to return singular form (defaults to true)
# + return - The localized unit name
public isolated function getUnitName(Unit unit, Locale locale = EN, boolean singular = true) returns string {
    match locale {
        EN|EN_US|EN_CA|EN_AU|EN_NZ|EN_GB => {
            match unit {
                YEAR => { return singular ? "year" : "years"; }
                MONTH => { return singular ? "month" : "months"; }
                DAY => { return singular ? "day" : "days"; }
                HOUR => { return singular ? "hour" : "hours"; }
                MINUTE => { return singular ? "minute" : "minutes"; }
                SECOND => { return singular ? "second" : "seconds"; }
                _ => { return singular ? "unit" : "units"; }
            }
        }
        _ => {
            // Default fallback to EN
            return getUnitName(unit, EN, singular);
        }
    }
}
