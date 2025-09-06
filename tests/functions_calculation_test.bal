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

import ballerina/test;
import ballerina/time;

@test:Config {}
function testAdd() returns error? {
    // Test adding days
    time:Utc baseTime = check time:utcFromString("2023-09-15T12:00:00Z");
    Duration daysDuration = {days: 5};
    time:Utc result = check add(baseTime, daysDuration);
    time:Utc expected = check time:utcFromString("2023-09-20T12:00:00Z");
    test:assertEquals(result, expected, "Adding 5 days should work correctly");

    // Test adding hours
    Duration hoursDuration = {hours: 3};
    result = check add(baseTime, hoursDuration);
    expected = check time:utcFromString("2023-09-15T15:00:00Z");
    test:assertEquals(result, expected, "Adding 3 hours should work correctly");

    // Test adding minutes
    Duration minutesDuration = {minutes: 30};
    result = check add(baseTime, minutesDuration);
    expected = check time:utcFromString("2023-09-15T12:30:00Z");
    test:assertEquals(result, expected, "Adding 30 minutes should work correctly");

    // Test adding seconds
    Duration secondsDuration = {seconds: 45.5};
    result = check add(baseTime, secondsDuration);
    expected = check time:utcFromString("2023-09-15T12:00:45.500Z");
    test:assertEquals(result, expected, "Adding 45.5 seconds should work correctly");

    // Test adding months
    Duration monthsDuration = {months: 2};
    result = check add(baseTime, monthsDuration);
    expected = check time:utcFromString("2023-11-15T12:00:00Z");
    test:assertEquals(result, expected, "Adding 2 months should work correctly");

    // Test adding years
    Duration yearsDuration = {years: 1};
    result = check add(baseTime, yearsDuration);
    expected = check time:utcFromString("2024-09-15T12:00:00Z");
    test:assertEquals(result, expected, "Adding 1 year should work correctly");

    // Test complex duration with multiple components
    Duration complexDuration = {years: 1, months: 2, days: 10, hours: 5, minutes: 30, seconds: 15.25};
    result = check add(baseTime, complexDuration);
    expected = check time:utcFromString("2024-11-25T17:30:15.250Z");
    test:assertEquals(result, expected, "Adding complex duration should work correctly");

    // Test month overflow (adding 13 months should add 1 year and 1 month)
    Duration overflowDuration = {months: 13};
    result = check add(baseTime, overflowDuration);
    expected = check time:utcFromString("2024-10-15T12:00:00Z");
    test:assertEquals(result, expected, "Month overflow should be handled correctly");
}

@test:Config {}
function testSubtract() returns error? {
    // Test subtracting days
    time:Utc baseTime = check time:utcFromString("2023-09-15T12:00:00Z");
    Duration daysDuration = {days: 5};
    time:Utc result = check subtract(baseTime, daysDuration);
    time:Utc expected = check time:utcFromString("2023-09-10T12:00:00Z");
    test:assertEquals(result, expected, "Subtracting 5 days should work correctly");

    // Test subtracting hours
    Duration hoursDuration = {hours: 3};
    result = check subtract(baseTime, hoursDuration);
    expected = check time:utcFromString("2023-09-15T09:00:00Z");
    test:assertEquals(result, expected, "Subtracting 3 hours should work correctly");

    // Test subtracting minutes
    Duration minutesDuration = {minutes: 30};
    result = check subtract(baseTime, minutesDuration);
    expected = check time:utcFromString("2023-09-15T11:30:00Z");
    test:assertEquals(result, expected, "Subtracting 30 minutes should work correctly");

    // Test subtracting seconds with underflow
    Duration secondsDuration = {seconds: 45.5};
    result = check subtract(baseTime, secondsDuration);
    expected = check time:utcFromString("2023-09-15T11:59:14.500Z");
    test:assertEquals(result, expected, "Subtracting 45.5 seconds should work correctly");

    // Test subtracting months
    Duration monthsDuration = {months: 2};
    result = check subtract(baseTime, monthsDuration);
    expected = check time:utcFromString("2023-07-15T12:00:00Z");
    test:assertEquals(result, expected, "Subtracting 2 months should work correctly");

    // Test subtracting years
    Duration yearsDuration = {years: 1};
    result = check subtract(baseTime, yearsDuration);
    expected = check time:utcFromString("2022-09-15T12:00:00Z");
    test:assertEquals(result, expected, "Subtracting 1 year should work correctly");

    // Test complex duration with multiple components
    Duration complexDuration = {years: 1, months: 2, days: 10, hours: 5, minutes: 30, seconds: 15.25};
    result = check subtract(baseTime, complexDuration);
    expected = check time:utcFromString("2022-07-05T06:29:44.750Z");
    test:assertEquals(result, expected, "Subtracting complex duration should work correctly");

    // Test month underflow (subtracting from January should go to previous year)
    time:Utc januaryTime = check time:utcFromString("2023-01-15T12:00:00Z");
    Duration underflowDuration = {months: 3};
    result = check subtract(januaryTime, underflowDuration);
    expected = check time:utcFromString("2022-10-15T12:00:00Z");
    test:assertEquals(result, expected, "Month underflow should be handled correctly");
}

@test:Config {}
function testDifference() returns error? {
    // Test difference in days
    time:Utc time1 = check time:utcFromString("2023-09-10T12:00:00Z");
    time:Utc time2 = check time:utcFromString("2023-09-15T12:00:00Z");
    Duration diff = difference(time1, time2);
    test:assertEquals(diff.days, 5, "Difference should be 5 days");
    test:assertEquals(diff.hours, 0, "Hours should be 0");
    test:assertEquals(diff.minutes, 0, "Minutes should be 0");
    test:assertEquals(diff.seconds, 0.0d, "Seconds should be 0");

    // Test difference in hours
    time1 = check time:utcFromString("2023-09-15T09:00:00Z");
    time2 = check time:utcFromString("2023-09-15T15:00:00Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, 0, "Days should be 0");
    test:assertEquals(diff.hours, 6, "Difference should be 6 hours");
    test:assertEquals(diff.minutes, 0, "Minutes should be 0");
    test:assertEquals(diff.seconds, 0.0d, "Seconds should be 0");

    // Test difference in minutes
    time1 = check time:utcFromString("2023-09-15T12:00:00Z");
    time2 = check time:utcFromString("2023-09-15T12:45:00Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, 0, "Days should be 0");
    test:assertEquals(diff.hours, 0, "Hours should be 0");
    test:assertEquals(diff.minutes, 45, "Difference should be 45 minutes");
    test:assertEquals(diff.seconds, 0.0d, "Seconds should be 0");

    // Test difference in seconds with fractional seconds
    time1 = check time:utcFromString("2023-09-15T12:00:00Z");
    time2 = check time:utcFromString("2023-09-15T12:00:30.500Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, 0, "Days should be 0");
    test:assertEquals(diff.hours, 0, "Hours should be 0");
    test:assertEquals(diff.minutes, 0, "Minutes should be 0");
    test:assertEquals(diff.seconds, 30.5d, "Difference should be 30.5 seconds");

    // Test complex difference
    time1 = check time:utcFromString("2023-09-15T10:30:15Z");
    time2 = check time:utcFromString("2023-09-17T14:45:30Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, 2, "Difference should be 2 days");
    test:assertEquals(diff.hours, 4, "Difference should include 4 hours");
    test:assertEquals(diff.minutes, 15, "Difference should include 15 minutes");
    test:assertEquals(diff.seconds, 15.0d, "Difference should include 15 seconds");

    // Test negative difference (time1 > time2)
    time1 = check time:utcFromString("2023-09-15T12:00:00Z");
    time2 = check time:utcFromString("2023-09-10T12:00:00Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, -5, "Negative difference should be -5 days");
    test:assertEquals(diff.hours, 0, "Hours should be 0");
    test:assertEquals(diff.minutes, 0, "Minutes should be 0");
    test:assertEquals(diff.seconds, 0.0d, "Seconds should be 0");

    // Test same time (zero difference)
    time1 = check time:utcFromString("2023-09-15T12:00:00Z");
    time2 = check time:utcFromString("2023-09-15T12:00:00Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.days, 0, "Days should be 0 for same time");
    test:assertEquals(diff.hours, 0, "Hours should be 0 for same time");
    test:assertEquals(diff.minutes, 0, "Minutes should be 0 for same time");
    test:assertEquals(diff.seconds, 0.0d, "Seconds should be 0 for same time");
}

@test:Config {}
function testAddSubtractSymmetry() returns error? {
    // Test that adding and then subtracting the same duration returns to original time
    time:Utc originalTime = check time:utcFromString("2023-09-15T12:30:45.500Z");
    Duration testDuration = {days: 10, hours: 8, minutes: 30, seconds: 25.75};
    
    time:Utc addedTime = check add(originalTime, testDuration);
    time:Utc backToOriginal = check subtract(addedTime, testDuration);
    
    test:assertEquals(backToOriginal, originalTime, "Add then subtract should return to original time");
}

@test:Config {}
function testEdgeCases() returns error? {
    // Test adding zero duration
    time:Utc baseTime = check time:utcFromString("2023-09-15T12:00:00Z");
    Duration zeroDuration = {};
    time:Utc result = check add(baseTime, zeroDuration);
    test:assertEquals(result, baseTime, "Adding zero duration should return same time");

    // Test subtracting zero duration
    result = check subtract(baseTime, zeroDuration);
    test:assertEquals(result, baseTime, "Subtracting zero duration should return same time");

    // Test simple month addition that doesn't cause day overflow
    time:Utc midMonth = check time:utcFromString("2023-03-15T12:00:00Z");
    Duration oneMonth = {months: 1};
    result = check add(midMonth, oneMonth);
    time:Utc expected = check time:utcFromString("2023-04-15T12:00:00Z");
    test:assertEquals(result, expected, "Adding month to mid-month date should work correctly");
}

@test:Config {}
function testLeapYearAndMonthEndCases() returns error? {
    // Test leap year Feb 29 + 1 year = Feb 28 (non-leap year)
    time:Utc leapYearFeb29 = check time:utcFromString("2024-02-29T12:00:00Z");
    Duration oneYear = {years: 1};
    time:Utc result = check add(leapYearFeb29, oneYear);
    time:Utc expected = check time:utcFromString("2025-02-28T12:00:00Z");
    test:assertEquals(result, expected, "Feb 29 leap year + 1 year should become Feb 28 non-leap year");

    // Test leap year Feb 29 + 4 years = Feb 29 (next leap year)
    Duration fourYears = {years: 4};
    result = check add(leapYearFeb29, fourYears);
    expected = check time:utcFromString("2028-02-29T12:00:00Z");
    test:assertEquals(result, expected, "Feb 29 leap year + 4 years should remain Feb 29 in next leap year");

    // Test Jan 31 + 1 month = Feb 28 (non-leap year)
    time:Utc jan31 = check time:utcFromString("2023-01-31T12:00:00Z");
    Duration oneMonth = {months: 1};
    result = check add(jan31, oneMonth);
    expected = check time:utcFromString("2023-02-28T12:00:00Z");
    test:assertEquals(result, expected, "Jan 31 + 1 month should become Feb 28 in non-leap year");

    // Test Jan 31 + 1 month = Feb 29 (leap year)
    time:Utc jan31LeapYear = check time:utcFromString("2024-01-31T12:00:00Z");
    result = check add(jan31LeapYear, oneMonth);
    expected = check time:utcFromString("2024-02-29T12:00:00Z");
    test:assertEquals(result, expected, "Jan 31 + 1 month should become Feb 29 in leap year");

    // Test March 31 + 1 month = April 30 (April has 30 days)
    time:Utc mar31 = check time:utcFromString("2023-03-31T12:00:00Z");
    result = check add(mar31, oneMonth);
    expected = check time:utcFromString("2023-04-30T12:00:00Z");
    test:assertEquals(result, expected, "Mar 31 + 1 month should become Apr 30");

    // Test May 31 + 1 month = June 30 (June has 30 days)
    time:Utc may31 = check time:utcFromString("2023-05-31T12:00:00Z");
    result = check add(may31, oneMonth);
    expected = check time:utcFromString("2023-06-30T12:00:00Z");
    test:assertEquals(result, expected, "May 31 + 1 month should become Jun 30");

    // Test subtraction edge cases
    // Test Mar 31 - 1 month = Feb 28 (non-leap year)
    result = check subtract(mar31, oneMonth);
    expected = check time:utcFromString("2023-02-28T12:00:00Z");
    test:assertEquals(result, expected, "Mar 31 - 1 month should become Feb 28 in non-leap year");

    // Test Feb 28 non-leap year + 1 year = Feb 28 next year
    time:Utc feb28NonLeap = check time:utcFromString("2023-02-28T12:00:00Z");
    result = check add(feb28NonLeap, oneYear);
    expected = check time:utcFromString("2024-02-28T12:00:00Z");
    test:assertEquals(result, expected, "Feb 28 non-leap year + 1 year should remain Feb 28");
}
