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

# Adds a duration to a UTC time
#
# + utcTime - The UTC time to add to
# + duration - The duration to add
# + return - The resulting UTC time
public isolated function add(time:Utc utcTime, Duration duration) returns time:Utc|error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Add each component if present
    int year = civilTime.year + (duration.years ?: 0);
    int month = civilTime.month + (duration.months ?: 0);
    int day = civilTime.day + (duration.days ?: 0);
    int hour = civilTime.hour + (duration.hours ?: 0);
    int minute = civilTime.minute + (duration.minutes ?: 0);
    decimal seconds = duration.seconds ?: 0.0;
    decimal second = (civilTime.second ?: 0.0) + seconds;
    
    // Handle month overflow
    while month > 12 {
        year += 1;
        month -= 12;
    }
    
    // Handle day overflow for months with different day counts
    // Get the maximum days in the target month
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    // Check if target year is leap year for February
    boolean isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if month == 2 && isLeap {
        daysInMonths[1] = 29; // February has 29 days in leap year
    }
    
    int maxDaysInMonth = daysInMonths[month - 1];
    if day > maxDaysInMonth {
        day = maxDaysInMonth; // Clamp to last day of month
    }
    
    // Handle second overflow
    while second >= 60.0d {
        second -= 60.0d;
        minute += 1;
    }
    
    // Handle minute overflow
    while minute >= 60 {
        minute -= 60;
        hour += 1;
    }
    
    // Handle hour overflow
    while hour >= 24 {
        hour -= 24;
        day += 1;
    }
    
    // Create new civil time and convert back to UTC
    time:Civil newCivil = {
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        utcOffset: {hours: 0, minutes: 0}  // UTC timezone
    };
    
    return time:utcFromCivil(newCivil);
}

# Subtracts a duration from a UTC time
#
# + utcTime - The UTC time to subtract from
# + duration - The duration to subtract
# + return - The resulting UTC time
public isolated function subtract(time:Utc utcTime, Duration duration) returns time:Utc|error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Subtract each component if present
    int year = civilTime.year - (duration.years ?: 0);
    int month = civilTime.month - (duration.months ?: 0);
    int day = civilTime.day - (duration.days ?: 0);
    int hour = civilTime.hour - (duration.hours ?: 0);
    int minute = civilTime.minute - (duration.minutes ?: 0);
    decimal seconds = duration.seconds ?: 0.0;
    decimal second = (civilTime.second ?: 0.0) - seconds;

    // Handle second underflow
    if second < 0.0d {
        second += 60.0d;
        minute -= 1;
    }

    // Handle minute underflow
    if minute < 0 {
        minute += 60;
        hour -= 1;
    }

    // Handle hour underflow
    if hour < 0 {
        hour += 24;
        day -= 1;
    }

    // Handle month underflow
    while month < 1 {
        year -= 1;
        month += 12;
    }
    
    // Handle day overflow for months with different day counts
    // Get the maximum days in the target month
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    // Check if target year is leap year for February
    boolean isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if month == 2 && isLeap {
        daysInMonths[1] = 29; // February has 29 days in leap year
    }
    
    int maxDaysInMonth = daysInMonths[month - 1];
    if day > maxDaysInMonth {
        day = maxDaysInMonth; // Clamp to last day of month
    }
    
    // Create new civil time and convert back to UTC
    time:Civil newCivil = {
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        utcOffset: {hours: 0, minutes: 0}  // UTC timezone
    };
    
    return time:utcFromCivil(newCivil);
}

# Calculates the duration between two UTC times
#
# + time1 - The first time
# + time2 - The second time
# + return - The duration from time1 to time2
public isolated function difference(time:Utc time1, time:Utc time2) returns Duration {
    decimal diffSeconds = time:utcDiffSeconds(time2, time1);
    
    // Convert to approximate duration components
    int totalSeconds = <int>diffSeconds;
    decimal fractionalSeconds = diffSeconds - <decimal>totalSeconds;
    
    int days = totalSeconds / (24 * 3600);
    totalSeconds = totalSeconds % (24 * 3600);
    
    int hours = totalSeconds / 3600;
    totalSeconds = totalSeconds % 3600;
    
    int minutes = totalSeconds / 60;
    int seconds = totalSeconds % 60;
    
    return {
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: <decimal>seconds + fractionalSeconds
    };
}
