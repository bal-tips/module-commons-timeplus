# TimePlus - Comprehensive Time Utilities for Ballerina

[![Ballerina](https://img.shields.io/badge/ballerina-2201.12.7-blue)](https://ballerina.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

TimePlus is a comprehensive time utility module for Ballerina that extends the standard `ballerina/time` module with powerful, real-world functionality. Built upon the solid foundation of `time:Utc`, this module provides an intuitive and extensive API for modern application development.

## 🚀 Key Features

- **🌍 Cross-Platform Integration**: Native support for JavaScript, Python, and Unix timestamp formats
- **🏢 Business Logic**: Weekend/weekday detection, business day calculations, timezone handling
- **📅 Comprehensive Operations**: Time arithmetic, component extraction, range validation
- **🎯 Developer Experience**: Intuitive APIs with 60+ timezone constants and 20+ format constants
- **⚡ Performance**: Built on efficient `time:Utc` foundation with extensive test coverage (113+ tests)
- **🔄 Compatibility**: Drop-in enhancement to `ballerina/time` - existing code continues to work

## 📦 Usage

Import `commons/timeplus` in your code.

```ballerina
import commons/timeplus;
```

## 🎯 Quick Start

```ballerina
import commons/timeplus;
import ballerina/time;

public function main() returns error? {
    // Get current time
    time:Utc now = timeplus:now();
    time:Utc today = check timeplus:today();
    
    // Create specific times
    time:Utc specificTime = check timeplus:create(2023, 9, 15, 14, 30, 25.123d);
    
    // Format and parse
    string formatted = check timeplus:toString(now, timeplus:ISO_8601);
    time:Utc parsed = check timeplus:parseIso8601("2023-09-15T14:30:25.123Z");
    
    // Business day logic
    boolean isWeekend = timeplus:isWeekend(specificTime);
    time:Utc nextBusinessDay = timeplus:nextWeekday(specificTime);
    
    // Cross-platform integration
    decimal jsTimestamp = timeplus:toJsTimestamp(now);
    time:Utc fromUnix = timeplus:fromUnixTimestamp(1694789825);
}
```

## 📚 Core Modules

### 🔧 Core Functions (`functions_core.bal`)
String conversion and timezone operations:
```ballerina
// Format time to string
string iso8601 = check timeplus:toString(now, timeplus:ISO_8601);
string customFormat = check timeplus:toString(now, timeplus:YYYY_MM_DD_HH_MM_SS);

// Parse from string
time:Utc parsed = check timeplus:fromString("2023-09-15", timeplus:YYYY_MM_DD);

// Timezone conversion
time:Civil nyTime = check timeplus:toZone(now, "America/New_York");
time:Utc backToUtc = check timeplus:fromZone(nyTime, "America/New_York");
```

### 🔄 Cross-Platform Integration (`functions_interop.bal`)
Seamless integration with other ecosystems:
```ballerina
// JavaScript (milliseconds since epoch)
decimal jsTimestamp = timeplus:toJsTimestamp(now);
time:Utc fromJs = timeplus:fromJsTimestamp(1694789825123.0d);

// Python (seconds since epoch) 
decimal pythonTimestamp = timeplus:toPythonTimestamp(now);
time:Utc fromPython = timeplus:fromPythonTimestamp(1694789825.123d);

// Unix systems (seconds since epoch)
int unixTimestamp = timeplus:toUnixTimestamp(now);
time:Utc fromUnix = timeplus:fromUnixTimestamp(1694789825);
```

### ➕ Time Arithmetic (`functions_calculation.bal`)
Powerful duration-based calculations:
```ballerina
// Duration type for complex operations
timeplus:Duration duration = {
    years: 1, 
    months: 2, 
    days: 3, 
    hours: 4, 
    minutes: 5, 
    seconds: 6.789d
};

time:Utc future = timeplus:add(now, duration);
time:Utc past = timeplus:subtract(now, duration);
timeplus:Duration diff = timeplus:difference(future, past);
```

### 📊 Component Extraction (`functions_getters.bal`)
Extract specific components from time values:
```ballerina
time:Utc someTime = check timeplus:create(2023, 9, 15, 14, 30, 25.123d);

int year = timeplus:getYear(someTime);          // 2023
int month = timeplus:getMonth(someTime);        // 9
string dayName = timeplus:getDayOfWeek(someTime); // "Friday"
int dayOfYear = timeplus:getDayOfYear(someTime); // 258
int weekNumber = timeplus:getWeekOfYear(someTime); // 37
```

### ⚖️ Comparisons & Queries (`functions_comparison.bal`)
Compare and query time properties:
```ballerina
time:Utc time1 = check timeplus:create(2023, 9, 15);
time:Utc time2 = check timeplus:create(2023, 9, 16);

boolean before = timeplus:isBefore(time1, time2);     // true
boolean after = timeplus:isAfter(time1, time2);      // false
boolean between = timeplus:isBetween(now, time1, time2);

boolean leapYear = timeplus:isLeapYear(time1);       // false
int daysInSept = timeplus:daysInMonth(time1);        // 30
```

### 📍 Time Unit Operations (`functions_units.bal`)
Get start and end of time periods:
```ballerina
time:Utc someTime = check timeplus:create(2023, 9, 15, 14, 30, 25.123d);

time:Utc startOfYear = timeplus:startOfYear(someTime);   // 2023-01-01T00:00:00.000Z
time:Utc startOfMonth = timeplus:startOfMonth(someTime); // 2023-09-01T00:00:00.000Z
time:Utc startOfDay = timeplus:startOfDay(someTime);     // 2023-09-15T00:00:00.000Z
time:Utc startOfHour = timeplus:startOfHour(someTime);   // 2023-09-15T14:00:00.000Z
```

### 🏢 Business Logic (`functions_business.bal`)
Business-focused time operations:
```ballerina
time:Utc friday = check timeplus:create(2023, 9, 15);   // Friday

boolean isWeekend = timeplus:isWeekend(friday);         // false
boolean isWeekday = timeplus:isWeekday(friday);         // true

time:Utc nextBusinessDay = timeplus:nextWeekday(friday); // Monday
time:Utc prevBusinessDay = timeplus:previousWeekday(friday); // Thursday

// Add 5 business days (skips weekends)
time:Utc futureBusinessDate = timeplus:addBusinessDays(friday, 5);
```

### ⏱️ Relative Operations (`functions_relative.bal`)
Simple, convenient time arithmetic:
```ballerina
time:Utc now = timeplus:now();

// Addition
time:Utc tomorrow = timeplus:addDays(now, 1);
time:Utc nextWeek = timeplus:addWeeks(now, 1);
time:Utc nextMonth = timeplus:addMonths(now, 1);
time:Utc nextYear = timeplus:addYears(now, 1);

// Subtraction
time:Utc yesterday = timeplus:subtractDays(now, 1);
time:Utc lastHour = timeplus:subtractHours(now, 1);
time:Utc thirtySecondsAgo = timeplus:subtractSeconds(now, 30.0d);
```

### 🛠️ Utility Functions (`functions_utility.bal`)
High-level convenience functions:
```ballerina
// Current time functions
time:Utc now = timeplus:now();
time:Civil nowInNy = check timeplus:nowInZone("America/New_York");
time:Utc today = check timeplus:today();

// Creation functions
time:Utc specificTime = check timeplus:create(2023, 9, 15, 14, 30);
time:Utc timeInZone = check timeplus:createInZone(2023, 9, 15, "UTC", 14, 30);

// Parsing functions
time:Utc fromIso = check timeplus:parseIso8601("2023-09-15T14:30:25.123Z");
time:Utc fromRfc = check timeplus:parseRfc3339("2023-09-15T14:30:25.123+00:00");

// Range and utility functions
boolean inRange = timeplus:isInRange(now, startTime, endTime);
time:Utc clamped = timeplus:clamp(someTime, minTime, maxTime);
time:Utc earliest = timeplus:min([time1, time2, time3]);
time:Utc latest = timeplus:max([time1, time2, time3]);
```

## 🌍 Constants & Formats

### Timezone Constants
```ballerina
// Major timezone constants (60+ available)
string ny = "America/New_York";      // or timeplus:NEW_YORK
string london = "Europe/London";      // or timeplus:LONDON  
string tokyo = "Asia/Tokyo";          // or timeplus:TOKYO
string sydney = "Australia/Sydney";   // or timeplus:SYDNEY
```

### Format Constants
```ballerina
// 20+ predefined format constants
timeplus:ISO_8601              // "yyyy-MM-dd'T'HH:mm:ss.SSSX"
timeplus:RFC_3339              // "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
timeplus:YYYY_MM_DD            // "yyyy-MM-dd"
timeplus:US_COMMON_DATETIME    // "MM/dd/yyyy, hh:mm:ss a"
timeplus:EU_COMMON_DATETIME    // "dd/MM/yyyy HH:mm:ss"
timeplus:SQL_DATETIME          // "yyyy-MM-dd HH:mm:ss.SSS"
timeplus:LOG_TIMESTAMP         // "yyyy-MM-dd HH:mm:ss.SSS"
```

## 🧪 Testing

TimePlus includes comprehensive testing with 113+ test cases covering:

- ✅ **Core functionality** - All public functions tested
- ✅ **Edge cases** - Leap years, month boundaries, timezone transitions
- ✅ **Error handling** - Invalid inputs and error conditions
- ✅ **Integration testing** - Cross-function compatibility
- ✅ **Business logic** - Weekend/weekday scenarios
- ✅ **Format compatibility** - All supported time formats

Run tests:
```bash
bal test
```

## 🤝 Contributing

We welcome contributions! Please see our [Design.md](./Design.md) for implementation details and architecture overview.

### Development Setup
```bash
git clone https://github.com/bal-tips/module-commons-timeplus.git
cd module-commons-timeplus
bal build
bal test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## 🔗 Related Projects

- [ballerina-lang](https://github.com/ballerina-platform/ballerina-lang) - The Ballerina programming language
- [ballerina/time](https://central.ballerina.io/ballerina/time/latest) - Standard Ballerina time module

## 📞 Support

- **Documentation**: See [Design.md](./Design.md) for detailed documentation
- **Issues**: Report bugs and request features via GitHub Issues

---

**TimePlus** - Making time simple, powerful, and intuitive in Ballerina! ⏰✨
