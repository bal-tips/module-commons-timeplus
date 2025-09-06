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
function testIsWeekend() returns error? {
    // Test Saturday (day 6 in Ballerina time, but our function uses 0=Saturday, 1=Sunday)
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z"); // Saturday
    test:assertTrue(isWeekend(saturday), "Saturday should be weekend");

    // Test Sunday
    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z"); // Sunday
    test:assertTrue(isWeekend(sunday), "Sunday should be weekend");

    // Test Monday (weekday)
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z"); // Monday
    test:assertFalse(isWeekend(monday), "Monday should not be weekend");

    // Test Friday (weekday)
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z"); // Friday
    test:assertFalse(isWeekend(friday), "Friday should not be weekend");
}

@test:Config {}
function testIsWeekday() returns error? {
    // Test Monday (weekday)
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertTrue(isWeekday(monday), "Monday should be weekday");

    // Test Friday (weekday)
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertTrue(isWeekday(friday), "Friday should be weekday");

    // Test Saturday (weekend)
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z");
    test:assertFalse(isWeekday(saturday), "Saturday should not be weekday");

    // Test Sunday (weekend)
    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z");
    test:assertFalse(isWeekday(sunday), "Sunday should not be weekday");
}

@test:Config {}
function testNextWeekday() returns error? {
    // Test from Friday - should return Monday
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc nextFromFriday = check nextWeekday(friday);
    time:Utc expectedMonday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertEquals(nextFromFriday, expectedMonday, "Next weekday from Friday should be Monday");

    // Test from Saturday - should return Monday
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z");
    time:Utc nextFromSaturday = check nextWeekday(saturday);
    test:assertEquals(nextFromSaturday, expectedMonday, "Next weekday from Saturday should be Monday");

    // Test from Sunday - should return Monday
    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z");
    time:Utc nextFromSunday = check nextWeekday(sunday);
    test:assertEquals(nextFromSunday, expectedMonday, "Next weekday from Sunday should be Monday");

    // Test from Monday - should return Tuesday
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    time:Utc nextFromMonday = check nextWeekday(monday);
    time:Utc expectedTuesday = check time:utcFromString("2023-09-19T12:00:00Z");
    test:assertEquals(nextFromMonday, expectedTuesday, "Next weekday from Monday should be Tuesday");
}

@test:Config {}
function testPreviousWeekday() returns error? {
    // Test from Monday - should return Friday
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    time:Utc prevFromMonday = check previousWeekday(monday);
    time:Utc expectedFriday = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(prevFromMonday, expectedFriday, "Previous weekday from Monday should be Friday");

    // Test from Saturday - should return Friday
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z");
    time:Utc prevFromSaturday = check previousWeekday(saturday);
    test:assertEquals(prevFromSaturday, expectedFriday, "Previous weekday from Saturday should be Friday");

    // Test from Sunday - should return Friday
    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z");
    time:Utc prevFromSunday = check previousWeekday(sunday);
    test:assertEquals(prevFromSunday, expectedFriday, "Previous weekday from Sunday should be Friday");

    // Test from Tuesday - should return Monday
    time:Utc tuesday = check time:utcFromString("2023-09-19T12:00:00Z");
    time:Utc prevFromTuesday = check previousWeekday(tuesday);
    time:Utc expectedMonday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertEquals(prevFromTuesday, expectedMonday, "Previous weekday from Tuesday should be Monday");
}

@test:Config {}
function testAddBusinessDays() returns error? {
    // Test adding 1 business day from Friday - should skip weekend and go to Monday
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z");
    time:Utc result = check addBusinessDays(friday, 1);
    time:Utc expectedMonday = check time:utcFromString("2023-09-18T12:00:00Z");
    test:assertEquals(result, expectedMonday, "Adding 1 business day from Friday should give Monday");

    // Test adding 3 business days from Monday
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z");
    result = check addBusinessDays(monday, 3);
    time:Utc expectedThursday = check time:utcFromString("2023-09-21T12:00:00Z");
    test:assertEquals(result, expectedThursday, "Adding 3 business days from Monday should give Thursday");

    // Test subtracting 1 business day from Monday - should give Friday
    result = check addBusinessDays(monday, -1);
    time:Utc expectedPrevFriday = check time:utcFromString("2023-09-15T12:00:00Z");
    test:assertEquals(result, expectedPrevFriday, "Subtracting 1 business day from Monday should give Friday");

    // Test adding 0 business days - should return same date
    result = check addBusinessDays(monday, 0);
    test:assertEquals(result, monday, "Adding 0 business days should return same date");
}

@test:Config {}
function testAge() returns error? {
    // Test age calculation
    time:Utc birthDate = check time:utcFromString("2000-05-15T12:00:00Z");
    time:Utc currentDate = check time:utcFromString("2023-09-15T12:00:00Z");

    Duration ageDuration = age(birthDate, currentDate);

    // The difference function calculates days, hours, minutes, seconds
    // For approximately 23 years and 4 months, that's roughly 8523 days
    test:assertTrue(ageDuration.days != (), "Age should have days calculated");
    test:assertTrue(ageDuration.days >= 8500, "Age should be roughly 8500+ days for 23+ years");

    // Test with current time as now
    Duration ageNow = age(birthDate);
    test:assertTrue(ageNow.days != (), "Age now should have days calculated");
    test:assertTrue(ageNow.days >= 9000, "Age from birth should be at least 9000+ days in 2025");
}

@test:Config {}
function testHumanizeDuration() returns error? {
    // Test single unit
    Duration oneYear = {years: 1};
    string result = humanizeDuration(oneYear);
    test:assertEquals(result, "1 year", "One year should be humanized correctly");

    // Test multiple units
    Duration complex = {years: 2, months: 3, days: 1};
    result = humanizeDuration(complex);
    test:assertEquals(result, "2 years, 3 months and 1 day", "Complex duration should be humanized correctly");

    // Test zero duration
    Duration zero = {};
    result = humanizeDuration(zero);
    test:assertEquals(result, "0 seconds", "Zero duration should be humanized as 0 seconds");

    // Test with different locale (assuming EN_US is supported)
    Duration oneDay = {days: 1};
    result = humanizeDuration(oneDay, EN_US);
    test:assertEquals(result, "1 day", "One day with EN_US locale should be correct");

    // Test plural forms
    Duration twoDays = {days: 2};
    result = humanizeDuration(twoDays);
    test:assertEquals(result, "2 days", "Two days should use plural form");
}

@test:Config {}
function testFormatDuration() returns error? {
    // Test hh:mm:ss format
    Duration timeDuration = {hours: 2, minutes: 5, seconds: 30.5};
    string result = formatDuration(timeDuration, "hh:mm:ss");
    test:assertEquals(result, "02:05:30", "Time format should be correct");

    // Test human format
    Duration humanDuration = {years: 1, months: 2};
    result = formatDuration(humanDuration, "human");
    test:assertEquals(result, "1 year and 2 months", "Human format should be correct");

    // Test unknown format (should fallback to human)
    result = formatDuration(humanDuration, "unknown");
    test:assertEquals(result, "1 year and 2 months", "Unknown format should fallback to human");

    // Test with zero padding for single digit hours
    Duration shortTime = {hours: 1, minutes: 2, seconds: 3.0};
    result = formatDuration(shortTime, "hh:mm:ss");
    test:assertEquals(result, "01:02:03", "Single digit hours should be zero-padded");
}
