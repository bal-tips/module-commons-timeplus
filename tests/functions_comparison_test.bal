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
function testIsBefore() returns error? {
    // Test basic before comparison
    time:Utc earlierTime = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc laterTime = check time:utcFromString("2023-09-16T12:00:00Z");
    test:assertTrue(isBefore(earlierTime, laterTime), "Earlier time should be before later time");
    test:assertFalse(isBefore(laterTime, earlierTime), "Later time should not be before earlier time");

    // Test with same time
    test:assertFalse(isBefore(earlierTime, earlierTime), "Same time should not be before itself");

    // Test with different hours
    time:Utc morning = check time:utcFromString("2023-09-15T09:00:00Z");
    time:Utc afternoon = check time:utcFromString("2023-09-15T15:00:00Z");
    test:assertTrue(isBefore(morning, afternoon), "Morning should be before afternoon");

    // Test with different minutes
    time:Utc minute30 = check time:utcFromString("2023-09-15T12:30:00Z");
    time:Utc minute45 = check time:utcFromString("2023-09-15T12:45:00Z");
    test:assertTrue(isBefore(minute30, minute45), "12:30 should be before 12:45");

    // Test with different seconds
    time:Utc second15 = check time:utcFromString("2023-09-15T12:00:15Z");
    time:Utc second30 = check time:utcFromString("2023-09-15T12:00:30Z");
    test:assertTrue(isBefore(second15, second30), "15 seconds should be before 30 seconds");

    // Test with fractional seconds
    time:Utc fracSecond1 = check time:utcFromString("2023-09-15T12:00:30.250Z");
    time:Utc fracSecond2 = check time:utcFromString("2023-09-15T12:00:30.750Z");
    test:assertTrue(isBefore(fracSecond1, fracSecond2), "30.250 should be before 30.750 seconds");
}

@test:Config {}
function testIsAfter() returns error? {
    // Test basic after comparison
    time:Utc earlierTime = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc laterTime = check time:utcFromString("2023-09-16T12:00:00Z");
    test:assertTrue(isAfter(laterTime, earlierTime), "Later time should be after earlier time");
    test:assertFalse(isAfter(earlierTime, laterTime), "Earlier time should not be after later time");

    // Test with same time
    test:assertFalse(isAfter(earlierTime, earlierTime), "Same time should not be after itself");

    // Test with different years
    time:Utc year2023 = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc year2024 = check time:utcFromString("2024-09-15T12:00:00Z");
    test:assertTrue(isAfter(year2024, year2023), "2024 should be after 2023");

    // Test with different months
    time:Utc september = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc october = check time:utcFromString("2023-10-15T12:00:00Z");
    test:assertTrue(isAfter(october, september), "October should be after September");

    // Test with milliseconds precision
    time:Utc millis500 = check time:utcFromString("2023-09-15T12:00:30.500Z");
    time:Utc millis600 = check time:utcFromString("2023-09-15T12:00:30.600Z");
    test:assertTrue(isAfter(millis600, millis500), "30.600 should be after 30.500 seconds");
}

@test:Config {}
function testIsSame() returns error? {
    // Test identical times
    time:Utc time1 = check time:utcFromString("2023-09-15T12:30:45.500Z");
    time:Utc time2 = check time:utcFromString("2023-09-15T12:30:45.500Z");
    test:assertTrue(isSame(time1, time2), "Identical times should be same");

    // Test different times
    time:Utc differentTime = check time:utcFromString("2023-09-15T12:30:45.501Z");
    test:assertFalse(isSame(time1, differentTime), "Different times should not be same");

    // Test time compared to itself
    test:assertTrue(isSame(time1, time1), "Time should be same as itself");

    // Test with zero milliseconds vs explicit milliseconds
    time:Utc withoutMillis = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc withZeroMillis = check time:utcFromString("2023-09-15T12:00:00.000Z");
    test:assertTrue(isSame(withoutMillis, withZeroMillis), "Time with and without explicit zero milliseconds should be same");
}

@test:Config {}
function testIsBetween() returns error? {
    // Test time between two others
    time:Utc startTime = check time:utcFromString("2023-09-15T10:00:00Z");
    time:Utc middleTime = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc endTime = check time:utcFromString("2023-09-15T14:00:00Z");
    
    test:assertTrue(isBetween(middleTime, startTime, endTime), "Middle time should be between start and end");
    test:assertFalse(isBetween(startTime, middleTime, endTime), "Start time should not be between middle and end");
    test:assertFalse(isBetween(endTime, startTime, middleTime), "End time should not be between start and middle");

    // Test inclusive boundaries
    test:assertTrue(isBetween(startTime, startTime, endTime), "Start time should be between itself and end (inclusive)");
    test:assertTrue(isBetween(endTime, startTime, endTime), "End time should be between start and itself (inclusive)");

    // Test with single day span
    time:Utc morning = check time:utcFromString("2023-09-15T09:00:00Z");
    time:Utc noon = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc evening = check time:utcFromString("2023-09-15T18:00:00Z");
    
    test:assertTrue(isBetween(noon, morning, evening), "Noon should be between morning and evening");
    test:assertFalse(isBetween(morning, noon, evening), "Morning should not be between noon and evening");

    // Test with same start and end time
    test:assertTrue(isBetween(startTime, startTime, startTime), "Time should be between itself");
    test:assertFalse(isBetween(middleTime, startTime, startTime), "Different time should not be between same time");
}

@test:Config {}
function testIsLeapYear() returns error? {
    // Test leap years
    time:Utc year2020 = check time:utcFromString("2020-06-15T12:00:00Z");
    test:assertTrue(isLeapYear(year2020), "2020 should be a leap year");

    time:Utc year2024 = check time:utcFromString("2024-06-15T12:00:00Z");
    test:assertTrue(isLeapYear(year2024), "2024 should be a leap year");

    time:Utc year2000 = check time:utcFromString("2000-06-15T12:00:00Z");
    test:assertTrue(isLeapYear(year2000), "2000 should be a leap year (divisible by 400)");

    // Test non-leap years
    time:Utc year2021 = check time:utcFromString("2021-06-15T12:00:00Z");
    test:assertFalse(isLeapYear(year2021), "2021 should not be a leap year");

    time:Utc year2023 = check time:utcFromString("2023-06-15T12:00:00Z");
    test:assertFalse(isLeapYear(year2023), "2023 should not be a leap year");

    time:Utc year1900 = check time:utcFromString("1900-06-15T12:00:00Z");
    test:assertFalse(isLeapYear(year1900), "1900 should not be a leap year (divisible by 100 but not 400)");

    time:Utc year2100 = check time:utcFromString("2100-06-15T12:00:00Z");
    test:assertFalse(isLeapYear(year2100), "2100 should not be a leap year (divisible by 100 but not 400)");
}

@test:Config {}
function testDaysInMonth() returns error? {
    // Test months with 31 days
    time:Utc january = check time:utcFromString("2023-01-15T12:00:00Z");
    test:assertEquals(daysInMonth(january), 31, "January should have 31 days");

    time:Utc march = check time:utcFromString("2023-03-15T12:00:00Z");
    test:assertEquals(daysInMonth(march), 31, "March should have 31 days");

    time:Utc may = check time:utcFromString("2023-05-15T12:00:00Z");
    test:assertEquals(daysInMonth(may), 31, "May should have 31 days");

    time:Utc july = check time:utcFromString("2023-07-15T12:00:00Z");
    test:assertEquals(daysInMonth(july), 31, "July should have 31 days");

    time:Utc august = check time:utcFromString("2023-08-15T12:00:00Z");
    test:assertEquals(daysInMonth(august), 31, "August should have 31 days");

    time:Utc october = check time:utcFromString("2023-10-15T12:00:00Z");
    test:assertEquals(daysInMonth(october), 31, "October should have 31 days");

    time:Utc december = check time:utcFromString("2023-12-15T12:00:00Z");
    test:assertEquals(daysInMonth(december), 31, "December should have 31 days");

    // Test months with 30 days
    time:Utc april = check time:utcFromString("2023-04-15T12:00:00Z");
    test:assertEquals(daysInMonth(april), 30, "April should have 30 days");

    time:Utc june = check time:utcFromString("2023-06-15T12:00:00Z");
    test:assertEquals(daysInMonth(june), 30, "June should have 30 days");

    time:Utc september = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(daysInMonth(september), 30, "September should have 30 days");

    time:Utc november = check time:utcFromString("2023-11-15T12:00:00Z");
    test:assertEquals(daysInMonth(november), 30, "November should have 30 days");

    // Test February in non-leap year
    time:Utc februaryNonLeap = check time:utcFromString("2023-02-15T12:00:00Z");
    test:assertEquals(daysInMonth(februaryNonLeap), 28, "February in non-leap year should have 28 days");

    // Test February in leap year
    time:Utc februaryLeap = check time:utcFromString("2024-02-15T12:00:00Z");
    test:assertEquals(daysInMonth(februaryLeap), 29, "February in leap year should have 29 days");

    // Test February in century non-leap year
    time:Utc february1900 = check time:utcFromString("1900-02-15T12:00:00Z");
    test:assertEquals(daysInMonth(february1900), 28, "February 1900 should have 28 days");

    // Test February in 400-year leap year
    time:Utc february2000 = check time:utcFromString("2000-02-15T12:00:00Z");
    test:assertEquals(daysInMonth(february2000), 29, "February 2000 should have 29 days");
}

@test:Config {}
function testComparisonConsistency() returns error? {
    // Test that comparison functions are consistent with each other
    time:Utc time1 = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc time2 = check time:utcFromString("2023-09-16T12:00:00Z");

    // If time1 is before time2, then time2 should be after time1
    test:assertTrue(isBefore(time1, time2), "time1 should be before time2");
    test:assertTrue(isAfter(time2, time1), "time2 should be after time1");

    // They should not be the same
    test:assertFalse(isSame(time1, time2), "Different times should not be same");

    // time1 should be between itself and time2
    test:assertTrue(isBetween(time1, time1, time2), "time1 should be between itself and time2");

    // Test transitivity: if A < B and B < C, then A < C
    time:Utc time3 = check time:utcFromString("2023-09-17T12:00:00Z");
    test:assertTrue(isBefore(time1, time2) && isBefore(time2, time3), "Setup for transitivity test");
    test:assertTrue(isBefore(time1, time3), "Transitivity: time1 should be before time3");
}

@test:Config {}
function testEdgeCaseComparisons() returns error? {
    // Test comparison with very close times (millisecond precision)
    time:Utc baseTime = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc oneMilli = check time:utcFromString("2023-09-15T12:00:00.001Z");
    
    test:assertTrue(isBefore(baseTime, oneMilli), "Base time should be before time + 1ms");
    test:assertTrue(isAfter(oneMilli, baseTime), "Time + 1ms should be after base time");
    test:assertFalse(isSame(baseTime, oneMilli), "Times differing by 1ms should not be same");

    // Test with maximum date values (if supported)
    // This tests the boundaries of the time system
    time:Utc minTime = check time:utcFromString("1970-01-01T00:00:00.000Z");
    time:Utc futureTime = check time:utcFromString("2100-12-31T23:59:59.999Z");
    
    test:assertTrue(isBefore(minTime, futureTime), "Min time should be before future time");
    test:assertTrue(isAfter(futureTime, minTime), "Future time should be after min time");
}
