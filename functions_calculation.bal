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
# Note: Month arithmetic follows calendar conventions. When adding months results
# in an invalid date, the day is clamped to the last valid day of the target month.
# Example: Jan 31 + 1 month = Feb 28 (since February has no 31st day).
#
# + utcTime - The UTC time to add to
# + duration - The duration to add
# + return - The resulting UTC time
@display {label: "Add Duration", iconPath: "icon.png"}
public isolated function add(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Duration"} Duration duration) returns time:Utc|error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Add each component if present
    int year = civilTime.year + (duration.years ?: 0);
    int month = civilTime.month + (duration.months ?: 0);
    int day = civilTime.day; // Don't add days yet
    int hour = civilTime.hour + (duration.hours ?: 0);
    int minute = civilTime.minute + (duration.minutes ?: 0);
    decimal seconds = duration.seconds ?: 0.0;
    decimal second = (civilTime.second ?: 0.0) + seconds;
    
    // Handle month overflow first
    while month > 12 {
        year += 1;
        month -= 12;
    }
    while month < 1 {
        year -= 1;
        month += 12;
    }
    
    // After month/year adjustments, clamp the day to valid range for the target month
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    boolean isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if month == 2 && isLeap {
        daysInMonths[1] = 29; // February has 29 days in leap year
    }
    int maxDaysInMonth = daysInMonths[month - 1];
    if day > maxDaysInMonth {
        day = maxDaysInMonth; // Clamp to last day of month
    }
    
    // Now add the days
    day += (duration.days ?: 0);
    
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
    
    // Now handle day overflow after all time components are calculated
    while day > 1 {
        int[] currentDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        
        // Check if current year is leap year for February
        boolean currentIsLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if month == 2 && currentIsLeap {
            currentDaysInMonths[1] = 29; // February has 29 days in leap year
        }
        
        int currentMaxDaysInMonth = currentDaysInMonths[month - 1];
        if day <= currentMaxDaysInMonth {
            break; // Day is valid for this month
        }
        
        // Day overflow - move to next month
        day -= currentMaxDaysInMonth;
        month += 1;
        if month > 12 {
            month = 1;
            year += 1;
        }
    }
    
    // Handle day underflow
    while day < 1 {
        // Move to previous month
        month -= 1;
        if month < 1 {
            month = 12;
            year -= 1;
        }
        
        // Recalculate max days for the new month
        int[] prevDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        boolean prevIsLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if month == 2 && prevIsLeap {
            prevDaysInMonths[1] = 29;
        }
        
        day += prevDaysInMonths[month - 1];
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
# Note: Month arithmetic follows calendar conventions. When subtracting months results
# in an invalid date, the day is clamped to the last valid day of the target month.
# This may result in asymmetrical behavior with add().
#
# + utcTime - The UTC time to subtract from
# + duration - The duration to subtract
# + return - The resulting UTC time
@display {label: "Subtract Duration", iconPath: "icon.png"}
public isolated function subtract(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Duration"} Duration duration) returns time:Utc|error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Subtract each component if present
    int year = civilTime.year - (duration.years ?: 0);
    int month = civilTime.month - (duration.months ?: 0);
    int day = civilTime.day; // Don't subtract days yet
    int hour = civilTime.hour - (duration.hours ?: 0);
    int minute = civilTime.minute - (duration.minutes ?: 0);
    decimal seconds = duration.seconds ?: 0.0;
    decimal second = (civilTime.second ?: 0.0) - seconds;

    // Handle month underflow first
    while month < 1 {
        year -= 1;
        month += 12;
    }
    while month > 12 {
        year += 1;
        month -= 12;
    }
    
    // After month/year adjustments, clamp the day to valid range for the target month
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    boolean isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    if month == 2 && isLeap {
        daysInMonths[1] = 29; // February has 29 days in leap year
    }
    int maxDaysInMonth = daysInMonths[month - 1];
    if day > maxDaysInMonth {
        day = maxDaysInMonth; // Clamp to last day of month
    }
    
    // Now subtract the days
    day -= (duration.days ?: 0);

    // Handle second underflow
    while second < 0.0d {
        second += 60.0d;
        minute -= 1;
    }

    // Handle minute underflow
    while minute < 0 {
        minute += 60;
        hour -= 1;
    }

    // Handle hour underflow
    while hour < 0 {
        hour += 24;
        day -= 1;
    }
    
    // Now handle day overflow and underflow after all time components are calculated
    while day > 1 {
        int[] currentDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        
        // Check if current year is leap year for February
        boolean currentIsLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if month == 2 && currentIsLeap {
            currentDaysInMonths[1] = 29; // February has 29 days in leap year
        }
        
        int currentMaxDaysInMonth = currentDaysInMonths[month - 1];
        if day <= currentMaxDaysInMonth {
            break; // Day is valid for this month
        }
        
        // Day overflow - move to next month
        day -= currentMaxDaysInMonth;
        month += 1;
        if month > 12 {
            month = 1;
            year += 1;
        }
    }
    
    // Handle day underflow
    while day < 1 {
        // Move to previous month
        month -= 1;
        if month < 1 {
            month = 12;
            year -= 1;
        }
        
        // Recalculate max days for the new month
        int[] prevDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        boolean prevIsLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if month == 2 && prevIsLeap {
            prevDaysInMonths[1] = 29;
        }
        
        day += prevDaysInMonths[month - 1];
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
@display {label: "Calculate Time Difference", iconPath: "icon.png"}
public isolated function difference(@display {label: "First Time"} time:Utc time1, @display {label: "Second Time"} time:Utc time2) returns Duration {
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
