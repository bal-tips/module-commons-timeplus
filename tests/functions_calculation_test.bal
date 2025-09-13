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
function testAdvancedEdgeCases() returns error? {
    // Test multiple month overflows (adding 25 months should be 2 years and 1 month)
    time:Utc baseTime = check time:utcFromString("2023-01-15T12:00:00Z");
    Duration twentyFiveMonths = {months: 25};
    time:Utc result = check add(baseTime, twentyFiveMonths);
    time:Utc expected = check time:utcFromString("2025-02-15T12:00:00Z");
    test:assertEquals(result, expected, "Adding 25 months should correctly overflow to 2 years and 1 month");

    // Test negative durations (should be treated as subtraction)
    Duration negativeDuration = {days: -5, hours: -3};
    result = check add(baseTime, negativeDuration);
    expected = check time:utcFromString("2023-01-10T09:00:00Z");
    test:assertEquals(result, expected, "Adding negative duration should work like subtraction");

    // Test complex day underflow in subtraction
    time:Utc jan3 = check time:utcFromString("2023-01-03T12:00:00Z");
    Duration tenDays = {days: 10};
    result = check subtract(jan3, tenDays);
    expected = check time:utcFromString("2022-12-24T12:00:00Z");
    test:assertEquals(result, expected, "Subtracting more days than available should correctly underflow to previous month");

    // Test leap year edge case with day underflow
    time:Utc mar1LeapYear = check time:utcFromString("2024-03-01T12:00:00Z");
    Duration threeDays = {days: 3};
    result = check subtract(mar1LeapYear, threeDays);
    expected = check time:utcFromString("2024-02-27T12:00:00Z");
    test:assertEquals(result, expected, "March 1 - 3 days in leap year should account for February having 29 days");

    // Test century boundary leap year calculation
    time:Utc year1900 = check time:utcFromString("1900-02-28T12:00:00Z");
    Duration oneDay = {days: 1};
    result = check add(year1900, oneDay);
    expected = check time:utcFromString("1900-03-01T12:00:00Z");
    test:assertEquals(result, expected, "1900 was not a leap year (century non-leap), so Feb 28 + 1 day = Mar 1");

    // Test year 2000 leap year calculation
    time:Utc year2000 = check time:utcFromString("2000-02-28T12:00:00Z");
    result = check add(year2000, oneDay);
    expected = check time:utcFromString("2000-02-29T12:00:00Z");
    test:assertEquals(result, expected, "2000 was a leap year (400-year rule), so Feb 28 + 1 day = Feb 29");
}

@test:Config {}
function testPrecisionAndOverflow() returns error? {
    // Test second overflow with fractional seconds
    time:Utc baseTime = check time:utcFromString("2023-09-15T23:59:59.500Z");
    Duration halfSecond = {seconds: 0.5};
    time:Utc result = check add(baseTime, halfSecond);
    time:Utc expected = check time:utcFromString("2023-09-16T00:00:00.000Z");
    test:assertEquals(result, expected, "Adding 0.5 seconds to 23:59:59.500 should roll over to next day");

    // Test minute overflow
    time:Utc beforeMidnight = check time:utcFromString("2023-09-15T23:59:30Z");
    Duration fortySeconds = {seconds: 40.0};
    result = check add(beforeMidnight, fortySeconds);
    expected = check time:utcFromString("2023-09-16T00:00:10.000Z");
    test:assertEquals(result, expected, "Adding 40 seconds to 23:59:30 should roll over to next day");

    // Test hour overflow
    time:Utc lateEvening = check time:utcFromString("2023-09-15T23:30:00Z");
    Duration twoHours = {hours: 2};
    result = check add(lateEvening, twoHours);
    expected = check time:utcFromString("2023-09-16T01:30:00Z");
    test:assertEquals(result, expected, "Adding 2 hours to 23:30 should roll over to next day");

    // Test underflow in seconds
    time:Utc earlyMorning = check time:utcFromString("2023-09-15T00:00:15.500Z");
    Duration twentySeconds = {seconds: 20.0};
    result = check subtract(earlyMorning, twentySeconds);
    expected = check time:utcFromString("2023-09-14T23:59:55.500Z");
    test:assertEquals(result, expected, "Subtracting 20 seconds from 00:00:15.500 should underflow to previous day");
}

@test:Config {}
function testDifferenceEdgeCases() returns error? {
    // Test difference across leap year boundary
    time:Utc feb28_2023 = check time:utcFromString("2023-02-28T12:00:00Z");
    time:Utc feb28_2024 = check time:utcFromString("2024-02-28T12:00:00Z");
    Duration diff = difference(feb28_2023, feb28_2024);
    test:assertEquals(diff.days ?: 0, 365, "Difference across non-leap to leap year should be 365 days");

    time:Utc feb28_2024_start = check time:utcFromString("2024-02-28T12:00:00Z");
    time:Utc feb28_2025 = check time:utcFromString("2025-02-28T12:00:00Z");
    diff = difference(feb28_2024_start, feb28_2025);
    test:assertEquals(diff.days ?: 0, 366, "Difference across leap to non-leap year should be 366 days");

    // Test difference with fractional seconds
    time:Utc time1 = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc time2 = check time:utcFromString("2023-09-15T12:00:00.750Z");
    diff = difference(time1, time2);
    test:assertEquals(diff.seconds ?: 0.0d, 0.75d, "Difference should handle fractional seconds correctly");

    // Test difference in reverse (negative)
    diff = difference(time2, time1);
    test:assertEquals(diff.seconds ?: 0.0d, -0.75d, "Reverse difference should be negative");
}

@test:Config {}
function testMonthBoundaryCalculations() returns error? {
    // Test all month-end dates for proper clamping
    string[] monthEndDates = [
        "2023-01-31", // Jan 31
        "2023-03-31", // Mar 31
        "2023-05-31", // May 31
        "2023-07-31", // Jul 31
        "2023-08-31", // Aug 31
        "2023-10-31", // Oct 31
        "2023-12-31" // Dec 31
    ];

    string[] expectedAfterOneMonth = [
        "2023-02-28", // Jan 31 + 1 month = Feb 28
        "2023-04-30", // Mar 31 + 1 month = Apr 30
        "2023-06-30", // May 31 + 1 month = Jun 30
        "2023-08-31", // Jul 31 + 1 month = Aug 31
        "2023-09-30", // Aug 31 + 1 month = Sep 30
        "2023-11-30", // Oct 31 + 1 month = Nov 30
        "2024-01-31" // Dec 31 + 1 month = Jan 31
    ];

    Duration oneMonth = {months: 1};

    int i = 0;
    while i < monthEndDates.length() {
        time:Utc inputTime = check time:utcFromString(monthEndDates[i] + "T12:00:00Z");
        time:Utc result = check add(inputTime, oneMonth);
        string resultDate = toString(result, YYYY_MM_DD);
        test:assertEquals(resultDate, expectedAfterOneMonth[i],
                string `${monthEndDates[i]} + 1 month should become ${expectedAfterOneMonth[i]}`);
        i += 1;
    }
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

    // Test day underflow edge case - subtracting more days than available in month
    time:Utc mar1 = check time:utcFromString("2023-03-01T12:00:00Z");
    Duration fiveDays = {days: 5};
    result = check subtract(mar1, fiveDays);
    expected = check time:utcFromString("2023-02-24T12:00:00Z");
    test:assertEquals(result, expected, "Mar 1 - 5 days should become Feb 24");
}
