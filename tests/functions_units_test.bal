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
function testStartOfYear() returns error? {
    // Test start of year
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startYear = check startOf(testTime, YEAR);
    time:Utc expectedStart = check time:utcFromString("2023-01-01T00:00:00.000Z");
    test:assertEquals(startYear, expectedStart, "Start of year should be January 1, 00:00:00.000");

    // Test with leap year
    time:Utc leapYearTime = check time:utcFromString("2024-06-15T12:30:45.678Z");
    time:Utc leapYearStart = check startOf(leapYearTime, YEAR);
    time:Utc expectedLeapStart = check time:utcFromString("2024-01-01T00:00:00.000Z");
    test:assertEquals(leapYearStart, expectedLeapStart, "Start of leap year should be January 1, 00:00:00.000");

    // Test edge case: already at start of year
    time:Utc alreadyAtStart = check time:utcFromString("2023-01-01T00:00:00.000Z");
    time:Utc startFromStart = check startOf(alreadyAtStart, YEAR);
    test:assertEquals(startFromStart, alreadyAtStart, "Start of year for time already at start should be identical");
}

@test:Config {}
function testStartOfMonth() returns error? {
    // Test start of month
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startMonth = check startOf(testTime, MONTH);
    time:Utc expectedStart = check time:utcFromString("2023-09-01T00:00:00.000Z");
    test:assertEquals(startMonth, expectedStart, "Start of month should be day 1, 00:00:00.000");

    // Test with February in leap year
    time:Utc febLeapYear = check time:utcFromString("2024-02-29T23:59:59.999Z");
    time:Utc febStart = check startOf(febLeapYear, MONTH);
    time:Utc expectedFebStart = check time:utcFromString("2024-02-01T00:00:00.000Z");
    test:assertEquals(febStart, expectedFebStart, "Start of February in leap year should be Feb 1, 00:00:00.000");

    // Test with December
    time:Utc decTime = check time:utcFromString("2023-12-31T23:59:59.999Z");
    time:Utc decStart = check startOf(decTime, MONTH);
    time:Utc expectedDecStart = check time:utcFromString("2023-12-01T00:00:00.000Z");
    test:assertEquals(decStart, expectedDecStart, "Start of December should be Dec 1, 00:00:00.000");
}

@test:Config {}
function testStartOfDay() returns error? {
    // Test start of day
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startDay = check startOf(testTime, DAY);
    time:Utc expectedStart = check time:utcFromString("2023-09-15T00:00:00.000Z");
    test:assertEquals(startDay, expectedStart, "Start of day should be 00:00:00.000");

    // Test with end of day
    time:Utc endOfDay = check time:utcFromString("2023-09-15T23:59:59.999Z");
    time:Utc startFromEnd = check startOf(endOfDay, DAY);
    test:assertEquals(startFromEnd, expectedStart, "Start of day from end of day should be 00:00:00.000");

    // Test edge case: already at start of day
    time:Utc alreadyAtStart = check time:utcFromString("2023-09-15T00:00:00.000Z");
    time:Utc startFromStart = check startOf(alreadyAtStart, DAY);
    test:assertEquals(startFromStart, alreadyAtStart, "Start of day for time already at start should be identical");
}

@test:Config {}
function testStartOfHour() returns error? {
    // Test start of hour
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startHour = check startOf(testTime, HOUR);
    time:Utc expectedStart = check time:utcFromString("2023-09-15T14:00:00.000Z");
    test:assertEquals(startHour, expectedStart, "Start of hour should be :00:00.000");

    // Test with different hour
    time:Utc midnightTime = check time:utcFromString("2023-09-15T00:45:30.500Z");
    time:Utc midnightStart = check startOf(midnightTime, HOUR);
    time:Utc expectedMidnightStart = check time:utcFromString("2023-09-15T00:00:00.000Z");
    test:assertEquals(midnightStart, expectedMidnightStart, "Start of midnight hour should be 00:00:00.000");

    // Test with 23rd hour
    time:Utc lateHour = check time:utcFromString("2023-09-15T23:45:30.500Z");
    time:Utc lateStart = check startOf(lateHour, HOUR);
    time:Utc expectedLateStart = check time:utcFromString("2023-09-15T23:00:00.000Z");
    test:assertEquals(lateStart, expectedLateStart, "Start of 23rd hour should be 23:00:00.000");
}

@test:Config {}
function testStartOfMinute() returns error? {
    // Test start of minute
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startMinute = check startOf(testTime, MINUTE);
    time:Utc expectedStart = check time:utcFromString("2023-09-15T14:30:00.000Z");
    test:assertEquals(startMinute, expectedStart, "Start of minute should be :00.000");

    // Test with 59th minute
    time:Utc lateMinute = check time:utcFromString("2023-09-15T14:59:45.678Z");
    time:Utc lateStart = check startOf(lateMinute, MINUTE);
    time:Utc expectedLateStart = check time:utcFromString("2023-09-15T14:59:00.000Z");
    test:assertEquals(lateStart, expectedLateStart, "Start of 59th minute should be 59:00.000");

    // Test edge case: already at start of minute
    time:Utc alreadyAtStart = check time:utcFromString("2023-09-15T14:30:00.000Z");
    time:Utc startFromStart = check startOf(alreadyAtStart, MINUTE);
    test:assertEquals(startFromStart, alreadyAtStart, "Start of minute for time already at start should be identical");
}

@test:Config {}
function testStartOfSecond() returns error? {
    // Test start of second (removes fractional part)
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc startSecond = check startOf(testTime, SECOND);
    time:Utc expectedStart = check time:utcFromString("2023-09-15T14:30:25.000Z");
    test:assertEquals(startSecond, expectedStart, "Start of second should remove fractional part");

    // Test with large fractional part
    time:Utc largeFraction = check time:utcFromString("2023-09-15T14:30:25.999Z");
    time:Utc largeFractionStart = check startOf(largeFraction, SECOND);
    test:assertEquals(largeFractionStart, expectedStart, "Start of second should truncate large fractional part");

    // Test edge case: already at start of second
    time:Utc alreadyAtStart = check time:utcFromString("2023-09-15T14:30:25.000Z");
    time:Utc startFromStart = check startOf(alreadyAtStart, SECOND);
    test:assertEquals(startFromStart, alreadyAtStart, "Start of second for time already at start should be identical");
}

@test:Config {}
function testEndOfYear() returns error? {
    // Test end of year
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endYear = check endOf(testTime, YEAR);
    time:Utc expectedEnd = check time:utcFromString("2023-12-31T23:59:59.999Z");
    test:assertEquals(endYear, expectedEnd, "End of year should be December 31, 23:59:59.999");

    // Test with leap year
    time:Utc leapYearTime = check time:utcFromString("2024-06-15T12:30:45.678Z");
    time:Utc leapYearEnd = check endOf(leapYearTime, YEAR);
    time:Utc expectedLeapEnd = check time:utcFromString("2024-12-31T23:59:59.999Z");
    test:assertEquals(leapYearEnd, expectedLeapEnd, "End of leap year should be December 31, 23:59:59.999");

    // Test edge case: already at end of year
    time:Utc alreadyAtEnd = check time:utcFromString("2023-12-31T23:59:59.999Z");
    time:Utc endFromEnd = check endOf(alreadyAtEnd, YEAR);
    test:assertEquals(endFromEnd, alreadyAtEnd, "End of year for time already at end should be identical");
}

@test:Config {}
function testEndOfMonth() returns error? {
    // Test end of September (30 days)
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endMonth = check endOf(testTime, MONTH);
    time:Utc expectedEnd = check time:utcFromString("2023-09-30T23:59:59.999Z");
    test:assertEquals(endMonth, expectedEnd, "End of September should be Sep 30, 23:59:59.999");

    // Test end of January (31 days)
    time:Utc janTime = check time:utcFromString("2023-01-15T12:00:00.000Z");
    time:Utc janEnd = check endOf(janTime, MONTH);
    time:Utc expectedJanEnd = check time:utcFromString("2023-01-31T23:59:59.999Z");
    test:assertEquals(janEnd, expectedJanEnd, "End of January should be Jan 31, 23:59:59.999");

    // Test end of February in non-leap year (28 days)
    time:Utc febTime = check time:utcFromString("2023-02-15T12:00:00.000Z");
    time:Utc febEnd = check endOf(febTime, MONTH);
    time:Utc expectedFebEnd = check time:utcFromString("2023-02-28T23:59:59.999Z");
    test:assertEquals(febEnd, expectedFebEnd, "End of February (non-leap) should be Feb 28, 23:59:59.999");

    // Test end of February in leap year (29 days)
    time:Utc febLeapTime = check time:utcFromString("2024-02-15T12:00:00.000Z");
    time:Utc febLeapEnd = check endOf(febLeapTime, MONTH);
    time:Utc expectedFebLeapEnd = check time:utcFromString("2024-02-29T23:59:59.999Z");
    test:assertEquals(febLeapEnd, expectedFebLeapEnd, "End of February (leap) should be Feb 29, 23:59:59.999");
}

@test:Config {}
function testEndOfDay() returns error? {
    // Test end of day
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endDay = check endOf(testTime, DAY);
    time:Utc expectedEnd = check time:utcFromString("2023-09-15T23:59:59.999Z");
    test:assertEquals(endDay, expectedEnd, "End of day should be 23:59:59.999");

    // Test with start of day
    time:Utc startOfDay = check time:utcFromString("2023-09-15T00:00:00.000Z");
    time:Utc endFromStart = check endOf(startOfDay, DAY);
    test:assertEquals(endFromStart, expectedEnd, "End of day from start of day should be 23:59:59.999");

    // Test edge case: already at end of day
    time:Utc alreadyAtEnd = check time:utcFromString("2023-09-15T23:59:59.999Z");
    time:Utc endFromEnd = check endOf(alreadyAtEnd, DAY);
    test:assertEquals(endFromEnd, alreadyAtEnd, "End of day for time already at end should be identical");
}

@test:Config {}
function testEndOfHour() returns error? {
    // Test end of hour
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endHour = check endOf(testTime, HOUR);
    time:Utc expectedEnd = check time:utcFromString("2023-09-15T14:59:59.999Z");
    test:assertEquals(endHour, expectedEnd, "End of hour should be :59:59.999");

    // Test with midnight hour
    time:Utc midnightTime = check time:utcFromString("2023-09-15T00:15:30.500Z");
    time:Utc midnightEnd = check endOf(midnightTime, HOUR);
    time:Utc expectedMidnightEnd = check time:utcFromString("2023-09-15T00:59:59.999Z");
    test:assertEquals(midnightEnd, expectedMidnightEnd, "End of midnight hour should be 00:59:59.999");

    // Test with 23rd hour
    time:Utc lateHour = check time:utcFromString("2023-09-15T23:15:30.500Z");
    time:Utc lateEnd = check endOf(lateHour, HOUR);
    time:Utc expectedLateEnd = check time:utcFromString("2023-09-15T23:59:59.999Z");
    test:assertEquals(lateEnd, expectedLateEnd, "End of 23rd hour should be 23:59:59.999");
}

@test:Config {}
function testEndOfMinute() returns error? {
    // Test end of minute
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endMinute = check endOf(testTime, MINUTE);
    time:Utc expectedEnd = check time:utcFromString("2023-09-15T14:30:59.999Z");
    test:assertEquals(endMinute, expectedEnd, "End of minute should be :59.999");

    // Test with 59th minute
    time:Utc lateMinute = check time:utcFromString("2023-09-15T14:59:25.123Z");
    time:Utc lateEnd = check endOf(lateMinute, MINUTE);
    time:Utc expectedLateEnd = check time:utcFromString("2023-09-15T14:59:59.999Z");
    test:assertEquals(lateEnd, expectedLateEnd, "End of 59th minute should be 59:59.999");

    // Test edge case: already at end of minute
    time:Utc alreadyAtEnd = check time:utcFromString("2023-09-15T14:30:59.999Z");
    time:Utc endFromEnd = check endOf(alreadyAtEnd, MINUTE);
    test:assertEquals(endFromEnd, alreadyAtEnd, "End of minute for time already at end should be identical");
}

@test:Config {}
function testEndOfSecond() returns error? {
    // Test end of second (adds .999 fractional part)
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc endSecond = check endOf(testTime, SECOND);
    time:Utc expectedEnd = check time:utcFromString("2023-09-15T14:30:25.999Z");
    test:assertEquals(endSecond, expectedEnd, "End of second should add .999 fractional part");

    // Test with no fractional part
    time:Utc wholeSecond = check time:utcFromString("2023-09-15T14:30:25.000Z");
    time:Utc wholeSecondEnd = check endOf(wholeSecond, SECOND);
    test:assertEquals(wholeSecondEnd, expectedEnd, "End of whole second should add .999 fractional part");

    // Test edge case: already at end of second
    time:Utc alreadyAtEnd = check time:utcFromString("2023-09-15T14:30:25.999Z");
    time:Utc endFromEnd = check endOf(alreadyAtEnd, SECOND);
    test:assertEquals(endFromEnd, alreadyAtEnd, "End of second for time already at end should be identical");
}

@test:Config {}
function testAllUnitEnumValuesInStartOf() returns error? {
    // Test that ALL Unit enum values work with startOf function
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");

    // Test YEAR enum value
    time:Utc yearStart = check startOf(testTime, YEAR);
    test:assertTrue(getYear(yearStart) == 2023, "YEAR enum should work with startOf");
    test:assertTrue(getMonth(yearStart) == 1, "Start of year should be January");
    test:assertTrue(getDay(yearStart) == 1, "Start of year should be day 1");

    // Test MONTH enum value
    time:Utc monthStart = check startOf(testTime, MONTH);
    test:assertTrue(getYear(monthStart) == 2023, "MONTH enum should preserve year");
    test:assertTrue(getMonth(monthStart) == 9, "MONTH enum should work with startOf");
    test:assertTrue(getDay(monthStart) == 1, "Start of month should be day 1");

    // Test DAY enum value
    time:Utc dayStart = check startOf(testTime, DAY);
    test:assertTrue(getDay(dayStart) == 15, "DAY enum should work with startOf");
    test:assertTrue(getHour(dayStart) == 0, "Start of day should be hour 0");

    // Test HOUR enum value
    time:Utc hourStart = check startOf(testTime, HOUR);
    test:assertTrue(getHour(hourStart) == 14, "HOUR enum should work with startOf");
    test:assertTrue(getMinute(hourStart) == 0, "Start of hour should be minute 0");

    // Test MINUTE enum value
    time:Utc minuteStart = check startOf(testTime, MINUTE);
    test:assertTrue(getMinute(minuteStart) == 30, "MINUTE enum should work with startOf");
    test:assertTrue(getSecond(minuteStart) == 0.0d, "Start of minute should be second 0");

    // Test SECOND enum value
    time:Utc secondStart = check startOf(testTime, SECOND);
    test:assertTrue(getSecond(secondStart) == 25.0d, "SECOND enum should work with startOf");

    test:assertTrue(true, "All Unit enum values work correctly with startOf");
}

@test:Config {}
function testAllUnitEnumValuesInEndOf() returns error? {
    // Test that ALL Unit enum values work with endOf function
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");

    // Test YEAR enum value
    time:Utc yearEnd = check endOf(testTime, YEAR);
    test:assertTrue(getYear(yearEnd) == 2023, "YEAR enum should work with endOf");
    test:assertTrue(getMonth(yearEnd) == 12, "End of year should be December");
    test:assertTrue(getDay(yearEnd) == 31, "End of year should be day 31");

    // Test MONTH enum value
    time:Utc monthEnd = check endOf(testTime, MONTH);
    test:assertTrue(getYear(monthEnd) == 2023, "MONTH enum should preserve year");
    test:assertTrue(getMonth(monthEnd) == 9, "MONTH enum should work with endOf");
    test:assertTrue(getDay(monthEnd) == 30, "End of September should be day 30");

    // Test DAY enum value
    time:Utc dayEnd = check endOf(testTime, DAY);
    test:assertTrue(getDay(dayEnd) == 15, "DAY enum should work with endOf");
    test:assertTrue(getHour(dayEnd) == 23, "End of day should be hour 23");

    // Test HOUR enum value
    time:Utc hourEnd = check endOf(testTime, HOUR);
    test:assertTrue(getHour(hourEnd) == 14, "HOUR enum should work with endOf");
    test:assertTrue(getMinute(hourEnd) == 59, "End of hour should be minute 59");

    // Test MINUTE enum value
    time:Utc minuteEnd = check endOf(testTime, MINUTE);
    test:assertTrue(getMinute(minuteEnd) == 30, "MINUTE enum should work with endOf");
    test:assertTrue(getSecond(minuteEnd) == 59.999d, "End of minute should be second 59.999");

    // Test SECOND enum value
    time:Utc secondEnd = check endOf(testTime, SECOND);
    test:assertTrue(getSecond(secondEnd) == 25.999d, "SECOND enum should work with endOf");

    test:assertTrue(true, "All Unit enum values work correctly with endOf");
}

@test:Config {}
function testStartOfEndOfConsistency() returns error? {
    // Test that startOf and endOf are consistent with each other
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");

    // Test year consistency
    time:Utc yearStart = check startOf(testTime, YEAR);
    time:Utc yearEnd = check endOf(testTime, YEAR);
    test:assertTrue(getYear(yearStart) == getYear(yearEnd), "Start and end of year should be in same year");

    // Test month consistency
    time:Utc monthStart = check startOf(testTime, MONTH);
    time:Utc monthEnd = check endOf(testTime, MONTH);
    test:assertTrue(getMonth(monthStart) == getMonth(monthEnd), "Start and end of month should be in same month");

    // Test day consistency
    time:Utc dayStart = check startOf(testTime, DAY);
    time:Utc dayEnd = check endOf(testTime, DAY);
    test:assertTrue(getDay(dayStart) == getDay(dayEnd), "Start and end of day should be on same day");

    // Test hour consistency
    time:Utc hourStart = check startOf(testTime, HOUR);
    time:Utc hourEnd = check endOf(testTime, HOUR);
    test:assertTrue(getHour(hourStart) == getHour(hourEnd), "Start and end of hour should be in same hour");

    // Test minute consistency
    time:Utc minuteStart = check startOf(testTime, MINUTE);
    time:Utc minuteEnd = check endOf(testTime, MINUTE);
    test:assertTrue(getMinute(minuteStart) == getMinute(minuteEnd), "Start and end of minute should be in same minute");

    test:assertTrue(true, "StartOf and endOf functions are consistent");
}

@test:Config {}
function testLeapYearHandling() returns error? {
    // Test leap year handling in month operations

    // Test February in leap year
    time:Utc feb2024 = check time:utcFromString("2024-02-15T12:00:00.000Z");
    time:Utc feb2024End = check endOf(feb2024, MONTH);
    test:assertTrue(getDay(feb2024End) == 29, "End of February in leap year should be day 29");

    // Test February in non-leap year
    time:Utc feb2023 = check time:utcFromString("2023-02-15T12:00:00.000Z");
    time:Utc feb2023End = check endOf(feb2023, MONTH);
    test:assertTrue(getDay(feb2023End) == 28, "End of February in non-leap year should be day 28");

    // Test century non-leap year
    time:Utc feb1900 = check time:utcFromString("1900-02-15T12:00:00.000Z");
    time:Utc feb1900End = check endOf(feb1900, MONTH);
    test:assertTrue(getDay(feb1900End) == 28, "End of February in century non-leap year should be day 28");

    // Test 400-year leap year
    time:Utc feb2000 = check time:utcFromString("2000-02-15T12:00:00.000Z");
    time:Utc feb2000End = check endOf(feb2000, MONTH);
    test:assertTrue(getDay(feb2000End) == 29, "End of February in 400-year leap year should be day 29");
}
