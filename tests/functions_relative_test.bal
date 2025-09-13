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
function testAddDaysBasic() returns error? {
    // Test adding positive days within same month
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addDays(baseTime, 5);
    time:Utc expected = check time:utcFromString("2023-09-20T14:30:25.123Z");
    test:assertEquals(result, expected, "Adding 5 days should work correctly");

    // Test adding zero days
    time:Utc zeroResult = check addDays(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 days should return same time");

    // Test adding 1 day
    time:Utc oneDayResult = check addDays(baseTime, 1);
    time:Utc expectedOneDay = check time:utcFromString("2023-09-16T14:30:25.123Z");
    test:assertEquals(oneDayResult, expectedOneDay, "Adding 1 day should work correctly");
}

@test:Config {}
function testAddHoursBasic() returns error? {
    // Test adding positive hours within same day
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addHours(baseTime, 3);
    time:Utc expected = check time:utcFromString("2023-09-15T17:30:25.123Z");
    test:assertEquals(result, expected, "Adding 3 hours should work correctly");

    // Test adding zero hours
    time:Utc zeroResult = check addHours(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 hours should return same time");

    // Test adding 1 hour
    time:Utc oneHourResult = check addHours(baseTime, 1);
    time:Utc expectedOneHour = check time:utcFromString("2023-09-15T15:30:25.123Z");
    test:assertEquals(oneHourResult, expectedOneHour, "Adding 1 hour should work correctly");
}

@test:Config {}
function testAddMinutesBasic() returns error? {
    // Test adding positive minutes within same hour
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addMinutes(baseTime, 15);
    time:Utc expected = check time:utcFromString("2023-09-15T14:45:25.123Z");
    test:assertEquals(result, expected, "Adding 15 minutes should work correctly");

    // Test adding zero minutes
    time:Utc zeroResult = check addMinutes(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 minutes should return same time");

    // Test adding 5 minutes
    time:Utc fiveMinutesResult = check addMinutes(baseTime, 5);
    time:Utc expectedFiveMinutes = check time:utcFromString("2023-09-15T14:35:25.123Z");
    test:assertEquals(fiveMinutesResult, expectedFiveMinutes, "Adding 5 minutes should work correctly");
}

@test:Config {}
function testAddSecondsBasic() returns error? {
    // Test adding positive seconds within same minute
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addSeconds(baseTime, 10.5d);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:35.623Z");
    test:assertEquals(result, expected, "Adding 10.5 seconds should work correctly");

    // Test adding zero seconds
    time:Utc zeroResult = check addSeconds(baseTime, 0.0d);
    test:assertEquals(zeroResult, baseTime, "Adding 0 seconds should return same time");

    // Test adding fractional seconds
    time:Utc fractionalResult = check addSeconds(baseTime, 0.001d);
    time:Utc expectedFractional = check time:utcFromString("2023-09-15T14:30:25.124Z");
    test:assertEquals(fractionalResult, expectedFractional, "Adding fractional seconds should work correctly");
}

@test:Config {}
function testAddWeeksBasic() returns error? {
    // Test adding positive weeks
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addWeeks(baseTime, 1);
    time:Utc expected = check time:utcFromString("2023-09-22T14:30:25.123Z");
    test:assertEquals(result, expected, "Adding 1 week should work correctly");

    // Test adding zero weeks
    time:Utc zeroResult = check addWeeks(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 weeks should return same time");

    // Test adding 2 weeks within same month
    time:Utc startMonth = check time:utcFromString("2023-09-01T14:30:25.123Z");
    time:Utc twoWeeksResult = check addWeeks(startMonth, 2);
    time:Utc expectedTwoWeeks = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(twoWeeksResult, expectedTwoWeeks, "Adding 2 weeks should work correctly");
}

@test:Config {}
function testAddMonthsBasic() returns error? {
    // Test adding positive months
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addMonths(baseTime, 1);
    time:Utc expected = check time:utcFromString("2023-10-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Adding 1 month should work correctly");

    // Test adding zero months
    time:Utc zeroResult = check addMonths(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 months should return same time");

    // Test adding 3 months within same year
    time:Utc threeMonthsResult = check addMonths(baseTime, 3);
    time:Utc expectedThreeMonths = check time:utcFromString("2023-12-15T14:30:25.123Z");
    test:assertEquals(threeMonthsResult, expectedThreeMonths, "Adding 3 months should work correctly");
}

@test:Config {}
function testAddYearsBasic() returns error? {
    // Test adding positive years
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check addYears(baseTime, 1);
    time:Utc expected = check time:utcFromString("2024-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Adding 1 year should work correctly");

    // Test adding zero years
    time:Utc zeroResult = check addYears(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Adding 0 years should return same time");

    // Test adding 2 years
    time:Utc twoYearsResult = check addYears(baseTime, 2);
    time:Utc expectedTwoYears = check time:utcFromString("2025-09-15T14:30:25.123Z");
    test:assertEquals(twoYearsResult, expectedTwoYears, "Adding 2 years should work correctly");
}

@test:Config {}
function testSubtractDaysBasic() returns error? {
    // Test subtracting positive days within same month
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check subtractDays(baseTime, 5);
    time:Utc expected = check time:utcFromString("2023-09-10T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 5 days should work correctly");

    // Test subtracting zero days
    time:Utc zeroResult = check subtractDays(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 days should return same time");

    // Test subtracting 1 day
    time:Utc oneDayResult = check subtractDays(baseTime, 1);
    time:Utc expectedOneDay = check time:utcFromString("2023-09-14T14:30:25.123Z");
    test:assertEquals(oneDayResult, expectedOneDay, "Subtracting 1 day should work correctly");
}

@test:Config {}
function testSubtractHoursBasic() returns error? {
    // Test subtracting positive hours within same day
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    time:Utc result = check subtractHours(baseTime, 3);
    time:Utc expected = check time:utcFromString("2023-09-15T11:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 3 hours should work correctly");

    // Test subtracting zero hours
    time:Utc zeroResult = check subtractHours(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 hours should return same time");

    // Test subtracting 1 hour
    time:Utc oneHourResult = check subtractHours(baseTime, 1);
    time:Utc expectedOneHour = check time:utcFromString("2023-09-15T13:30:25.123Z");
    test:assertEquals(oneHourResult, expectedOneHour, "Subtracting 1 hour should work correctly");
}

@test:Config {}
function testSubtractMinutesBasic() returns error? {
    // Test subtracting positive minutes within same hour
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:45:25.123Z");
    time:Utc result = check subtractMinutes(baseTime, 15);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 15 minutes should work correctly");

    // Test subtracting zero minutes
    time:Utc zeroResult = check subtractMinutes(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 minutes should return same time");

    // Test subtracting 5 minutes
    time:Utc fiveMinutesResult = check subtractMinutes(baseTime, 5);
    time:Utc expectedFiveMinutes = check time:utcFromString("2023-09-15T14:40:25.123Z");
    test:assertEquals(fiveMinutesResult, expectedFiveMinutes, "Subtracting 5 minutes should work correctly");
}

@test:Config {}
function testSubtractSecondsBasic() returns error? {
    // Test subtracting positive seconds within same minute
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:35.623Z");
    time:Utc result = check subtractSeconds(baseTime, 10.5d);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 10.5 seconds should work correctly");

    // Test subtracting zero seconds
    time:Utc zeroResult = check subtractSeconds(baseTime, 0.0d);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 seconds should return same time");

    // Test subtracting fractional seconds
    time:Utc fractionalResult = check subtractSeconds(baseTime, 0.500d);
    time:Utc expectedFractional = check time:utcFromString("2023-09-15T14:30:35.123Z");
    test:assertEquals(fractionalResult, expectedFractional, "Subtracting fractional seconds should work correctly");
}

@test:Config {}
function testSubtractWeeksBasic() returns error? {
    // Test subtracting positive weeks within same month
    time:Utc baseTime = check time:utcFromString("2023-09-22T14:30:25.123Z");
    time:Utc result = check subtractWeeks(baseTime, 1);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 1 week should work correctly");

    // Test subtracting zero weeks
    time:Utc zeroResult = check subtractWeeks(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 weeks should return same time");

    // Test subtracting 2 weeks within same month
    time:Utc endMonth = check time:utcFromString("2023-09-29T14:30:25.123Z");
    time:Utc twoWeeksResult = check subtractWeeks(endMonth, 2);
    time:Utc expectedTwoWeeks = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(twoWeeksResult, expectedTwoWeeks, "Subtracting 2 weeks should work correctly");
}

@test:Config {}
function testSubtractMonthsBasic() returns error? {
    // Test subtracting positive months
    time:Utc baseTime = check time:utcFromString("2023-10-15T14:30:25.123Z");
    time:Utc result = check subtractMonths(baseTime, 1);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 1 month should work correctly");

    // Test subtracting zero months
    time:Utc zeroResult = check subtractMonths(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 months should return same time");

    // Test subtracting 3 months within same year
    time:Utc decemberTime = check time:utcFromString("2023-12-15T14:30:25.123Z");
    time:Utc threeMonthsResult = check subtractMonths(decemberTime, 3);
    time:Utc expectedThreeMonths = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(threeMonthsResult, expectedThreeMonths, "Subtracting 3 months should work correctly");
}

@test:Config {}
function testSubtractYearsBasic() returns error? {
    // Test subtracting positive years
    time:Utc baseTime = check time:utcFromString("2025-09-15T14:30:25.123Z");
    time:Utc result = check subtractYears(baseTime, 1);
    time:Utc expected = check time:utcFromString("2024-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Subtracting 1 year should work correctly");

    // Test subtracting zero years
    time:Utc zeroResult = check subtractYears(baseTime, 0);
    test:assertEquals(zeroResult, baseTime, "Subtracting 0 years should return same time");

    // Test subtracting 2 years
    time:Utc twoYearsResult = check subtractYears(baseTime, 2);
    time:Utc expectedTwoYears = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(twoYearsResult, expectedTwoYears, "Subtracting 2 years should work correctly");
}

@test:Config {}
function testRelativeFunctionBasicSymmetry() returns error? {
    // Test that add and subtract functions are symmetric for basic operations
    time:Utc baseTime = check time:utcFromString("2023-09-15T14:30:25.123Z");

    // Test days symmetry
    time:Utc addDaysResult = check addDays(baseTime, 3);
    time:Utc subtractDaysResult = check subtractDays(addDaysResult, 3);
    test:assertEquals(subtractDaysResult, baseTime, "Add and subtract days should be symmetric");

    // Test hours symmetry
    time:Utc addHoursResult = check addHours(baseTime, 5);
    time:Utc subtractHoursResult = check subtractHours(addHoursResult, 5);
    test:assertEquals(subtractHoursResult, baseTime, "Add and subtract hours should be symmetric");

    // Test minutes symmetry
    time:Utc addMinutesResult = check addMinutes(baseTime, 15);
    time:Utc subtractMinutesResult = check subtractMinutes(addMinutesResult, 15);
    test:assertEquals(subtractMinutesResult, baseTime, "Add and subtract minutes should be symmetric");

    // Test seconds symmetry
    time:Utc addSecondsResult = check addSeconds(baseTime, 30.5d);
    time:Utc subtractSecondsResult = check subtractSeconds(addSecondsResult, 30.5d);
    test:assertEquals(subtractSecondsResult, baseTime, "Add and subtract seconds should be symmetric");

    // Test months symmetry
    time:Utc addMonthsResult = check addMonths(baseTime, 2);
    time:Utc subtractMonthsResult = check subtractMonths(addMonthsResult, 2);
    test:assertEquals(subtractMonthsResult, baseTime, "Add and subtract months should be symmetric");

    // Test years symmetry
    time:Utc addYearsResult = check addYears(baseTime, 1);
    time:Utc subtractYearsResult = check subtractYears(addYearsResult, 1);
    test:assertEquals(subtractYearsResult, baseTime, "Add and subtract years should be symmetric");
}

@test:Config {}
function testRelativeFunctionChaining() returns error? {
    // Test chaining multiple relative operations
    time:Utc baseTime = check time:utcFromString("2023-01-15T10:30:25.123Z");

    // Add 1 year, 2 months, 3 days, 2 hours, 15 minutes, and 30 seconds
    time:Utc step1 = check addYears(baseTime, 1);
    time:Utc step2 = check addMonths(step1, 2);
    time:Utc step3 = check addDays(step2, 3);
    time:Utc step4 = check addHours(step3, 2);
    time:Utc step5 = check addMinutes(step4, 15);
    time:Utc resultTime = check addSeconds(step5, 30.0d);

    time:Utc expected = check time:utcFromString("2024-03-18T12:45:55.123Z");
    test:assertEquals(resultTime, expected, "Combined addition operations should work correctly");
}
