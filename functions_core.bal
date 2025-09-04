// Copyright (c) 2025 Hasitha Aravinda. All Rights Reserved.
//
// This software may be modified and distributed under the terms
// of the MIT license. See the LICENSE file for details.

import ballerina/time;

# Helper function to pad a number with leading zero if needed
#
# + num - The number to pad
# + return - The padded string
isolated function pad2(int num) returns string {
    return num < 10 ? "0" + num.toString() : num.toString();
}

# Helper function to pad a number with leading zeros to 3 digits
#
# + num - The number to pad
# + return - The padded string
isolated function pad3(int num) returns string {
    if num < 10 {
        return "00" + num.toString();
    } else if num < 100 {
        return "0" + num.toString();
    } else {
        return num.toString();
    }
}

# Helper function to get month name with locale support
#
# + month - The month number (1-12)
# + locale - The locale to use (defaults to EN)
# + return - The full month name
isolated function getMonthName(int month, Locale locale = EN) returns string {
    match locale {
        EN|EN_US|EN_CA|EN_AU|EN_NZ => {
            match month {
                1 => { return "January"; }
                2 => { return "February"; }
                3 => { return "March"; }
                4 => { return "April"; }
                5 => { return "May"; }
                6 => { return "June"; }
                7 => { return "July"; }
                8 => { return "August"; }
                9 => { return "September"; }
                10 => { return "October"; }
                11 => { return "November"; }
                12 => { return "December"; }
                _ => { return "Unknown"; }
            }
        }
        EN_GB => {
            // British English - same as standard English for months
            match month {
                1 => { return "January"; }
                2 => { return "February"; }
                3 => { return "March"; }
                4 => { return "April"; }
                5 => { return "May"; }
                6 => { return "June"; }
                7 => { return "July"; }
                8 => { return "August"; }
                9 => { return "September"; }
                10 => { return "October"; }
                11 => { return "November"; }
                12 => { return "December"; }
                _ => { return "Unknown"; }
            }
        }
        _ => {
            // Default fallback to EN
            return getMonthName(month, EN);
        }
    }
}

# Helper function to get abbreviated month name with locale support
#
# + month - The month number (1-12)
# + locale - The locale to use (defaults to EN)
# + return - The abbreviated month name
isolated function getMonthAbbr(int month, Locale locale = EN) returns string {
    match locale {
        EN|EN_US|EN_CA|EN_AU|EN_NZ|EN_GB => {
            match month {
                1 => { return "Jan"; }
                2 => { return "Feb"; }
                3 => { return "Mar"; }
                4 => { return "Apr"; }
                5 => { return "May"; }
                6 => { return "Jun"; }
                7 => { return "Jul"; }
                8 => { return "Aug"; }
                9 => { return "Sep"; }
                10 => { return "Oct"; }
                11 => { return "Nov"; }
                12 => { return "Dec"; }
                _ => { return "Unk"; }
            }
        }
        _ => {
            // Default fallback to EN
            return getMonthAbbr(month, EN);
        }
    }
}

# Helper function to convert 24-hour to 12-hour format
#
# + hour - The hour in 24-hour format (0-23)
# + return - Tuple containing [12-hour format hour, AM/PM indicator]
isolated function to12Hour(int hour) returns [int, string] {
    if hour == 0 {
        return [12, "AM"];
    } else if hour < 12 {
        return [hour, "AM"];
    } else if hour == 12 {
        return [12, "PM"];
    } else {
        return [hour - 12, "PM"];
    }
}

# Helper function to get weekday abbreviation from day of week number with locale support
#
# + dayOfWeek - The day of week number (0=Saturday, 1=Sunday, etc.)
# + locale - The locale to use (defaults to EN)
# + return - The abbreviated day name
isolated function getWeekDayAbbr(int dayOfWeek, Locale locale = EN) returns string {
    match locale {
        EN|EN_US|EN_CA|EN_AU|EN_NZ|EN_GB => {
            match dayOfWeek {
                0 => { return "Sat"; }
                1 => { return "Sun"; }
                2 => { return "Mon"; }
                3 => { return "Tue"; }
                4 => { return "Wed"; }
                5 => { return "Thu"; }
                6 => { return "Fri"; }
                _ => { return "Sun"; }
            }
        }
        _ => {
            // Default fallback to EN
            return getWeekDayAbbr(dayOfWeek, EN);
        }
    }
}

# Helper function to get DayOfWeekName enum value from day of week number
#
# + dayOfWeek - The day of week number (0=Saturday, 1=Sunday, etc.)
# + return - The DayOfWeekName enum value
isolated function getDayOfWeekNameEnum(int dayOfWeek) returns DayOfWeekName {
    match dayOfWeek {
        0 => { return SATURDAY; }
        1 => { return SUNDAY; }
        2 => { return MONDAY; }
        3 => { return TUESDAY; }
        4 => { return WEDNESDAY; }
        5 => { return THURSDAY; }
        6 => { return FRIDAY; }
        _ => { return SUNDAY; } // Default fallback
    }
}

# Converts a UTC time to a DayOfWeekName enum value
#
# + utcTime - The UTC time
# + return - The DayOfWeekName enum value
public isolated function toDayOfWeekEnum(time:Utc utcTime) returns DayOfWeekName {
    int dayOfWeek = getDayOfWeek(utcTime);
    return getDayOfWeekNameEnum(dayOfWeek);
}

# Converts a UTC time to a string using the specified format with locale support
#
# + utcTime - The UTC time to convert  
# + format - The format enum to use for conversion
# + locale - The locale to use for text elements (defaults to EN)
# + return - The formatted string
public isolated function toString(time:Utc utcTime, TimeFormat format, Locale locale = EN) returns string {
    time:Civil civilTime = time:utcToCivil(utcTime);
    
    // Extract components
    int year = civilTime.year;
    int month = civilTime.month;
    int day = civilTime.day;
    int hour = civilTime.hour;
    int minute = civilTime.minute;
    decimal second = civilTime.second ?: 0.0d;
    int wholeSeconds = <int>second;
    int milliseconds = <int>((second - <decimal>wholeSeconds) * 1000.0d);
    
    // Format according to the specified format enum
    match format {
        ISO_8601 => {
            return string`${year}-${pad2(month)}-${pad2(day)}T${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}.${pad3(milliseconds)}Z`;
        }
        ISO_8601_Z => {
            return string`${year}-${pad2(month)}-${pad2(day)}T${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}.${pad3(milliseconds)}Z`;
        }
        RFC_3339 => {
            return string`${year}-${pad2(month)}-${pad2(day)}T${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}.${pad3(milliseconds)}Z`;
        }
        RFC_1123 => {
            int dayOfWeek = getDayOfWeek(utcTime);
            string dayAbbr = getWeekDayAbbr(dayOfWeek, locale);
            string monthAbbr = getMonthAbbr(month, locale);
            return string`${dayAbbr}, ${pad2(day)} ${monthAbbr} ${year} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)} GMT`;
        }
        YYYY_MM_DD => {
            return string`${year}-${pad2(month)}-${pad2(day)}`;
        }
        MM_DD_YYYY => {
            return string`${pad2(month)}/${pad2(day)}/${year}`;
        }
        DD_MM_YYYY => {
            return string`${pad2(day)}/${pad2(month)}/${year}`;
        }
        DD_MMM_YYYY => {
            string monthAbbr = getMonthAbbr(month, locale);
            return string`${pad2(day)} ${monthAbbr} ${year}`;
        }
        MMM_DD_YYYY => {
            string monthAbbr = getMonthAbbr(month, locale);
            return string`${monthAbbr} ${pad2(day)}, ${year}`;
        }
        MMMM_DD_YYYY => {
            string monthName = getMonthName(month, locale);
            return string`${monthName} ${pad2(day)}, ${year}`;
        }
        YYYY_MM_DD_HH_MM_SS => {
            return string`${year}-${pad2(month)}-${pad2(day)} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
        US_COMMON_DATETIME => {
            [int, string] hourAmpm = to12Hour(hour);
            return string`${pad2(month)}/${pad2(day)}/${year}, ${pad2(hourAmpm[0])}:${pad2(minute)}:${pad2(wholeSeconds)} ${hourAmpm[1]}`;
        }
        EU_COMMON_DATETIME => {
            return string`${pad2(day)}/${pad2(month)}/${year} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
        SHORT_DATETIME => {
            return string`${year}-${pad2(month)}-${pad2(day)} ${pad2(hour)}:${pad2(minute)}`;
        }
        LONG_DATETIME => {
            string dayName = getDayOfWeekName(utcTime, locale);
            string monthName = getMonthName(month, locale);
            [int, string] hourAmpm = to12Hour(hour);
            return string`${dayName}, ${monthName} ${pad2(day)}, ${year} at ${pad2(hourAmpm[0])}:${pad2(minute)}:${pad2(wholeSeconds)} ${hourAmpm[1]}`;
        }
        HH_MM_SS => {
            return string`${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
        HH_MM => {
            return string`${pad2(hour)}:${pad2(minute)}`;
        }
        HH_MM_SS_12H => {
            [int, string] hourAmpm = to12Hour(hour);
            return string`${pad2(hourAmpm[0])}:${pad2(minute)}:${pad2(wholeSeconds)} ${hourAmpm[1]}`;
        }
        HH_MM_12H => {
            [int, string] hourAmpm = to12Hour(hour);
            return string`${pad2(hourAmpm[0])}:${pad2(minute)} ${hourAmpm[1]}`;
        }
        SQL_DATETIME => {
            return string`${year}-${pad2(month)}-${pad2(day)} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}.${pad3(milliseconds)}`;
        }
        SQL_DATE => {
            return string`${year}-${pad2(month)}-${pad2(day)}`;
        }
        SQL_TIME => {
            return string`${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
        LOG_TIMESTAMP => {
            return string`${year}-${pad2(month)}-${pad2(day)} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}.${pad3(milliseconds)}`;
        }
        SYSLOG_TIMESTAMP => {
            string monthAbbr = getMonthAbbr(month, locale);
            return string`${monthAbbr} ${pad2(day)} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
        APACHE_LOG => {
            string monthAbbr = getMonthAbbr(month, locale);
            return string`${pad2(day)}/${monthAbbr}/${year}:${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)} +0000`;
        }
        SORTABLE_DATETIME => {
            return string`${year}${pad2(month)}${pad2(day)}${pad2(hour)}${pad2(minute)}${pad2(wholeSeconds)}`;
        }
        SORTABLE_DATE => {
            return string`${year}${pad2(month)}${pad2(day)}`;
        }
        _ => {
            return string`${year}-${pad2(month)}-${pad2(day)} ${pad2(hour)}:${pad2(minute)}:${pad2(wholeSeconds)}`;
        }
    }
}

# Parses a time string using the specified format
#
# + timeStr - The time string to parse
# + format - The format enum to use for parsing  
# + return - The parsed UTC time or an error if parsing fails
public isolated function fromString(string timeStr, TimeFormat format) returns time:Utc|error {
    // Basic format parsing implementation - can be extended
    if format == ISO_8601 || format == ISO_8601_Z {
        // Handle ISO 8601 format: YYYY-MM-DDTHH:mm:ss.sssZ
        time:Civil civilTime = check time:civilFromString(timeStr);
        return time:utcFromCivil(civilTime);
    } else if format == YYYY_MM_DD {
        // Handle date-only format: YYYY-MM-DD - append UTC time info
        time:Civil civilTime = check time:civilFromString(timeStr + "T00:00:00Z");
        return time:utcFromCivil(civilTime);
    } else {
        // Fallback to standard Ballerina parsing
        time:Civil civilTime = check time:civilFromString(timeStr);
        return time:utcFromCivil(civilTime);
    }
}

# Converts UTC time to civil time in the specified timezone
#
# + utcTime - The UTC time to convert
# + zoneId - The timezone identifier
# + return - The civil time or an error if conversion fails  
public isolated function toZone(time:Utc utcTime, string zoneId) returns time:Civil|error {
    // Basic timezone conversion - can be extended with full timezone database
    if zoneId == "UTC" || zoneId == "GMT" {
        return time:utcToCivil(utcTime);
    } else {
        // For now, just return UTC time - full timezone implementation would require timezone database
        return time:utcToCivil(utcTime);
    }
}

# Converts civil time to UTC
#
# + civilTime - The civil time to convert
# + zoneId - The timezone identifier
# + return - The UTC time or an error if conversion fails
public isolated function fromZone(time:Civil civilTime, string zoneId) returns time:Utc|error {
    // Basic timezone conversion - can be extended with full timezone database
    if zoneId == "UTC" || zoneId == "GMT" {
        return time:utcFromCivil(civilTime);
    } else {
        // For now, just treat as UTC - full timezone implementation would require timezone database
        return time:utcFromCivil(civilTime);
    }
}
