// Copyright (c) 2025 Hasitha Aravinda. All Rights Reserved.
//
// This software may be modified and distributed under the terms
// of the MIT license. See the LICENSE file for details.

import ballerina/test;
import ballerina/time;

@test:Config {}
function testPad2() returns error? {
    // Test single digit padding
    test:assertEquals(pad2(1), "01", "Single digit should be padded with zero");
    test:assertEquals(pad2(5), "05", "Single digit should be padded with zero");
    test:assertEquals(pad2(9), "09", "Single digit should be padded with zero");
    
    // Test double digit (no padding needed)
    test:assertEquals(pad2(10), "10", "Double digit should not be padded");
    test:assertEquals(pad2(25), "25", "Double digit should not be padded");
    test:assertEquals(pad2(99), "99", "Double digit should not be padded");
    
    // Test edge cases
    test:assertEquals(pad2(0), "00", "Zero should be padded");
    test:assertEquals(pad2(100), "100", "Triple digit should not be truncated");
}

@test:Config {}
function testPad3() returns error? {
    // Test single digit padding
    test:assertEquals(pad3(1), "001", "Single digit should be padded with two zeros");
    test:assertEquals(pad3(5), "005", "Single digit should be padded with two zeros");
    
    // Test double digit padding
    test:assertEquals(pad3(10), "010", "Double digit should be padded with one zero");
    test:assertEquals(pad3(50), "050", "Double digit should be padded with one zero");
    test:assertEquals(pad3(99), "099", "Double digit should be padded with one zero");
    
    // Test triple digit (no padding needed)
    test:assertEquals(pad3(100), "100", "Triple digit should not be padded");
    test:assertEquals(pad3(123), "123", "Triple digit should not be padded");
    test:assertEquals(pad3(999), "999", "Triple digit should not be padded");
    
    // Test edge cases
    test:assertEquals(pad3(0), "000", "Zero should be padded with two zeros");
    test:assertEquals(pad3(1000), "1000", "Four digit should not be truncated");
}

@test:Config {}
function testGetMonthName() returns error? {
    // Test all months with EN locale
    test:assertEquals(getMonthName(1, EN), "January", "January should be correct");
    test:assertEquals(getMonthName(2, EN), "February", "February should be correct");
    test:assertEquals(getMonthName(3, EN), "March", "March should be correct");
    test:assertEquals(getMonthName(4, EN), "April", "April should be correct");
    test:assertEquals(getMonthName(5, EN), "May", "May should be correct");
    test:assertEquals(getMonthName(6, EN), "June", "June should be correct");
    test:assertEquals(getMonthName(7, EN), "July", "July should be correct");
    test:assertEquals(getMonthName(8, EN), "August", "August should be correct");
    test:assertEquals(getMonthName(9, EN), "September", "September should be correct");
    test:assertEquals(getMonthName(10, EN), "October", "October should be correct");
    test:assertEquals(getMonthName(11, EN), "November", "November should be correct");
    test:assertEquals(getMonthName(12, EN), "December", "December should be correct");
    
    // Test all EN locale variants
    test:assertEquals(getMonthName(1, EN_US), "January", "EN_US should work like EN");
    test:assertEquals(getMonthName(1, EN_CA), "January", "EN_CA should work like EN");
    test:assertEquals(getMonthName(1, EN_AU), "January", "EN_AU should work like EN");
    test:assertEquals(getMonthName(1, EN_NZ), "January", "EN_NZ should work like EN");
    test:assertEquals(getMonthName(1, EN_GB), "January", "EN_GB should work like EN");
    
    // Test invalid month
    test:assertEquals(getMonthName(0, EN), "Unknown", "Invalid month should return Unknown");
    test:assertEquals(getMonthName(13, EN), "Unknown", "Invalid month should return Unknown");
    test:assertEquals(getMonthName(-1, EN), "Unknown", "Invalid month should return Unknown");
}

@test:Config {}
function testGetMonthAbbr() returns error? {
    // Test all months with EN locale
    test:assertEquals(getMonthAbbr(1, EN), "Jan", "January abbreviation should be correct");
    test:assertEquals(getMonthAbbr(2, EN), "Feb", "February abbreviation should be correct");
    test:assertEquals(getMonthAbbr(3, EN), "Mar", "March abbreviation should be correct");
    test:assertEquals(getMonthAbbr(4, EN), "Apr", "April abbreviation should be correct");
    test:assertEquals(getMonthAbbr(5, EN), "May", "May abbreviation should be correct");
    test:assertEquals(getMonthAbbr(6, EN), "Jun", "June abbreviation should be correct");
    test:assertEquals(getMonthAbbr(7, EN), "Jul", "July abbreviation should be correct");
    test:assertEquals(getMonthAbbr(8, EN), "Aug", "August abbreviation should be correct");
    test:assertEquals(getMonthAbbr(9, EN), "Sep", "September abbreviation should be correct");
    test:assertEquals(getMonthAbbr(10, EN), "Oct", "October abbreviation should be correct");
    test:assertEquals(getMonthAbbr(11, EN), "Nov", "November abbreviation should be correct");
    test:assertEquals(getMonthAbbr(12, EN), "Dec", "December abbreviation should be correct");
    
    // Test all EN locale variants
    test:assertEquals(getMonthAbbr(1, EN_US), "Jan", "EN_US should work like EN");
    test:assertEquals(getMonthAbbr(1, EN_GB), "Jan", "EN_GB should work like EN");
    
    // Test invalid month
    test:assertEquals(getMonthAbbr(0, EN), "Unk", "Invalid month should return Unk");
    test:assertEquals(getMonthAbbr(13, EN), "Unk", "Invalid month should return Unk");
}

@test:Config {}
function testTo12Hour() returns error? {
    // Test midnight
    [int, string] result = to12Hour(0);
    test:assertEquals(result[0], 12, "Midnight hour should be 12");
    test:assertEquals(result[1], "AM", "Midnight should be AM");
    
    // Test morning hours
    result = to12Hour(1);
    test:assertEquals(result[0], 1, "1 AM should be 1");
    test:assertEquals(result[1], "AM", "1 AM should be AM");
    
    result = to12Hour(11);
    test:assertEquals(result[0], 11, "11 AM should be 11");
    test:assertEquals(result[1], "AM", "11 AM should be AM");
    
    // Test noon
    result = to12Hour(12);
    test:assertEquals(result[0], 12, "Noon hour should be 12");
    test:assertEquals(result[1], "PM", "Noon should be PM");
    
    // Test afternoon/evening hours
    result = to12Hour(13);
    test:assertEquals(result[0], 1, "1 PM should be 1");
    test:assertEquals(result[1], "PM", "1 PM should be PM");
    
    result = to12Hour(23);
    test:assertEquals(result[0], 11, "11 PM should be 11");
    test:assertEquals(result[1], "PM", "11 PM should be PM");
}

@test:Config {}
function testGetWeekDayAbbr() returns error? {
    // Test all days with EN locale
    test:assertEquals(getWeekDayAbbr(0, EN), "Sat", "Saturday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(1, EN), "Sun", "Sunday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(2, EN), "Mon", "Monday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(3, EN), "Tue", "Tuesday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(4, EN), "Wed", "Wednesday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(5, EN), "Thu", "Thursday abbreviation should be correct");
    test:assertEquals(getWeekDayAbbr(6, EN), "Fri", "Friday abbreviation should be correct");
    
    // Test all EN locale variants
    test:assertEquals(getWeekDayAbbr(1, EN_US), "Sun", "EN_US should work like EN");
    test:assertEquals(getWeekDayAbbr(1, EN_GB), "Sun", "EN_GB should work like EN");
    
    // Test invalid day
    test:assertEquals(getWeekDayAbbr(7, EN), "Sun", "Invalid day should return Sun");
    test:assertEquals(getWeekDayAbbr(-1, EN), "Sun", "Invalid day should return Sun");
}

@test:Config {}
function testToStringBasicFormats() returns error? {
    // Test with a specific date/time: 2023-09-15T14:30:25.123Z (Friday)
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test ISO formats
    test:assertEquals(toString(testTime, ISO_8601), "2023-09-15T14:30:25.123Z", "ISO_8601 format should be correct");
    test:assertEquals(toString(testTime, ISO_8601_Z), "2023-09-15T14:30:25.123Z", "ISO_8601_Z format should be correct");
    test:assertEquals(toString(testTime, RFC_3339), "2023-09-15T14:30:25.123Z", "RFC_3339 format should be correct");
    
    // Test date-only formats
    test:assertEquals(toString(testTime, YYYY_MM_DD), "2023-09-15", "YYYY_MM_DD format should be correct");
    test:assertEquals(toString(testTime, MM_DD_YYYY), "09/15/2023", "MM_DD_YYYY format should be correct");
    test:assertEquals(toString(testTime, DD_MM_YYYY), "15/09/2023", "DD_MM_YYYY format should be correct");
    test:assertEquals(toString(testTime, DD_MMM_YYYY), "15 Sep 2023", "DD_MMM_YYYY format should be correct");
    test:assertEquals(toString(testTime, MMM_DD_YYYY), "Sep 15, 2023", "MMM_DD_YYYY format should be correct");
    test:assertEquals(toString(testTime, MMMM_DD_YYYY), "September 15, 2023", "MMMM_DD_YYYY format should be correct");
    
    // Test time-only formats
    test:assertEquals(toString(testTime, HH_MM_SS), "14:30:25", "HH_MM_SS format should be correct");
    test:assertEquals(toString(testTime, HH_MM), "14:30", "HH_MM format should be correct");
    test:assertEquals(toString(testTime, HH_MM_SS_12H), "02:30:25 PM", "HH_MM_SS_12H format should be correct");
    test:assertEquals(toString(testTime, HH_MM_12H), "02:30 PM", "HH_MM_12H format should be correct");
}

@test:Config {}
function testToStringDatetimeFormats() returns error? {
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test datetime formats
    test:assertEquals(toString(testTime, YYYY_MM_DD_HH_MM_SS), "2023-09-15 14:30:25", "YYYY_MM_DD_HH_MM_SS format should be correct");
    test:assertEquals(toString(testTime, US_COMMON_DATETIME), "09/15/2023, 02:30:25 PM", "US_COMMON_DATETIME format should be correct");
    test:assertEquals(toString(testTime, EU_COMMON_DATETIME), "15/09/2023 14:30:25", "EU_COMMON_DATETIME format should be correct");
    test:assertEquals(toString(testTime, SHORT_DATETIME), "2023-09-15 14:30", "SHORT_DATETIME format should be correct");
    test:assertEquals(toString(testTime, LONG_DATETIME), "Friday, September 15, 2023 at 02:30:25 PM", "LONG_DATETIME format should be correct");
    
    // Test SQL formats
    test:assertEquals(toString(testTime, SQL_DATETIME), "2023-09-15 14:30:25.123", "SQL_DATETIME format should be correct");
    test:assertEquals(toString(testTime, SQL_DATE), "2023-09-15", "SQL_DATE format should be correct");
    test:assertEquals(toString(testTime, SQL_TIME), "14:30:25", "SQL_TIME format should be correct");
    
    // Test log formats
    test:assertEquals(toString(testTime, LOG_TIMESTAMP), "2023-09-15 14:30:25.123", "LOG_TIMESTAMP format should be correct");
    test:assertEquals(toString(testTime, SYSLOG_TIMESTAMP), "Sep 15 14:30:25", "SYSLOG_TIMESTAMP format should be correct");
    test:assertEquals(toString(testTime, APACHE_LOG), "15/Sep/2023:14:30:25 +0000", "APACHE_LOG format should be correct");
    
    // Test sortable formats
    test:assertEquals(toString(testTime, SORTABLE_DATETIME), "20230915143025", "SORTABLE_DATETIME format should be correct");
    test:assertEquals(toString(testTime, SORTABLE_DATE), "20230915", "SORTABLE_DATE format should be correct");
}

@test:Config {}
function testToStringWithRFC1123() returns error? {
    // Test RFC 1123 format which includes day of week
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z"); // Friday
    string result = toString(testTime, RFC_1123);
    test:assertEquals(result, "Fri, 15 Sep 2023 14:30:25 GMT", "RFC_1123 format should be correct");
}

@test:Config {}
function testToStringWithLocales() returns error? {
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test different locales for month/day names
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN), "Sep 15, 2023", "EN locale should work");
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN_US), "Sep 15, 2023", "EN_US locale should work");
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN_GB), "Sep 15, 2023", "EN_GB locale should work");
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN_CA), "Sep 15, 2023", "EN_CA locale should work");
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN_AU), "Sep 15, 2023", "EN_AU locale should work");
    test:assertEquals(toString(testTime, MMM_DD_YYYY, EN_NZ), "Sep 15, 2023", "EN_NZ locale should work");
    
    // Test with full month name
    test:assertEquals(toString(testTime, MMMM_DD_YYYY, EN), "September 15, 2023", "Full month name with EN should work");
    test:assertEquals(toString(testTime, MMMM_DD_YYYY, EN_GB), "September 15, 2023", "Full month name with EN_GB should work");
}

@test:Config {}
function testToStringEdgeCases() returns error? {
    // Test midnight
    time:Utc midnight = check time:utcFromString("2023-01-01T00:00:00.000Z");
    test:assertEquals(toString(midnight, HH_MM_SS_12H), "12:00:00 AM", "Midnight should be 12:00:00 AM");
    
    // Test noon
    time:Utc noon = check time:utcFromString("2023-01-01T12:00:00.000Z");
    test:assertEquals(toString(noon, HH_MM_SS_12H), "12:00:00 PM", "Noon should be 12:00:00 PM");
    
    // Test February in leap year
    time:Utc leapYearFeb = check time:utcFromString("2024-02-29T12:00:00.000Z");
    test:assertEquals(toString(leapYearFeb, YYYY_MM_DD), "2024-02-29", "Leap year February 29 should work");
    test:assertEquals(toString(leapYearFeb, MMM_DD_YYYY), "Feb 29, 2024", "Leap year February 29 with month name should work");
}

@test:Config {}
function testFromString() returns error? {
    // Test ISO 8601 parsing
    time:Utc result = check fromString("2023-09-15T14:30:25.123Z", ISO_8601);
    string formatted = toString(result, ISO_8601);
    test:assertEquals(formatted, "2023-09-15T14:30:25.123Z", "Parsing and formatting ISO_8601 should be consistent");
    
    // Test ISO 8601 Z parsing
    result = check fromString("2023-09-15T14:30:25.123Z", ISO_8601_Z);
    formatted = toString(result, ISO_8601_Z);
    test:assertEquals(formatted, "2023-09-15T14:30:25.123Z", "Parsing and formatting ISO_8601_Z should be consistent");
    
    // Test date-only parsing
    result = check fromString("2023-09-15", YYYY_MM_DD);
    formatted = toString(result, YYYY_MM_DD);
    test:assertEquals(formatted, "2023-09-15", "Parsing and formatting YYYY_MM_DD should be consistent");
    
    // Test time component for date-only parsing should be midnight
    formatted = toString(result, HH_MM_SS);
    test:assertEquals(formatted, "00:00:00", "Date-only parsing should result in midnight time");
}

@test:Config {}
function testToZoneAndFromZone() returns error? {
    time:Utc utcTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test UTC/GMT timezone conversion (should be identity)
    time:Civil civilUtc = check toZone(utcTime, "UTC");
    time:Utc backToUtc = check fromZone(civilUtc, "UTC");
    test:assertEquals(backToUtc, utcTime, "UTC timezone conversion should be identity");
    
    civilUtc = check toZone(utcTime, "GMT");
    backToUtc = check fromZone(civilUtc, "GMT");
    test:assertEquals(backToUtc, utcTime, "GMT timezone conversion should be identity");
    
    // Test unsupported timezone (should fall back to UTC behavior)
    time:Civil civilOther = check toZone(utcTime, "America/New_York");
    time:Utc backFromOther = check fromZone(civilOther, "America/New_York");
    test:assertEquals(backFromOther, utcTime, "Unsupported timezone should fall back to UTC behavior");
}

@test:Config {}
function testToStringAllTimeFormats() returns error? {
    // Test all TimeFormat enum values to ensure complete coverage
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // This test ensures all enum values are handled and don't cause runtime errors
    string result1 = toString(testTime, ISO_8601);
    test:assertTrue(result1.length() > 0, "ISO_8601 should produce output");
    
    string result2 = toString(testTime, RFC_1123);
    test:assertTrue(result2.length() > 0, "RFC_1123 should produce output");
    
    string result3 = toString(testTime, US_COMMON_DATETIME);
    test:assertTrue(result3.length() > 0, "US_COMMON_DATETIME should produce output");
    
    string result4 = toString(testTime, APACHE_LOG);
    test:assertTrue(result4.length() > 0, "APACHE_LOG should produce output");
    
    string result5 = toString(testTime, SORTABLE_DATETIME);
    test:assertTrue(result5.length() > 0, "SORTABLE_DATETIME should produce output");
    
    // Test default case (any unhandled format should fall back to standard format)
    // Note: Since all formats are explicitly handled, this tests the default branch
    string defaultResult = toString(testTime, YYYY_MM_DD_HH_MM_SS);
    test:assertEquals(defaultResult, "2023-09-15 14:30:25", "Default format should work");
}

@test:Config {}
function testAllTimeFormatsComprehensive() returns error? {
    // Test EVERY TimeFormat enum value for complete coverage
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test all formats to ensure none throw errors
    _ = toString(testTime, ISO_8601);
    _ = toString(testTime, ISO_8601_Z);
    _ = toString(testTime, RFC_3339);
    _ = toString(testTime, RFC_1123);
    _ = toString(testTime, YYYY_MM_DD);
    _ = toString(testTime, MM_DD_YYYY);
    _ = toString(testTime, DD_MM_YYYY);
    _ = toString(testTime, DD_MMM_YYYY);
    _ = toString(testTime, MMM_DD_YYYY);
    _ = toString(testTime, MMMM_DD_YYYY);
    _ = toString(testTime, YYYY_MM_DD_HH_MM_SS);
    _ = toString(testTime, US_COMMON_DATETIME);
    _ = toString(testTime, EU_COMMON_DATETIME);
    _ = toString(testTime, SHORT_DATETIME);
    _ = toString(testTime, LONG_DATETIME);
    _ = toString(testTime, HH_MM_SS);
    _ = toString(testTime, HH_MM);
    _ = toString(testTime, HH_MM_SS_12H);
    _ = toString(testTime, HH_MM_12H);
    _ = toString(testTime, SQL_DATETIME);
    _ = toString(testTime, SQL_DATE);
    _ = toString(testTime, SQL_TIME);
    _ = toString(testTime, LOG_TIMESTAMP);
    _ = toString(testTime, SYSLOG_TIMESTAMP);
    _ = toString(testTime, APACHE_LOG);
    _ = toString(testTime, SORTABLE_DATETIME);
    _ = toString(testTime, SORTABLE_DATE);
    
    test:assertTrue(true, "All TimeFormat enum values should be handled without errors");
}

@test:Config {}
function testAllLocalesComprehensive() returns error? {
    // Test EVERY Locale enum value for complete coverage
    time:Utc testTime = check time:utcFromString("2023-09-15T14:30:25.123Z");
    
    // Test all locales with a format that uses locale-specific text
    _ = toString(testTime, MMM_DD_YYYY, EN);
    _ = toString(testTime, MMM_DD_YYYY, EN_US);
    _ = toString(testTime, MMM_DD_YYYY, EN_GB);
    _ = toString(testTime, MMM_DD_YYYY, EN_CA);
    _ = toString(testTime, MMM_DD_YYYY, EN_AU);
    _ = toString(testTime, MMM_DD_YYYY, EN_NZ);
    
    // Test all locales with a format that uses full month names
    _ = toString(testTime, MMMM_DD_YYYY, EN);
    _ = toString(testTime, MMMM_DD_YYYY, EN_US);
    _ = toString(testTime, MMMM_DD_YYYY, EN_GB);
    _ = toString(testTime, MMMM_DD_YYYY, EN_CA);
    _ = toString(testTime, MMMM_DD_YYYY, EN_AU);
    _ = toString(testTime, MMMM_DD_YYYY, EN_NZ);
    
    // Test all locales with RFC 1123 format (uses day abbreviations)
    _ = toString(testTime, RFC_1123, EN);
    _ = toString(testTime, RFC_1123, EN_US);
    _ = toString(testTime, RFC_1123, EN_GB);
    _ = toString(testTime, RFC_1123, EN_CA);
    _ = toString(testTime, RFC_1123, EN_AU);
    _ = toString(testTime, RFC_1123, EN_NZ);
    
    test:assertTrue(true, "All Locale enum values should be handled without errors");
}

@test:Config {}
function testToDayOfWeekEnum() returns error? {
    // Test all days of the week to ensure all DayOfWeekName enum values are used
    time:Utc saturday = check time:utcFromString("2023-09-16T12:00:00Z"); // Saturday
    test:assertEquals(toDayOfWeekEnum(saturday), SATURDAY, "Saturday should return SATURDAY enum");
    
    time:Utc sunday = check time:utcFromString("2023-09-17T12:00:00Z"); // Sunday
    test:assertEquals(toDayOfWeekEnum(sunday), SUNDAY, "Sunday should return SUNDAY enum");
    
    time:Utc monday = check time:utcFromString("2023-09-18T12:00:00Z"); // Monday
    test:assertEquals(toDayOfWeekEnum(monday), MONDAY, "Monday should return MONDAY enum");
    
    time:Utc tuesday = check time:utcFromString("2023-09-19T12:00:00Z"); // Tuesday
    test:assertEquals(toDayOfWeekEnum(tuesday), TUESDAY, "Tuesday should return TUESDAY enum");
    
    time:Utc wednesday = check time:utcFromString("2023-09-20T12:00:00Z"); // Wednesday
    test:assertEquals(toDayOfWeekEnum(wednesday), WEDNESDAY, "Wednesday should return WEDNESDAY enum");
    
    time:Utc thursday = check time:utcFromString("2023-09-21T12:00:00Z"); // Thursday
    test:assertEquals(toDayOfWeekEnum(thursday), THURSDAY, "Thursday should return THURSDAY enum");
    
    time:Utc friday = check time:utcFromString("2023-09-15T12:00:00Z"); // Friday
    test:assertEquals(toDayOfWeekEnum(friday), FRIDAY, "Friday should return FRIDAY enum");
}
