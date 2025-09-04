// Copyright (c) 2025 Hasitha Aravinda. All Rights Reserved.
//
// This software may be modified and distributed under the terms
// of the MIT license. See the LICENSE file for details.

import ballerina/time;

# Checks if the first time is before the second time
#
# + time1 - The first time
# + time2 - The second time
# + return - True if time1 is before time2
public isolated function isBefore(time:Utc time1, time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff > 0.0d;
}

# Checks if the first time is after the second time
#
# + time1 - The first time
# + time2 - The second time
# + return - True if time1 is after time2
public isolated function isAfter(time:Utc time1, time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff < 0.0d;
}

# Checks if two times are identical
#
# + time1 - The first time
# + time2 - The second time
# + return - True if the times are identical
public isolated function isSame(time:Utc time1, time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff == 0.0d;
}

# Checks if a time falls between two other times
#
# + timeToCheck - The time to check
# + startTime - The start time
# + endTime - The end time
# + return - True if timeToCheck is between startTime and endTime (inclusive)
public isolated function isBetween(time:Utc timeToCheck, time:Utc startTime, time:Utc endTime) returns boolean {
    return (isSame(timeToCheck, startTime) || isAfter(timeToCheck, startTime)) && 
           (isSame(timeToCheck, endTime) || isBefore(timeToCheck, endTime));
}

# Checks if a year is a leap year
#
# + utcTime - The UTC time containing the year to check
# + return - True if the year is a leap year
public isolated function isLeapYear(time:Utc utcTime) returns boolean {
    int year = getYear(utcTime);
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

# Gets the number of days in the month of the given time
#
# + utcTime - The UTC time
# + return - The number of days in the month
public isolated function daysInMonth(time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    
    if civilTime.month == 2 && isLeapYear(utcTime) {
        return 29;
    }
    
    return daysInMonths[civilTime.month - 1];
}
