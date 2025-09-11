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
function testNow() returns error? {
    // Test that now() returns a valid UTC time
    time:Utc currentTime = now();
    
    // Since we can't predict the exact time, we just verify it's a valid time
    // by converting it to civil time and checking it's reasonable
    time:Civil civilTime = time:utcToCivil(currentTime);
    
    // Verify it's a reasonable year (between 2020 and 2030 for this test)
    test:assertTrue(civilTime.year >= 2020 && civilTime.year <= 2030, 
        "Current year should be reasonable");
    
    // Verify month is valid
    test:assertTrue(civilTime.month >= 1 && civilTime.month <= 12, 
        "Month should be between 1 and 12");
    
    // Verify day is valid
    test:assertTrue(civilTime.day >= 1 && civilTime.day <= 31, 
        "Day should be between 1 and 31");
    
    // Test that multiple calls to now() are close to each other
    time:Utc time1 = now();
    time:Utc time2 = now();
    
    // The times should be very close (within a reasonable threshold)
    decimal diff = time:utcDiffSeconds(time2, time1);
    test:assertTrue(diff >= 0.0d && diff < 1.0d, 
        "Sequential calls to now() should be within 1 second");
}

@test:Config {}
function testToday() returns error? {
    // Test that today() returns midnight UTC
    time:Utc todayUtc = check today();
    time:Civil todayCivil = time:utcToCivil(todayUtc);
    
    // Should be at midnight UTC
    test:assertEquals(todayCivil.hour, 0, "Today should be at hour 0");
    test:assertEquals(todayCivil.minute, 0, "Today should be at minute 0");
    test:assertEquals(todayCivil.second, 0.0d, "Today should be at second 0");
    
    // Should be a reasonable date
    test:assertTrue(todayCivil.year >= 2020 && todayCivil.year <= 2030, 
        "Today's year should be reasonable");
    test:assertTrue(todayCivil.month >= 1 && todayCivil.month <= 12, 
        "Today's month should be valid");
    test:assertTrue(todayCivil.day >= 1 && todayCivil.day <= 31, 
        "Today's day should be valid");
    
    // Test that today() is consistent across multiple calls (within same day)
    time:Utc today1 = check today();
    time:Utc today2 = check today();
    test:assertEquals(today1, today2, "Multiple calls to today() should return same value");
}

@test:Config {}
function testCreate() returns error? {
    // Test creating UTC time with all parameters
    time:Utc result = check create(2023, 9, 15, 14, 30, 25.123d);
    time:Utc expected = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result, expected, "Create with all parameters should work correctly");
    
    // Test creating UTC time with only required parameters (defaults)
    time:Utc resultDefaults = check create(2023, 9, 15);
    time:Utc expectedDefaults = check time:utcFromString("2023-09-15T00:00:00.000Z");
    test:assertEquals(resultDefaults, expectedDefaults, "Create with defaults should work correctly");
    
    // Test creating UTC time with partial parameters
    time:Utc resultPartial = check create(2023, 12, 25, 12);
    time:Utc expectedPartial = check time:utcFromString("2023-12-25T12:00:00.000Z");
    test:assertEquals(resultPartial, expectedPartial, "Create with partial parameters should work correctly");
    
    // Test creating UTC time with hour and minute
    time:Utc resultHourMin = check create(2024, 2, 29, 23, 59);
    time:Utc expectedHourMin = check time:utcFromString("2024-02-29T23:59:00.000Z");
    test:assertEquals(resultHourMin, expectedHourMin, "Create with hour and minute should work correctly");
    
    // Test leap year date
    time:Utc leapYear = check create(2024, 2, 29, 12, 30, 45.678d);
    time:Utc expectedLeap = check time:utcFromString("2024-02-29T12:30:45.678Z");
    test:assertEquals(leapYear, expectedLeap, "Create leap year date should work correctly");
    
    // Test edge cases - start of year
    time:Utc startYear = check create(2023, 1, 1);
    time:Utc expectedStart = check time:utcFromString("2023-01-01T00:00:00.000Z");
    test:assertEquals(startYear, expectedStart, "Create start of year should work correctly");
    
    // Test edge cases - end of year
    time:Utc endYear = check create(2023, 12, 31, 23, 59, 59.999d);
    time:Utc expectedEnd = check time:utcFromString("2023-12-31T23:59:59.999Z");
    test:assertEquals(endYear, expectedEnd, "Create end of year should work correctly");
    
    // Test invalid dates should return errors
    time:Utc|error invalidMonth = create(2023, 13, 15);
    test:assertTrue(invalidMonth is error, "Invalid month should return error");
    
    time:Utc|error invalidDay = create(2023, 2, 30);
    test:assertTrue(invalidDay is error, "Invalid day should return error");
    
    time:Utc|error invalidHour = create(2023, 9, 15, 25);
    test:assertTrue(invalidHour is error, "Invalid hour should return error");
    
    time:Utc|error invalidMinute = create(2023, 9, 15, 14, 60);
    test:assertTrue(invalidMinute is error, "Invalid minute should return error");
}

@test:Config {}
function testParseIso8601() returns error? {
    // Test parsing valid ISO 8601 strings
    time:Utc result1 = check parseIso8601("2023-09-15T14:30:25.123Z");
    time:Utc expected1 = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result1, expected1, "Parse ISO 8601 with Z should work correctly");
    
    time:Utc result2 = check parseIso8601("2023-09-15T14:30:25.123+00:00");
    time:Utc expected2 = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result2, expected2, "Parse ISO 8601 with +00:00 should work correctly");
    
    time:Utc result3 = check parseIso8601("2023-12-31T23:59:59.999Z");
    time:Utc expected3 = check time:utcFromString("2023-12-31T23:59:59.999Z");
    test:assertEquals(result3, expected3, "Parse ISO 8601 end of year should work correctly");
    
    time:Utc result4 = check parseIso8601("2024-02-29T12:00:00.000Z");
    time:Utc expected4 = check time:utcFromString("2024-02-29T12:00:00.000Z");
    test:assertEquals(result4, expected4, "Parse ISO 8601 leap year should work correctly");
    
    // Test invalid ISO 8601 strings
    time:Utc|error invalid1 = parseIso8601("invalid-string");
    test:assertTrue(invalid1 is error, "Invalid ISO 8601 string should return error");
    
    time:Utc|error invalid2 = parseIso8601("2023-13-15T14:30:25.123Z");
    test:assertTrue(invalid2 is error, "Invalid month in ISO 8601 should return error");
    
    time:Utc|error invalid3 = parseIso8601("2023-09-32T14:30:25.123Z");
    test:assertTrue(invalid3 is error, "Invalid day in ISO 8601 should return error");
}

@test:Config {}
function testParseRfc3339() returns error? {
    // Test parsing valid RFC 3339 strings
    time:Utc result1 = check parseRfc3339("2023-09-15T14:30:25.123Z");
    time:Utc expected1 = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result1, expected1, "Parse RFC 3339 with Z should work correctly");
    
    time:Utc result2 = check parseRfc3339("2023-09-15T14:30:25.123+00:00");
    time:Utc expected2 = check time:utcFromString("2023-09-15T14:30:25.123Z");
    test:assertEquals(result2, expected2, "Parse RFC 3339 with +00:00 should work correctly");
    
    time:Utc result3 = check parseRfc3339("2024-01-01T00:00:00.000Z");
    time:Utc expected3 = check time:utcFromString("2024-01-01T00:00:00.000Z");
    test:assertEquals(result3, expected3, "Parse RFC 3339 start of year should work correctly");
    
    time:Utc result4 = check parseRfc3339("2023-12-31T23:59:59.999+00:00");
    time:Utc expected4 = check time:utcFromString("2023-12-31T23:59:59.999Z");
    test:assertEquals(result4, expected4, "Parse RFC 3339 end of year should work correctly");
    
    // Test invalid RFC 3339 strings
    time:Utc|error invalid1 = parseRfc3339("invalid-string");
    test:assertTrue(invalid1 is error, "Invalid RFC 3339 string should return error");
    
    time:Utc|error invalid2 = parseRfc3339("2023-09-15T25:30:25.123Z");
    test:assertTrue(invalid2 is error, "Invalid hour in RFC 3339 should return error");
    
    time:Utc|error invalid3 = parseRfc3339("2023-02-30T14:30:25.123Z");
    test:assertTrue(invalid3 is error, "Invalid date in RFC 3339 should return error");
}

@test:Config {}
function testIsInRange() returns error? {
    time:Utc startTime = check time:utcFromString("2023-09-15T10:00:00.000Z");
    time:Utc middleTime = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc endTime = check time:utcFromString("2023-09-15T14:00:00.000Z");
    time:Utc beforeTime = check time:utcFromString("2023-09-15T08:00:00.000Z");
    time:Utc afterTime = check time:utcFromString("2023-09-15T16:00:00.000Z");
    
    // Test inclusive range (default)
    test:assertTrue(isInRange(middleTime, startTime, endTime), 
        "Middle time should be in inclusive range");
    test:assertTrue(isInRange(startTime, startTime, endTime), 
        "Start time should be in inclusive range");
    test:assertTrue(isInRange(endTime, startTime, endTime), 
        "End time should be in inclusive range");
    test:assertFalse(isInRange(beforeTime, startTime, endTime), 
        "Before time should not be in inclusive range");
    test:assertFalse(isInRange(afterTime, startTime, endTime), 
        "After time should not be in inclusive range");
    
    // Test explicit inclusive range
    test:assertTrue(isInRange(middleTime, startTime, endTime, true), 
        "Middle time should be in explicit inclusive range");
    test:assertTrue(isInRange(startTime, startTime, endTime, true), 
        "Start time should be in explicit inclusive range");
    test:assertTrue(isInRange(endTime, startTime, endTime, true), 
        "End time should be in explicit inclusive range");
    
    // Test exclusive range
    test:assertTrue(isInRange(middleTime, startTime, endTime, false), 
        "Middle time should be in exclusive range");
    test:assertFalse(isInRange(startTime, startTime, endTime, false), 
        "Start time should not be in exclusive range");
    test:assertFalse(isInRange(endTime, startTime, endTime, false), 
        "End time should not be in exclusive range");
    test:assertFalse(isInRange(beforeTime, startTime, endTime, false), 
        "Before time should not be in exclusive range");
    test:assertFalse(isInRange(afterTime, startTime, endTime, false), 
        "After time should not be in exclusive range");
    
    // Test same time range
    test:assertTrue(isInRange(startTime, startTime, startTime, true), 
        "Same time should be in inclusive range with itself");
    test:assertFalse(isInRange(startTime, startTime, startTime, false), 
        "Same time should not be in exclusive range with itself");
    
    // Test millisecond precision
    time:Utc precise1 = check time:utcFromString("2023-09-15T12:00:00.001Z");
    time:Utc precise2 = check time:utcFromString("2023-09-15T12:00:00.002Z");
    time:Utc precise3 = check time:utcFromString("2023-09-15T12:00:00.003Z");
    
    test:assertTrue(isInRange(precise2, precise1, precise3), 
        "Precise time should be in range");
    test:assertFalse(isInRange(precise1, precise2, precise3, false), 
        "Precise start should not be in exclusive range");
}

@test:Config {}
function testClamp() returns error? {
    time:Utc minTime = check time:utcFromString("2023-09-15T10:00:00.000Z");
    time:Utc maxTime = check time:utcFromString("2023-09-15T14:00:00.000Z");
    time:Utc middleTime = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc beforeTime = check time:utcFromString("2023-09-15T08:00:00.000Z");
    time:Utc afterTime = check time:utcFromString("2023-09-15T16:00:00.000Z");
    
    // Test clamp within range - should return original time
    time:Utc clampedMiddle = clamp(middleTime, minTime, maxTime);
    test:assertEquals(clampedMiddle, middleTime, 
        "Time within range should not be clamped");
    
    // Test clamp at boundaries - should return original time
    time:Utc clampedMin = clamp(minTime, minTime, maxTime);
    test:assertEquals(clampedMin, minTime, 
        "Time at min boundary should not be clamped");
    
    time:Utc clampedMax = clamp(maxTime, minTime, maxTime);
    test:assertEquals(clampedMax, maxTime, 
        "Time at max boundary should not be clamped");
    
    // Test clamp below range - should return min time
    time:Utc clampedBefore = clamp(beforeTime, minTime, maxTime);
    test:assertEquals(clampedBefore, minTime, 
        "Time before range should be clamped to min");
    
    // Test clamp above range - should return max time
    time:Utc clampedAfter = clamp(afterTime, minTime, maxTime);
    test:assertEquals(clampedAfter, maxTime, 
        "Time after range should be clamped to max");
    
    // Test clamp with same min and max
    time:Utc clampedSame = clamp(middleTime, minTime, minTime);
    test:assertEquals(clampedSame, minTime, 
        "Time should be clamped to single value");
    
    // Test clamp with millisecond precision
    time:Utc preciseMin = check time:utcFromString("2023-09-15T12:00:00.001Z");
    time:Utc preciseMax = check time:utcFromString("2023-09-15T12:00:00.003Z");
    time:Utc preciseBefore = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc preciseAfter = check time:utcFromString("2023-09-15T12:00:00.004Z");
    
    time:Utc clampedPreciseBefore = clamp(preciseBefore, preciseMin, preciseMax);
    test:assertEquals(clampedPreciseBefore, preciseMin, 
        "Precise time before range should be clamped to min");
    
    time:Utc clampedPreciseAfter = clamp(preciseAfter, preciseMin, preciseMax);
    test:assertEquals(clampedPreciseAfter, preciseMax, 
        "Precise time after range should be clamped to max");
}

@test:Config {}
function testMin() returns error? {
    time:Utc time1 = check time:utcFromString("2023-09-15T10:00:00.000Z");
    time:Utc time2 = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc time3 = check time:utcFromString("2023-09-15T14:00:00.000Z");
    time:Utc time4 = check time:utcFromString("2023-09-15T08:00:00.000Z");
    
    // Test min with ordered times
    time:Utc minResult1 = min([time1, time2, time3]);
    test:assertEquals(minResult1, time1, "Min should return earliest time from ordered list");
    
    // Test min with unordered times
    time:Utc minResult2 = min([time3, time1, time2]);
    test:assertEquals(minResult2, time1, "Min should return earliest time from unordered list");
    
    // Test min with earliest time at end
    time:Utc minResult3 = min([time2, time3, time4]);
    test:assertEquals(minResult3, time4, "Min should return earliest time from any position");
    
    // Test min with single time
    time:Utc minResult4 = min([time2]);
    test:assertEquals(minResult4, time2, "Min of single time should return that time");
    
    // Test min with duplicate times
    time:Utc minResult5 = min([time2, time1, time2, time3]);
    test:assertEquals(minResult5, time1, "Min should handle duplicate times correctly");
    
    // Test min with all same times
    time:Utc minResult6 = min([time2, time2, time2]);
    test:assertEquals(minResult6, time2, "Min of identical times should return that time");
    
    // Test with millisecond precision
    time:Utc precise1 = check time:utcFromString("2023-09-15T12:00:00.001Z");
    time:Utc precise2 = check time:utcFromString("2023-09-15T12:00:00.002Z");
    time:Utc precise3 = check time:utcFromString("2023-09-15T12:00:00.003Z");
    
    time:Utc minPrecise = min([precise3, precise1, precise2]);
    test:assertEquals(minPrecise, precise1, "Min should handle millisecond precision");
}

@test:Config {}
function testMax() returns error? {
    time:Utc time1 = check time:utcFromString("2023-09-15T10:00:00.000Z");
    time:Utc time2 = check time:utcFromString("2023-09-15T12:00:00.000Z");
    time:Utc time3 = check time:utcFromString("2023-09-15T14:00:00.000Z");
    time:Utc time4 = check time:utcFromString("2023-09-15T16:00:00.000Z");
    
    // Test max with ordered times
    time:Utc maxResult1 = max([time1, time2, time3]);
    test:assertEquals(maxResult1, time3, "Max should return latest time from ordered list");
    
    // Test max with unordered times
    time:Utc maxResult2 = max([time2, time4, time1]);
    test:assertEquals(maxResult2, time4, "Max should return latest time from unordered list");
    
    // Test max with latest time at beginning
    time:Utc maxResult3 = max([time4, time1, time2]);
    test:assertEquals(maxResult3, time4, "Max should return latest time from any position");
    
    // Test max with single time
    time:Utc maxResult4 = max([time2]);
    test:assertEquals(maxResult4, time2, "Max of single time should return that time");
    
    // Test max with duplicate times
    time:Utc maxResult5 = max([time1, time3, time2, time3]);
    test:assertEquals(maxResult5, time3, "Max should handle duplicate times correctly");
    
    // Test max with all same times
    time:Utc maxResult6 = max([time2, time2, time2]);
    test:assertEquals(maxResult6, time2, "Max of identical times should return that time");
    
    // Test with millisecond precision
    time:Utc precise1 = check time:utcFromString("2023-09-15T12:00:00.001Z");
    time:Utc precise2 = check time:utcFromString("2023-09-15T12:00:00.002Z");
    time:Utc precise3 = check time:utcFromString("2023-09-15T12:00:00.003Z");
    
    time:Utc maxPrecise = max([precise1, precise3, precise2]);
    test:assertEquals(maxPrecise, precise3, "Max should handle millisecond precision");
}

@test:Config {}
function testUtilityFunctionIntegration() returns error? {
    // Test integration between different utility functions
    
    // Create a time and verify it can be used with other functions
    time:Utc createdTime = check create(2023, 9, 15, 12, 30, 0.0d);
    
    // Test with isInRange
    time:Utc rangeStart = check create(2023, 9, 15, 10, 0, 0.0d);
    time:Utc rangeEnd = check create(2023, 9, 15, 15, 0, 0.0d);
    test:assertTrue(isInRange(createdTime, rangeStart, rangeEnd), 
        "Created time should be in range");
    
    // Test with clamp
    time:Utc clampedTime = clamp(createdTime, rangeStart, rangeEnd);
    test:assertEquals(clampedTime, createdTime, 
        "Time within range should not be changed by clamp");
    
    // Test with min and max
    time:Utc[] times = [rangeStart, createdTime, rangeEnd];
    time:Utc minTime = min(times);
    time:Utc maxTime = max(times);
    test:assertEquals(minTime, rangeStart, "Min should return range start");
    test:assertEquals(maxTime, rangeEnd, "Max should return range end");
    
    // Test parse functions with different formats
    time:Utc isoTime = check parseIso8601("2023-09-15T12:30:00.000Z");
    time:Utc rfcTime = check parseRfc3339("2023-09-15T12:30:00.000Z");
    test:assertEquals(isoTime, createdTime, "ISO parsed time should match created time");
    test:assertEquals(rfcTime, createdTime, "RFC parsed time should match created time");
    
    // Test that all times are the same
    test:assertEquals(isoTime, rfcTime, "ISO and RFC parsed times should be identical");
}

@test:Config {}
function testUtilityFunctionEdgeCases() returns error? {
    // Test edge cases for utility functions
    
    // Test create with leap year edge case
    time:Utc leapDay = check create(2024, 2, 29, 23, 59, 59.999d);
    time:Civil leapCivil = time:utcToCivil(leapDay);
    test:assertEquals(leapCivil.year, 2024, "Leap year should be 2024");
    test:assertEquals(leapCivil.month, 2, "Leap month should be February");
    test:assertEquals(leapCivil.day, 29, "Leap day should be 29");
    
    // Test min/max with times spanning different years
    time:Utc year2022 = check create(2022, 12, 31, 23, 59, 59.999d);
    time:Utc year2023 = check create(2023, 1, 1, 0, 0, 0.0d);
    time:Utc year2024 = check create(2024, 6, 15, 12, 0, 0.0d);
    
    time:Utc[] yearSpanTimes = [year2023, year2024, year2022];
    time:Utc minYear = min(yearSpanTimes);
    time:Utc maxYear = max(yearSpanTimes);
    test:assertEquals(minYear, year2022, "Min should find earliest year");
    test:assertEquals(maxYear, year2024, "Max should find latest year");
    
    // Test clamp across year boundary
    time:Utc year2025 = check create(2025, 1, 1, 0, 0, 0.0d);
    time:Utc clampedYear = clamp(year2025, year2022, year2024);
    test:assertEquals(clampedYear, year2024, "Time should be clamped to max year");
    
    // Test isInRange with very close times (millisecond precision instead of microsecond)
    time:Utc milliStart = check time:utcFromString("2023-09-15T12:00:00.001Z");
    time:Utc milliMiddle = check time:utcFromString("2023-09-15T12:00:00.002Z");
    time:Utc milliEnd = check time:utcFromString("2023-09-15T12:00:00.003Z");
    
    test:assertTrue(isInRange(milliMiddle, milliStart, milliEnd), 
        "Millisecond precision should work in range check");
    test:assertTrue(isInRange(milliMiddle, milliStart, milliEnd, false), 
        "Millisecond precision should work in exclusive range check since middle is truly between start and end");
}
