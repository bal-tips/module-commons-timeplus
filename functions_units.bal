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

# Gets the exact start of a given time unit
#
# + utcTime - The UTC time
# + unit - The time unit (year, month, day, hour, minute, second)
# + return - The time at the start of the unit
@display {label: "Get Start of Time Unit", iconPath: "icon.png"}
public isolated function startOf(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Time Unit"} Unit unit) returns time:Utc|time:Error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    match unit {
        YEAR => {
            time:Civil startCivil = {
                year: civilTime.year,
                month: 1,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0.0d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(startCivil);
        }
        MONTH => {
            time:Civil startCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0.0d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(startCivil);
        }
        DAY => {
            time:Civil startCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: 0,
                minute: 0,
                second: 0.0d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(startCivil);
        }
        HOUR => {
            time:Civil startCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: civilTime.hour,
                minute: 0,
                second: 0.0d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(startCivil);
        }
        MINUTE => {
            time:Civil startCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: civilTime.hour,
                minute: civilTime.minute,
                second: 0.0d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(startCivil);
        }
        SECOND => {
            decimal currentSecond = civilTime.second ?: 0.0d;
            decimal fractionalPart = currentSecond % 1.0d;
            
            // If already at whole second (fractional part is 0), return as is
            if (fractionalPart == 0.0d) {
                return utcTime;
            }
            
            // Calculate seconds to subtract to get to start of second
            decimal secondsToSubtract = fractionalPart;
            return time:utcAddSeconds(utcTime, -secondsToSubtract);
        }
        _ => {
            return utcTime; // Default fallback
        }
    }
}

# Gets the exact end of a given time unit
#
# + utcTime - The UTC time
# + unit - The time unit (year, month, day, hour, minute, second)
# + return - The time at the end of the unit
@display {label: "Get End of Time Unit", iconPath: "icon.png"}
public isolated function endOf(@display {label: "UTC Time"} time:Utc utcTime, @display {label: "Time Unit"} Unit unit) returns time:Utc|time:Error {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    match unit {
        YEAR => {
            time:Civil endCivil = {
                year: civilTime.year,
                month: 12,
                day: 31,
                hour: 23,
                minute: 59,
                second: 59.999d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(endCivil);
        }
        MONTH => {
            int lastDay = daysInMonth(utcTime);
            time:Civil endCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: lastDay,
                hour: 23,
                minute: 59,
                second: 59.999d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(endCivil);
        }
        DAY => {
            time:Civil endCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: 23,
                minute: 59,
                second: 59.999d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(endCivil);
        }
        HOUR => {
            time:Civil endCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: civilTime.hour,
                minute: 59,
                second: 59.999d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(endCivil);
        }
        MINUTE => {
            time:Civil endCivil = {
                year: civilTime.year,
                month: civilTime.month,
                day: civilTime.day,
                hour: civilTime.hour,
                minute: civilTime.minute,
                second: 59.999d,
                utcOffset: {hours: 0, minutes: 0}
            };
            return time:utcFromCivil(endCivil);
        }
        SECOND => {
            decimal currentSecond = civilTime.second ?: 0.0d;
            decimal fractionalPart = currentSecond % 1.0d;
            
            // If already at .999, return as is
            if (fractionalPart >= 0.999d) {
                return utcTime;
            }
            
            // Calculate seconds to add to get to end of second
            decimal secondsToAdd = 0.999d - fractionalPart;
            return time:utcAddSeconds(utcTime, secondsToAdd);
        }
        _ => {
            return utcTime; // Default fallback
        }
    }
}
