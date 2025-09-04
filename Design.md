# Ballerina TimePlus Module Design & Implementation Status

**Author:** Hasitha Aravinda (@hasithaa)  
**Date:** August 18, 2025  
**Updated:** September 4, 2025  
**Version:** 1.0  

## 1. Introduction & Vision

The TimePlus module is a comprehensive time utility library for Ballerina that extends the standard `ballerina/time` module with powerful, real-world functionality. Built upon the solid foundation of `time:Utc`, this module provides an intuitive and extensive API for modern application development.

### Key Design Principles
- **Compatibility First**: Built on `time:Utc` for seamless integration
- **Ecosystem Integration**: Native support for JavaScript, Python, and AI/LLM platforms
- **Developer Experience**: Intuitive APIs with consistent naming conventions
- **Real-World Focus**: Addresses practical time-related challenges
- **Comprehensive Testing**: Extensive test coverage (113+ test cases)

## 2. Implementation Status

### ✅ **COMPLETED AREAS/FUNCTIONALITIES**

#### Core Foundation ✅
- **Types & Constants** (`types.bal`)
  - Duration record type with optional fields
  - TimeFormat enum with 20+ predefined formats
  - Standard timezone constants (60+ global timezones)
  - Common date/time format constants

#### Core Functions ✅  
- **String Conversion** (`functions_core.bal`)
  - `toString(time:Utc, TimeFormat)` - Format time to string
  - `fromString(string, TimeFormat)` - Parse time from string
  - `toZone(time:Utc, string)` - Convert to timezone
  - `fromZone(time:Civil, string)` - Convert from timezone

#### Interoperability ✅
- **Cross-Platform Integration** (`functions_interop.bal`)
  - `fromJsTimestamp(decimal)` - JavaScript milliseconds since epoch
  - `toJsTimestamp(time:Utc)` - Convert to JS timestamp
  - `fromPythonTimestamp(decimal)` - Python seconds since epoch  
  - `toPythonTimestamp(time:Utc)` - Convert to Python timestamp
  - `fromUnixTimestamp(int)` - Unix seconds since epoch
  - `toUnixTimestamp(time:Utc)` - Convert to Unix timestamp

#### Time Calculations ✅
- **Arithmetic Operations** (`functions_calculation.bal`)
  - `add(time:Utc, Duration)` - Add duration to time
  - `subtract(time:Utc, Duration)` - Subtract duration from time
  - `difference(time:Utc, time:Utc)` - Calculate time difference

#### Component Access ✅
- **Getters & Extractors** (`functions_getters.bal`)
  - `getYear/Month/Day/Hour/Minute/Second()` - Component extraction
  - `getDayOfWeek()` - Day name (e.g., "Monday")
  - `getDayOfYear()` - Day number (1-366)
  - `getWeekOfYear()` - ISO week number

#### Comparisons & Queries ✅
- **Comparison Functions** (`functions_comparison.bal`)
  - `isBefore/isAfter/isSame()` - Time comparisons
  - `isBetween()` - Range checking
  - `isLeapYear()` - Leap year detection
  - `daysInMonth()` - Days in month calculation

#### Time Unit Operations ✅
- **Start/End Functions** (`functions_units.bal`)
  - `startOfYear/Month/Day/Hour()` - Period start times
  - `endOfYear/Month/Day/Hour()` - Period end times

#### Business Logic ✅
- **Business Time Functions** (`functions_business.bal`)
  - `isWeekend/isWeekday()` - Business day detection
  - `nextWeekday/previousWeekday()` - Skip weekends
  - `addBusinessDays()` - Business day arithmetic

#### Convenience Functions ✅
- **Relative Time Operations** (`functions_relative.bal`)
  - `addDays/Hours/Minutes/Seconds/Weeks/Months/Years()` - Simple additions
  - `subtractDays/Hours/Minutes/Seconds/Weeks/Months/Years()` - Simple subtractions

#### Utility Functions ✅
- **High-Level Utilities** (`functions_utility.bal`)
  - `now()` - Current UTC time
  - `nowInZone(string)` - Current time in timezone
  - `today()` - Today at midnight UTC
  - `todayInZone(string)` - Today at midnight in timezone
  - `create()` - Create time from components
  - `createInZone()` - Create time in timezone
  - `parseIso8601/Rfc3339()` - Common format parsers
  - `isInRange()` - Range validation
  - `clamp()` - Value constraining
  - `min/max()` - Array operations

## 3. Architecture Overview

### Module Structure
```
timeplus/
├── types.bal                    # Core types and constants
├── functions_core.bal          # String conversion & timezone
├── functions_interop.bal       # Cross-platform integration  
├── functions_calculation.bal   # Arithmetic operations
├── functions_getters.bal       # Component extraction
├── functions_comparison.bal    # Comparison & queries
├── functions_units.bal         # Start/end of time units
├── functions_business.bal      # Business time logic
├── functions_relative.bal      # Convenient relative operations
├── functions_utility.bal       # High-level utilities
└── tests/                      # Comprehensive test suite
    ├── functions_core_test.bal
    ├── functions_interop_test.bal
    ├── functions_calculation_test.bal
    ├── functions_getters_test.bal
    ├── functions_comparison_test.bal
    ├── functions_units_test.bal
    ├── functions_business_test.bal
    ├── functions_relative_test.bal
    └── functions_utility_test.bal
```

### Key Design Decisions

1. **Functional Organization**: Functions grouped by purpose within the same module for maintainability
2. **Consistent Naming**: Predictable function names following patterns
3. **Error Handling**: Graceful degradation with informative error messages
4. **Performance**: Built on efficient `time:Utc` foundation
5. **Extensibility**: Clear patterns for adding new functionality

## 4. Implementation Highlights

### 4.1. Type System
```ballerina
// Core Duration type for time arithmetic
public type Duration record {|
    int years?;
    int months?;
    int days?;
    int hours?;
    int minutes?;
    decimal seconds?;
|};

// Time format enumeration
public enum TimeFormat {
    ISO_8601,
    RFC_3339,
    YYYY_MM_DD,
    // ... 20+ formats
}
```

### 4.2. Comprehensive Constants
- **60+ Timezone Constants**: Global coverage including major financial centers
- **20+ Format Constants**: Common patterns for dates, times, and timestamps
- **Business Logic Constants**: Weekend definitions, quarter boundaries

### 4.3. Cross-Platform Integration
```ballerina
// JavaScript ecosystem
public isolated function fromJsTimestamp(decimal milliseconds) returns time:Utc
public isolated function toJsTimestamp(time:Utc utcTime) returns decimal

// Python ecosystem  
public isolated function fromPythonTimestamp(decimal seconds) returns time:Utc
public isolated function toPythonTimestamp(time:Utc utcTime) returns decimal

// Unix/Linux ecosystem
public isolated function fromUnixTimestamp(int seconds) returns time:Utc
public isolated function toUnixTimestamp(time:Utc utcTime) returns int
```

### 4.4. Business Time Intelligence
```ballerina
// Business day calculations
public isolated function isWeekend(time:Utc utcTime) returns boolean
public isolated function addBusinessDays(time:Utc utcTime, int businessDays) returns time:Utc
public isolated function nextWeekday(time:Utc utcTime) returns time:Utc
```

### 4.5. Intuitive Utilities
```ballerina
// High-level convenience functions
public isolated function now() returns time:Utc
public isolated function today() returns time:Utc|time:Error
public isolated function isInRange(time:Utc timeToCheck, time:Utc startTime, time:Utc endTime, boolean inclusive = true) returns boolean
public isolated function clamp(time:Utc timeToClamp, time:Utc minTime, time:Utc maxTime) returns time:Utc
```

## 5. Usage Examples

### Basic Time Operations
```ballerina
import commons/timeplus;

// Get current time
time:Utc now = timeplus:now();
time:Utc today = check timeplus:today();

// Create specific times
time:Utc specificTime = check timeplus:create(2023, 9, 15, 14, 30, 25.123d);
time:Utc timezoneTime = check timeplus:createInZone(2023, 9, 15, "America/New_York", 14, 30);

// Format and parse
string formatted = check timeplus:toString(now, timeplus:ISO_8601);
time:Utc parsed = check timeplus:parseIso8601("2023-09-15T14:30:25.123Z");
```

### Cross-Platform Integration  
```ballerina
// JavaScript integration
decimal jsTimestamp = timeplus:toJsTimestamp(now);
time:Utc fromJs = timeplus:fromJsTimestamp(jsTimestamp);

// Python integration
decimal pythonTimestamp = timeplus:toPythonTimestamp(now);
time:Utc fromPython = timeplus:fromPythonTimestamp(pythonTimestamp);

// Unix timestamp
int unixTimestamp = timeplus:toUnixTimestamp(now);
time:Utc fromUnix = timeplus:fromUnixTimestamp(unixTimestamp);
```

### Business Logic
```ballerina
// Business day calculations
time:Utc someDate = check timeplus:create(2023, 9, 15); // Friday
boolean isWeekend = timeplus:isWeekend(someDate); // false
time:Utc nextBusinessDay = timeplus:nextWeekday(someDate); // Monday
time:Utc futureBusinessDate = timeplus:addBusinessDays(someDate, 5);

// Time components
int year = timeplus:getYear(someDate);
string dayName = timeplus:getDayOfWeek(someDate); // "Friday"
int dayOfYear = timeplus:getDayOfYear(someDate);
```

### Time Arithmetic
```ballerina
// Duration-based arithmetic
timeplus:Duration duration = {years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6.789d};
time:Utc future = timeplus:add(now, duration);
time:Utc past = timeplus:subtract(now, duration);
timeplus:Duration diff = timeplus:difference(future, past);

// Simple relative operations  
time:Utc tomorrow = timeplus:addDays(today, 1);
time:Utc nextWeek = timeplus:addWeeks(today, 1);
time:Utc nextMonth = timeplus:addMonths(today, 1);
```

## 6. Future Enhancements

### Planned Features
- **Extended Timezone Database**: Full IANA timezone database integration
- **Localization Support**: Multi-language day/month names
- **Duration Formatting**: Human-readable duration strings
- **Advanced Parsing**: Flexible date/time string recognition


## 7. Migration Guide

### From `ballerina/time`
TimePlus is designed as a drop-in enhancement to `ballerina/time`. Existing code using `time:Utc` continues to work unchanged, with TimePlus providing additional functionality.

```ballerina
// Before (ballerina/time)
time:Utc now = time:utcNow();
time:Civil civil = time:utcToCivil(now);

// After (with timeplus enhancement)
time:Utc now = timeplus:now(); // Same result, consistent API
string formatted = check timeplus:toString(now, timeplus:ISO_8601); // Additional power
```

### Best Practices
1. **Use Type Constants**: Prefer `timeplus:ISO_8601` over string literals
2. **Handle Errors Gracefully**: Always handle potential parsing/conversion errors
3. **Timezone Awareness**: Be explicit about timezone handling in business logic
4. **Test Edge Cases**: Validate behavior around leap years, month boundaries
5. **Performance Monitoring**: Profile time-critical applications
