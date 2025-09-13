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

# Checks if the first time is before the second time
#
# + time1 - The first time
# + time2 - The second time
# + return - True if time1 is before time2
@display {label: "Is Before", iconPath: "icon.png"}
public isolated function isBefore(@display {label: "First Time"} time:Utc time1, @display {label: "Second Time"} time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff > 0.0d;
}

# Checks if the first time is after the second time
#
# + time1 - The first time
# + time2 - The second time
# + return - True if time1 is after time2
@display {label: "Is After", iconPath: "icon.png"}
public isolated function isAfter(@display {label: "First Time"} time:Utc time1, @display {label: "Second Time"} time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff < 0.0d;
}

# Checks if two times are identical
#
# + time1 - The first time
# + time2 - The second time
# + return - True if the times are identical
@display {label: "Is Same Time", iconPath: "icon.png"}
public isolated function isSame(@display {label: "First Time"} time:Utc time1, @display {label: "Second Time"} time:Utc time2) returns boolean {
    decimal diff = time:utcDiffSeconds(time2, time1);
    return diff == 0.0d;
}

# Checks if a time falls between two other times
#
# + timeToCheck - The time to check
# + startTime - The start time
# + endTime - The end time
# + return - True if timeToCheck is between startTime and endTime (inclusive)
@display {label: "Is Between Times", iconPath: "icon.png"}
public isolated function isBetween(@display {label: "Time to Check"} time:Utc timeToCheck, @display {label: "Start Time"} time:Utc startTime, @display {label: "End Time"} time:Utc endTime) returns boolean {
    return (isSame(timeToCheck, startTime) || isAfter(timeToCheck, startTime)) &&
            (isSame(timeToCheck, endTime) || isBefore(timeToCheck, endTime));
}

# Checks if a year is a leap year
#
# + utcTime - The UTC time containing the year to check
# + return - True if the year is a leap year
@display {label: "Is Leap Year", iconPath: "icon.png"}
public isolated function isLeapYear(@display {label: "UTC Time"} time:Utc utcTime) returns boolean {
    int year = getYear(utcTime);
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

# Gets the number of days in the month of the given time
#
# + utcTime - The UTC time
# + return - The number of days in the month
@display {label: "Get Days in Month", iconPath: "icon.png"}
public isolated function daysInMonth(@display {label: "UTC Time"} time:Utc utcTime) returns int {
    time:Civil civilTime = time:utcToCivil(utcTime);
    int[] daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if civilTime.month == 2 && isLeapYear(utcTime) {
        return 29;
    }

    return daysInMonths[civilTime.month - 1];
}
