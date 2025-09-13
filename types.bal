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

# Represents a duration with optional components
public type Duration record {|
    # Number of years
    int years?;
    # Number of months
    int months?;
    # Number of days
    int days?;
    # Number of hours
    int hours?;
    # Number of minutes
    int minutes?;
    # Number of seconds (with fractional support)
    decimal seconds?;
|};

# Represents time units for start/end operations
public enum Unit {
    # Year
    YEAR = "year",
    # Month
    MONTH = "month",
    # Day
    DAY = "day",
    # Hour
    HOUR = "hour",
    # Minute
    MINUTE = "minute",
    # Second
    SECOND = "second"
}

# Represents supported locales for internationalization
public enum Locale {
    # English
    EN = "en",
    # English (US)
    EN_US = "en_US",
    # English (UK)
    EN_GB = "en_GB",
    # English (Canada)
    EN_CA = "en_CA",
    # English (Australia)
    EN_AU = "en_AU",
    # English (New Zealand)
    EN_NZ = "en_NZ"
}

# Represents day of week names
public enum DayOfWeekName {
    # Sunday
    SUNDAY = "Sunday",
    # Monday
    MONDAY = "Monday",
    # Tuesday
    TUESDAY = "Tuesday",
    # Wednesday
    WEDNESDAY = "Wednesday",
    # Thursday
    THURSDAY = "Thursday",
    # Friday
    FRIDAY = "Friday",
    # Saturday
    SATURDAY = "Saturday"
}

# Represents time format patterns
public enum TimeFormat {
    # ISO 8601 format
    ISO_8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSX",
    # ISO 8601 with Z
    ISO_8601_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    # RFC 3339 format
    RFC_3339 = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX",
    # RFC 1123 format
    RFC_1123 = "EEE, dd MMM yyyy HH:mm:ss z",
    # Year-Month-Day
    YYYY_MM_DD = "yyyy-MM-dd",
    # Month/Day/Year
    MM_DD_YYYY = "MM/dd/yyyy",
    # Day/Month/Year
    DD_MM_YYYY = "dd/MM/yyyy",
    # Day Month Year
    DD_MMM_YYYY = "dd MMM yyyy",
    # Month Day, Year
    MMM_DD_YYYY = "MMM dd, yyyy",
    # Full Month Day, Year
    MMMM_DD_YYYY = "MMMM dd, yyyy",
    # Year-Month-Day Hour:Minute:Second
    YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss",
    # US common datetime
    US_COMMON_DATETIME = "MM/dd/yyyy, hh:mm:ss a",
    # EU common datetime
    EU_COMMON_DATETIME = "dd/MM/yyyy HH:mm:ss",
    # Short datetime
    SHORT_DATETIME = "yyyy-MM-dd HH:mm",
    # Long datetime
    LONG_DATETIME = "EEEE, MMMM dd, yyyy 'at' hh:mm:ss a",
    # Hour:Minute:Second
    HH_MM_SS = "HH:mm:ss",
    # Hour:Minute
    HH_MM = "HH:mm",
    # 12-hour Hour:Minute:Second
    HH_MM_SS_12H = "hh:mm:ss a",
    # 12-hour Hour:Minute
    HH_MM_12H = "hh:mm a",
    # SQL datetime
    SQL_DATETIME = "yyyy-MM-dd HH:mm:ss.SSS",
    # SQL date format
    SQL_DATE = "yyyy-MM-dd",
    # SQL time format
    SQL_TIME = "HH:mm:ss",
    # Log timestamp format
    LOG_TIMESTAMP = "yyyy-MM-dd HH:mm:ss.SSS",
    # Syslog timestamp
    SYSLOG_TIMESTAMP = "MMM dd HH:mm:ss",
    # Apache log format
    APACHE_LOG = "dd/MMM/yyyy:HH:mm:ss Z",
    # Sortable datetime
    SORTABLE_DATETIME = "yyyyMMddHHmmss",
    # Sortable date
    SORTABLE_DATE = "yyyyMMdd"
}
