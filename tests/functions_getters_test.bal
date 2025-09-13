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
function testGetYear() returns error? {
    // Test various years
    time:Utc time2023 = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(getYear(time2023), 2023, "Year 2023 should be correct");

    time:Utc time2024 = check time:utcFromString("2024-02-29T12:00:00Z"); // Leap year
    test:assertEquals(getYear(time2024), 2024, "Year 2024 should be correct");

    time:Utc time2000 = check time:utcFromString("2000-01-01T00:00:00Z");
    test:assertEquals(getYear(time2000), 2000, "Year 2000 should be correct");

    // Test edge case - year transition
    time:Utc newYear = check time:utcFromString("2023-12-31T23:59:59Z");
    test:assertEquals(getYear(newYear), 2023, "Year should be 2023 on New Year's Eve");

    time:Utc newYearStart = check time:utcFromString("2024-01-01T00:00:00Z");
    test:assertEquals(getYear(newYearStart), 2024, "Year should be 2024 on New Year's Day");
}

@test:Config {}
function testGetMonth() returns error? {
    // Test all months
    time:Utc january = check time:utcFromString("2023-01-15T12:00:00Z");
    test:assertEquals(getMonth(january), 1, "January should be month 1");

    time:Utc february = check time:utcFromString("2023-02-15T12:00:00Z");
    test:assertEquals(getMonth(february), 2, "February should be month 2");

    time:Utc march = check time:utcFromString("2023-03-15T12:00:00Z");
    test:assertEquals(getMonth(march), 3, "March should be month 3");

    time:Utc april = check time:utcFromString("2023-04-15T12:00:00Z");
    test:assertEquals(getMonth(april), 4, "April should be month 4");

    time:Utc may = check time:utcFromString("2023-05-15T12:00:00Z");
    test:assertEquals(getMonth(may), 5, "May should be month 5");

    time:Utc june = check time:utcFromString("2023-06-15T12:00:00Z");
    test:assertEquals(getMonth(june), 6, "June should be month 6");

    time:Utc july = check time:utcFromString("2023-07-15T12:00:00Z");
    test:assertEquals(getMonth(july), 7, "July should be month 7");

    time:Utc august = check time:utcFromString("2023-08-15T12:00:00Z");
    test:assertEquals(getMonth(august), 8, "August should be month 8");

    time:Utc september = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(getMonth(september), 9, "September should be month 9");

    time:Utc october = check time:utcFromString("2023-10-15T12:00:00Z");
    test:assertEquals(getMonth(october), 10, "October should be month 10");

    time:Utc november = check time:utcFromString("2023-11-15T12:00:00Z");
    test:assertEquals(getMonth(november), 11, "November should be month 11");

    time:Utc december = check time:utcFromString("2023-12-15T12:00:00Z");
    test:assertEquals(getMonth(december), 12, "December should be month 12");
}

@test:Config {}
function testGetDay() returns error? {
    // Test various days of the month
    time:Utc day1 = check time:utcFromString("2023-09-01T12:00:00Z");
    test:assertEquals(getDay(day1), 1, "Day 1 should be correct");

    time:Utc day15 = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(getDay(day15), 15, "Day 15 should be correct");

    time:Utc day31 = check time:utcFromString("2023-01-31T12:00:00Z");
    test:assertEquals(getDay(day31), 31, "Day 31 should be correct");

    // Test February edge cases
    time:Utc feb28 = check time:utcFromString("2023-02-28T12:00:00Z"); // Non-leap year
    test:assertEquals(getDay(feb28), 28, "February 28 in non-leap year should be correct");

    time:Utc feb29 = check time:utcFromString("2024-02-29T12:00:00Z"); // Leap year
    test:assertEquals(getDay(feb29), 29, "February 29 in leap year should be correct");
}

@test:Config {}
function testGetHour() returns error? {
    // Test various hours (0-23)
    time:Utc midnight = check time:utcFromString("2023-09-15T00:00:00Z");
    test:assertEquals(getHour(midnight), 0, "Midnight should be hour 0");

    time:Utc morning = check time:utcFromString("2023-09-15T09:30:25Z");
    test:assertEquals(getHour(morning), 9, "9 AM should be hour 9");

    time:Utc noon = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(getHour(noon), 12, "Noon should be hour 12");

    time:Utc afternoon = check time:utcFromString("2023-09-15T15:45:30Z");
    test:assertEquals(getHour(afternoon), 15, "3 PM should be hour 15");

    time:Utc evening = check time:utcFromString("2023-09-15T20:30:45Z");
    test:assertEquals(getHour(evening), 20, "8 PM should be hour 20");

    time:Utc lateNight = check time:utcFromString("2023-09-15T23:59:59Z");
    test:assertEquals(getHour(lateNight), 23, "11:59 PM should be hour 23");
}

@test:Config {}
function testGetMinute() returns error? {
    // Test various minutes (0-59)
    time:Utc minute0 = check time:utcFromString("2023-09-15T14:00:25Z");
    test:assertEquals(getMinute(minute0), 0, "Minute 0 should be correct");

    time:Utc minute15 = check time:utcFromString("2023-09-15T14:15:25Z");
    test:assertEquals(getMinute(minute15), 15, "Minute 15 should be correct");

    time:Utc minute30 = check time:utcFromString("2023-09-15T14:30:25Z");
    test:assertEquals(getMinute(minute30), 30, "Minute 30 should be correct");

    time:Utc minute45 = check time:utcFromString("2023-09-15T14:45:25Z");
    test:assertEquals(getMinute(minute45), 45, "Minute 45 should be correct");

    time:Utc minute59 = check time:utcFromString("2023-09-15T14:59:25Z");
    test:assertEquals(getMinute(minute59), 59, "Minute 59 should be correct");
}

@test:Config {}
function testGetSecond() returns error? {
    // Test various seconds with decimal precision
    time:Utc second0 = check time:utcFromString("2023-09-15T14:30:00.000Z");
    test:assertEquals(getSecond(second0), 0.0d, "Second 0.000 should be correct");

    time:Utc second15 = check time:utcFromString("2023-09-15T14:30:15.000Z");
    test:assertEquals(getSecond(second15), 15.0d, "Second 15.000 should be correct");

    time:Utc second30_5 = check time:utcFromString("2023-09-15T14:30:30.500Z");
    test:assertEquals(getSecond(second30_5), 30.5d, "Second 30.500 should be correct");

    time:Utc second59_999 = check time:utcFromString("2023-09-15T14:30:59.999Z");
    test:assertEquals(getSecond(second59_999), 59.999d, "Second 59.999 should be correct");

    time:Utc secondFraction = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(getSecond(secondFraction), 25.123d, "Second 25.123 should be correct");
}

@test:Config {}
function testGetDayOfWeek() returns error? {
    // Test all days of the week using known dates
    // September 2023: 16=Saturday, 17=Sunday, 18=Monday, etc.

    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z");
    test:assertEquals(getDayOfWeek(saturday), 0, "Saturday should be day 0");

    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z");
    test:assertEquals(getDayOfWeek(sunday), 1, "Sunday should be day 1");

    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertEquals(getDayOfWeek(monday), 2, "Monday should be day 2");

    time:Utc tuesday = check time:utcFromString("2023-09-19T12:00:00Z");
    test:assertEquals(getDayOfWeek(tuesday), 3, "Tuesday should be day 3");

    time:Utc wednesday = check time:utcFromString("2023-09-20T12:00:00Z");
    test:assertEquals(getDayOfWeek(wednesday), 4, "Wednesday should be day 4");

    time:Utc thursday = check time:utcFromString("2023-09-21T12:00:00Z");
    test:assertEquals(getDayOfWeek(thursday), 5, "Thursday should be day 5");

    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(getDayOfWeek(friday), 6, "Friday should be day 6");
}

@test:Config {}
function testGetDayOfWeekName() returns error? {
    // Test day names with EN locale
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z");
    test:assertEquals(getDayOfWeekName(saturday, EN), "Saturday", "Saturday name should be correct");

    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z");
    test:assertEquals(getDayOfWeekName(sunday, EN), "Sunday", "Sunday name should be correct");

    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertEquals(getDayOfWeekName(monday, EN), "Monday", "Monday name should be correct");

    time:Utc tuesday = check time:utcFromString("2023-09-19T12:00:00Z");
    test:assertEquals(getDayOfWeekName(tuesday, EN), "Tuesday", "Tuesday name should be correct");

    time:Utc wednesday = check time:utcFromString("2023-09-20T12:00:00Z");
    test:assertEquals(getDayOfWeekName(wednesday, EN), "Wednesday", "Wednesday name should be correct");

    time:Utc thursday = check time:utcFromString("2023-09-21T12:00:00Z");
    test:assertEquals(getDayOfWeekName(thursday, EN), "Thursday", "Thursday name should be correct");

    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(getDayOfWeekName(friday, EN), "Friday", "Friday name should be correct");

    // Test with default locale (should be same as EN)
    test:assertEquals(getDayOfWeekName(friday), "Friday", "Default locale should work like EN");
}

@test:Config {}
function testGetDayOfWeekNameAllLocales() returns error? {
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");

    // Test all locale variants
    test:assertEquals(getDayOfWeekName(friday, EN), "Friday", "EN locale should work");
    test:assertEquals(getDayOfWeekName(friday, EN_US), "Friday", "EN_US locale should work");
    test:assertEquals(getDayOfWeekName(friday, EN_GB), "Friday", "EN_GB locale should work");
    test:assertEquals(getDayOfWeekName(friday, EN_CA), "Friday", "EN_CA locale should work");
    test:assertEquals(getDayOfWeekName(friday, EN_AU), "Friday", "EN_AU locale should work");
    test:assertEquals(getDayOfWeekName(friday, EN_NZ), "Friday", "EN_NZ locale should work");
}

@test:Config {}
function testGetDayOfYear() returns error? {
    // Test day 1 of year
    time:Utc jan1 = check time:utcFromString("2023-01-01T12:00:00Z");
    test:assertEquals(getDayOfYear(jan1), 1, "January 1 should be day 1 of year");

    // Test end of January
    time:Utc jan31 = check time:utcFromString("2023-01-31T12:00:00Z");
    test:assertEquals(getDayOfYear(jan31), 31, "January 31 should be day 31 of year");

    // Test start of February
    time:Utc feb1 = check time:utcFromString("2023-02-01T12:00:00Z");
    test:assertEquals(getDayOfYear(feb1), 32, "February 1 should be day 32 of year");

    // Test end of February (non-leap year)
    time:Utc feb28 = check time:utcFromString("2023-02-28T12:00:00Z");
    test:assertEquals(getDayOfYear(feb28), 59, "February 28 (non-leap) should be day 59 of year");

    // Test March 1 (non-leap year)
    time:Utc mar1 = check time:utcFromString("2023-03-01T12:00:00Z");
    test:assertEquals(getDayOfYear(mar1), 60, "March 1 (non-leap) should be day 60 of year");

    // Test leap year February 29
    time:Utc feb29Leap = check time:utcFromString("2024-02-29T12:00:00Z");
    test:assertEquals(getDayOfYear(feb29Leap), 60, "February 29 (leap) should be day 60 of year");

    // Test March 1 in leap year
    time:Utc mar1Leap = check time:utcFromString("2024-03-01T12:00:00Z");
    test:assertEquals(getDayOfYear(mar1Leap), 61, "March 1 (leap) should be day 61 of year");

    // Test end of year
    time:Utc dec31 = check time:utcFromString("2023-12-31T12:00:00Z");
    test:assertEquals(getDayOfYear(dec31), 365, "December 31 (non-leap) should be day 365 of year");

    time:Utc dec31Leap = check time:utcFromString("2024-12-31T12:00:00Z");
    test:assertEquals(getDayOfYear(dec31Leap), 366, "December 31 (leap) should be day 366 of year");
}

@test:Config {}
function testGetWeekOfYear() returns error? {
    // Test first week of year
    time:Utc jan1 = check time:utcFromString("2023-01-01T12:00:00Z");
    test:assertEquals(getWeekOfYear(jan1), 1, "January 1 should be in week 1");

    time:Utc jan7 = check time:utcFromString("2023-01-07T12:00:00Z");
    test:assertEquals(getWeekOfYear(jan7), 1, "January 7 should be in week 1");

    // Test second week
    time:Utc jan8 = check time:utcFromString("2023-01-08T12:00:00Z");
    test:assertEquals(getWeekOfYear(jan8), 2, "January 8 should be in week 2");

    time:Utc jan14 = check time:utcFromString("2023-01-14T12:00:00Z");
    test:assertEquals(getWeekOfYear(jan14), 2, "January 14 should be in week 2");

    // Test mid-year
    time:Utc jul1 = check time:utcFromString("2023-07-01T12:00:00Z");
    int expectedWeek = (getDayOfYear(jul1) - 1) / 7 + 1;
    test:assertEquals(getWeekOfYear(jul1), expectedWeek, "July 1 week calculation should be correct");

    // Test end of year
    time:Utc dec31 = check time:utcFromString("2023-12-31T12:00:00Z");
    int expectedLastWeek = (getDayOfYear(dec31) - 1) / 7 + 1;
    test:assertEquals(getWeekOfYear(dec31), expectedLastWeek, "December 31 week calculation should be correct");
}

@test:Config {}
function testGetUnitNameSingular() returns error? {
    // Test all Unit enum values in singular form
    test:assertEquals(getUnitName(YEAR, EN, true), "year", "YEAR singular should be 'year'");
    test:assertEquals(getUnitName(MONTH, EN, true), "month", "MONTH singular should be 'month'");
    test:assertEquals(getUnitName(DAY, EN, true), "day", "DAY singular should be 'day'");
    test:assertEquals(getUnitName(HOUR, EN, true), "hour", "HOUR singular should be 'hour'");
    test:assertEquals(getUnitName(MINUTE, EN, true), "minute", "MINUTE singular should be 'minute'");
    test:assertEquals(getUnitName(SECOND, EN, true), "second", "SECOND singular should be 'second'");

    // Test with default parameters (should be singular EN)
    test:assertEquals(getUnitName(YEAR), "year", "Default parameters should give singular EN");
    test:assertEquals(getUnitName(MONTH), "month", "Default parameters should give singular EN");
}

@test:Config {}
function testGetUnitNamePlural() returns error? {
    // Test all Unit enum values in plural form
    test:assertEquals(getUnitName(YEAR, EN, false), "years", "YEAR plural should be 'years'");
    test:assertEquals(getUnitName(MONTH, EN, false), "months", "MONTH plural should be 'months'");
    test:assertEquals(getUnitName(DAY, EN, false), "days", "DAY plural should be 'days'");
    test:assertEquals(getUnitName(HOUR, EN, false), "hours", "HOUR plural should be 'hours'");
    test:assertEquals(getUnitName(MINUTE, EN, false), "minutes", "MINUTE plural should be 'minutes'");
    test:assertEquals(getUnitName(SECOND, EN, false), "seconds", "SECOND plural should be 'seconds'");
}

@test:Config {}
function testGetUnitNameAllLocales() returns error? {
    // Test all locale variants with unit names
    test:assertEquals(getUnitName(YEAR, EN, true), "year", "EN locale should work");
    test:assertEquals(getUnitName(YEAR, EN_US, true), "year", "EN_US locale should work");
    test:assertEquals(getUnitName(YEAR, EN_GB, true), "year", "EN_GB locale should work");
    test:assertEquals(getUnitName(YEAR, EN_CA, true), "year", "EN_CA locale should work");
    test:assertEquals(getUnitName(YEAR, EN_AU, true), "year", "EN_AU locale should work");
    test:assertEquals(getUnitName(YEAR, EN_NZ, true), "year", "EN_NZ locale should work");

    // Test plural forms with all locales
    test:assertEquals(getUnitName(DAY, EN, false), "days", "EN plural should work");
    test:assertEquals(getUnitName(DAY, EN_US, false), "days", "EN_US plural should work");
    test:assertEquals(getUnitName(DAY, EN_GB, false), "days", "EN_GB plural should work");
}

@test:Config {}
function testLeapYearCalculations() returns error? {
    // Test leap year detection in getDayOfYear

    // Test regular leap year (divisible by 4, not by 100)
    time:Utc leap2024 = check time:utcFromString("2024-03-01T12:00:00Z"); // March 1 in leap year
    test:assertEquals(getDayOfYear(leap2024), 61, "March 1 in leap year 2024 should be day 61");

    // Test century non-leap year (divisible by 100, not by 400)
    time:Utc nonLeap1900 = check time:utcFromString("1900-03-01T12:00:00Z"); // March 1 in non-leap year
    test:assertEquals(getDayOfYear(nonLeap1900), 60, "March 1 in non-leap year 1900 should be day 60");

    // Test 400-year leap year (divisible by 400)
    time:Utc leap2000 = check time:utcFromString("2000-03-01T12:00:00Z"); // March 1 in leap year
    test:assertEquals(getDayOfYear(leap2000), 61, "March 1 in leap year 2000 should be day 61");

    // Test regular non-leap year
    time:Utc nonLeap2023 = check time:utcFromString("2023-03-01T12:00:00Z"); // March 1 in non-leap year
    test:assertEquals(getDayOfYear(nonLeap2023), 60, "March 1 in non-leap year 2023 should be day 60");
}

@test:Config {}
function testEdgeCasesAndBoundaries() returns error? {
    // Test time at exact boundaries
    time:Utc startOfDay = check time:utcFromString("2023-09-15T00:00:00.000Z");
    test:assertEquals(getHour(startOfDay), 0, "Start of day should be hour 0");
    test:assertEquals(getMinute(startOfDay), 0, "Start of day should be minute 0");
    test:assertEquals(getSecond(startOfDay), 0.0d, "Start of day should be second 0.0");

    time:Utc endOfDay = check time:utcFromString("2023-09-15T23:59:59.999Z");
    test:assertEquals(getHour(endOfDay), 23, "End of day should be hour 23");
    test:assertEquals(getMinute(endOfDay), 59, "End of day should be minute 59");
    test:assertEquals(getSecond(endOfDay), 59.999d, "End of day should be second 59.999");

    // Test year boundaries
    time:Utc endOfYear = check time:utcFromString("2023-12-31T23:59:59Z");
    test:assertEquals(getYear(endOfYear), 2023, "End of year should still be 2023");
    test:assertEquals(getMonth(endOfYear), 12, "End of year should be month 12");
    test:assertEquals(getDay(endOfYear), 31, "End of year should be day 31");

    time:Utc startOfNewYear = check time:utcFromString("2024-01-01T00:00:00Z");
    test:assertEquals(getYear(startOfNewYear), 2024, "Start of new year should be 2024");
    test:assertEquals(getMonth(startOfNewYear), 1, "Start of new year should be month 1");
    test:assertEquals(getDay(startOfNewYear), 1, "Start of new year should be day 1");
}

@test:Config {}
function testAllUnitEnumValues() returns error? {
    // Comprehensive test to ensure ALL Unit enum values are used and tested
    // This test validates that every Unit enum value works in both singular and plural forms

    // Test YEAR enum value
    test:assertEquals(getUnitName(YEAR, EN, true), "year", "YEAR enum should work in singular");
    test:assertEquals(getUnitName(YEAR, EN, false), "years", "YEAR enum should work in plural");

    // Test MONTH enum value
    test:assertEquals(getUnitName(MONTH, EN, true), "month", "MONTH enum should work in singular");
    test:assertEquals(getUnitName(MONTH, EN, false), "months", "MONTH enum should work in plural");

    // Test DAY enum value
    test:assertEquals(getUnitName(DAY, EN, true), "day", "DAY enum should work in singular");
    test:assertEquals(getUnitName(DAY, EN, false), "days", "DAY enum should work in plural");

    // Test HOUR enum value
    test:assertEquals(getUnitName(HOUR, EN, true), "hour", "HOUR enum should work in singular");
    test:assertEquals(getUnitName(HOUR, EN, false), "hours", "HOUR enum should work in plural");

    // Test MINUTE enum value
    test:assertEquals(getUnitName(MINUTE, EN, true), "minute", "MINUTE enum should work in singular");
    test:assertEquals(getUnitName(MINUTE, EN, false), "minutes", "MINUTE enum should work in plural");

    // Test SECOND enum value
    test:assertEquals(getUnitName(SECOND, EN, true), "second", "SECOND enum should work in singular");
    test:assertEquals(getUnitName(SECOND, EN, false), "seconds", "SECOND enum should work in plural");

    test:assertTrue(true, "All Unit enum values have been tested successfully");
}
