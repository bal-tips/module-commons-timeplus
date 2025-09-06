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
public isolated function addDays(time:Utc utcTime, int days) returns time:Utc|time:Error {
    Duration duration = {days: days};
    return add(utcTime, duration);
}

# Adds specified number of hours to a UTC time
#
# + utcTime - The UTC time
# + hours - The number of hours to add
# + return - The resulting UTC time
public isolated function addHours(time:Utc utcTime, int hours) returns time:Utc|time:Error {
    Duration duration = {hours: hours};
    return add(utcTime, duration);
}

# Adds specified number of minutes to a UTC time
#
# + utcTime - The UTC time
# + minutes - The number of minutes to add
# + return - The resulting UTC time
public isolated function addMinutes(time:Utc utcTime, int minutes) returns time:Utc|time:Error {
    Duration duration = {minutes: minutes};
    return add(utcTime, duration);
}

# Adds specified number of seconds to a UTC time
#
# + utcTime - The UTC time
# + seconds - The number of seconds to add
# + return - The resulting UTC time
public isolated function addSeconds(time:Utc utcTime, decimal seconds) returns time:Utc|time:Error {
    Duration duration = {seconds: seconds};
    return add(utcTime, duration);
}

# Adds specified number of weeks to a UTC time
#
# + utcTime - The UTC time
# + weeks - The number of weeks to add
# + return - The resulting UTC time
public isolated function addWeeks(time:Utc utcTime, int weeks) returns time:Utc|time:Error {
    Duration duration = {days: weeks * 7};
    return add(utcTime, duration);
}

# Adds specified number of months to a UTC time
#
# + utcTime - The UTC time
# + months - The number of months to add
# + return - The resulting UTC time
public isolated function addMonths(time:Utc utcTime, int months) returns time:Utc|time:Error {
    Duration duration = {months: months};
    return add(utcTime, duration);
}

# Adds specified number of years to a UTC time
#
# + utcTime - The UTC time
# + years - The number of years to add
# + return - The resulting UTC time
public isolated function addYears(time:Utc utcTime, int years) returns time:Utc|time:Error {
    Duration duration = {years: years};
    return add(utcTime, duration);
}

# Subtracts specified number of days from a UTC time
#
# + utcTime - The UTC time
# + days - The number of days to subtract
# + return - The resulting UTC time
public isolated function subtractDays(time:Utc utcTime, int days) returns time:Utc|time:Error {
    Duration duration = {days: days};
    return subtract(utcTime, duration);
}

# Subtracts specified number of hours from a UTC time
#
# + utcTime - The UTC time
# + hours - The number of hours to subtract
# + return - The resulting UTC time
public isolated function subtractHours(time:Utc utcTime, int hours) returns time:Utc|time:Error {
    Duration duration = {hours: hours};
    return subtract(utcTime, duration);
}

# Subtracts specified number of minutes from a UTC time
#
# + utcTime - The UTC time
# + minutes - The number of minutes to subtract
# + return - The resulting UTC time
public isolated function subtractMinutes(time:Utc utcTime, int minutes) returns time:Utc|time:Error {
    Duration duration = {minutes: minutes};
    return subtract(utcTime, duration);
}

# Subtracts specified number of seconds from a UTC time
#
# + utcTime - The UTC time
# + seconds - The number of seconds to subtract
# + return - The resulting UTC time
public isolated function subtractSeconds(time:Utc utcTime, decimal seconds) returns time:Utc|time:Error {
    Duration duration = {seconds: seconds};
    return subtract(utcTime, duration);
}

# Subtracts specified number of weeks from a UTC time
#
# + utcTime - The UTC time
# + weeks - The number of weeks to subtract
# + return - The resulting UTC time
public isolated function subtractWeeks(time:Utc utcTime, int weeks) returns time:Utc|time:Error {
    Duration duration = {days: weeks * 7};
    return subtract(utcTime, duration);
}

# Subtracts specified number of months from a UTC time
#
# + utcTime - The UTC time
# + months - The number of months to subtract
# + return - The resulting UTC time
public isolated function subtractMonths(time:Utc utcTime, int months) returns time:Utc|time:Error {
    Duration duration = {months: months};
    return subtract(utcTime, duration);
}

# Subtracts specified number of years from a UTC time
#
# + utcTime - The UTC time
# + years - The number of years to subtract
# + return - The resulting UTC time
public isolated function subtractYears(time:Utc utcTime, int years) returns time:Utc|time:Error {
    Duration duration = {years: years};
    return subtract(utcTime, duration);
}
