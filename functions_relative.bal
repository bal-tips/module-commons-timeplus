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

# Adds specified number of days to a UTC time
#
# + utcTime - The UTC time
# + days - The number of days to add
# + return - The resulting UTC time
@display {label: "Add Days", iconPath: "icon.png"}
public isolated function addDays(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Days"} int days) returns time:Utc|time:Error {
    Duration duration = {days: days};
    return add(utcTime, duration);
}

# Adds specified number of hours to a UTC time
#
# + utcTime - The UTC time
# + hours - The number of hours to add
# + return - The resulting UTC time
@display {label: "Add Hours", iconPath: "icon.png"}
public isolated function addHours(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Hours"} int hours) returns time:Utc|time:Error {
    Duration duration = {hours: hours};
    return add(utcTime, duration);
}

# Adds specified number of minutes to a UTC time
#
# + utcTime - The UTC time
# + minutes - The number of minutes to add
# + return - The resulting UTC time
@display {label: "Add Minutes", iconPath: "icon.png"}
public isolated function addMinutes(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Minutes"} int minutes) returns time:Utc|time:Error {
    Duration duration = {minutes: minutes};
    return add(utcTime, duration);
}

# Adds specified number of seconds to a UTC time
#
# + utcTime - The UTC time
# + seconds - The number of seconds to add
# + return - The resulting UTC time
@display {label: "Add Seconds", iconPath: "icon.png"}
public isolated function addSeconds(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Seconds"} decimal seconds) returns time:Utc|time:Error {
    Duration duration = {seconds: seconds};
    return add(utcTime, duration);
}

# Adds specified number of weeks to a UTC time
#
# + utcTime - The UTC time
# + weeks - The number of weeks to add
# + return - The resulting UTC time
@display {label: "Add Weeks", iconPath: "icon.png"}
public isolated function addWeeks(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Weeks"} int weeks) returns time:Utc|time:Error {
    Duration duration = {days: weeks * 7};
    return add(utcTime, duration);
}

# Adds specified number of months to a UTC time
#
# + utcTime - The UTC time
# + months - The number of months to add
# + return - The resulting UTC time
@display {label: "Add Months", iconPath: "icon.png"}
public isolated function addMonths(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Months"} int months) returns time:Utc|time:Error {
    Duration duration = {months: months};
    return add(utcTime, duration);
}

# Adds specified number of years to a UTC time
#
# + utcTime - The UTC time
# + years - The number of years to add
# + return - The resulting UTC time
@display {label: "Add Years", iconPath: "icon.png"}
public isolated function addYears(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Years"} int years) returns time:Utc|time:Error {
    Duration duration = {years: years};
    return add(utcTime, duration);
}

# Subtracts specified number of days from a UTC time
#
# + utcTime - The UTC time
# + days - The number of days to subtract
# + return - The resulting UTC time
@display {label: "Subtract Days", iconPath: "icon.png"}
public isolated function subtractDays(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Days"} int days) returns time:Utc|time:Error {
    Duration duration = {days: days};
    return subtract(utcTime, duration);
}

# Subtracts specified number of hours from a UTC time
#
# + utcTime - The UTC time
# + hours - The number of hours to subtract
# + return - The resulting UTC time
@display {label: "Subtract Hours", iconPath: "icon.png"}
public isolated function subtractHours(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Hours"} int hours) returns time:Utc|time:Error {
    Duration duration = {hours: hours};
    return subtract(utcTime, duration);
}

# Subtracts specified number of minutes from a UTC time
#
# + utcTime - The UTC time
# + minutes - The number of minutes to subtract
# + return - The resulting UTC time
@display {label: "Subtract Minutes", iconPath: "icon.png"}
public isolated function subtractMinutes(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Minutes"} int minutes) returns time:Utc|time:Error {
    Duration duration = {minutes: minutes};
    return subtract(utcTime, duration);
}

# Subtracts specified number of seconds from a UTC time
#
# + utcTime - The UTC time
# + seconds - The number of seconds to subtract
# + return - The resulting UTC time
@display {label: "Subtract Seconds", iconPath: "icon.png"}
public isolated function subtractSeconds(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Seconds"} decimal seconds) returns time:Utc|time:Error {
    Duration duration = {seconds: seconds};
    return subtract(utcTime, duration);
}

# Subtracts specified number of weeks from a UTC time
#
# + utcTime - The UTC time
# + weeks - The number of weeks to subtract
# + return - The resulting UTC time
@display {label: "Subtract Weeks", iconPath: "icon.png"}
public isolated function subtractWeeks(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Weeks"} int weeks) returns time:Utc|time:Error {
    Duration duration = {days: weeks * 7};
    return subtract(utcTime, duration);
}

# Subtracts specified number of months from a UTC time
#
# + utcTime - The UTC time
# + months - The number of months to subtract
# + return - The resulting UTC time
@display {label: "Subtract Months", iconPath: "icon.png"}
public isolated function subtractMonths(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Months"} int months) returns time:Utc|time:Error {
    Duration duration = {months: months};
    return subtract(utcTime, duration);
}

# Subtracts specified number of years from a UTC time
#
# + utcTime - The UTC time
# + years - The number of years to subtract
# + return - The resulting UTC time
@display {label: "Subtract Years", iconPath: "icon.png"}
public isolated function subtractYears(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Number of Years"} int years) returns time:Utc|time:Error {
    Duration duration = {years: years};
    return subtract(utcTime, duration);
}
