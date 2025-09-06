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
function testFromJsTimestamp() returns error? {
    // Test JavaScript epoch (January 1, 1970, 00:00:00 UTC)
    time:Utc epoch = check fromJsTimestamp(0.0d);
    time:Utc expectedEpoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    test:assertEquals(epoch, expectedEpoch, "JavaScript epoch should be 1970-01-01T00:00:00.000Z");
    
    // Test a known timestamp: 1609459200000 = January 1, 2021, 00:00:00 UTC
    time:Utc time2021 = check fromJsTimestamp(1609459200000.0d);
    time:Utc expected2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    test:assertEquals(time2021, expected2021, "JavaScript timestamp 1609459200000 should be 2021-01-01T00:00:00.000Z");
    
    // Test with milliseconds precision: 1609459200123 = January 1, 2021, 00:00:00.123 UTC
    time:Utc timeWithMs = check fromJsTimestamp(1609459200123.0d);
    time:Utc expectedWithMs = check time:utcFromString("2021-01-01T00:00:00.123Z");
    test:assertEquals(timeWithMs, expectedWithMs, "JavaScript timestamp with milliseconds should preserve precision");
    
    // Test negative timestamp (before epoch): -86400000 = December 31, 1969, 00:00:00 UTC
    time:Utc preEpoch = check fromJsTimestamp(-86400000.0d);
    time:Utc expectedPreEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    test:assertEquals(preEpoch, expectedPreEpoch, "Negative JavaScript timestamp should work for pre-epoch dates");
}

@test:Config {}
function testToJsTimestamp() returns error? {
    // Test JavaScript epoch
    time:Utc epoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    decimal jsEpoch = check toJsTimestamp(epoch);
    test:assertEquals(jsEpoch, 0.0d, "1970-01-01T00:00:00.000Z should be JavaScript timestamp 0");
    
    // Test a known date: January 1, 2021, 00:00:00 UTC = 1609459200000
    time:Utc time2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    decimal js2021 = check toJsTimestamp(time2021);
    test:assertEquals(js2021, 1609459200000.0d, "2021-01-01T00:00:00.000Z should be JavaScript timestamp 1609459200000");
    
    // Test with milliseconds: January 1, 2021, 00:00:00.123 UTC = 1609459200123
    time:Utc timeWithMs = check time:utcFromString("2021-01-01T00:00:00.123Z");
    decimal jsWithMs = check toJsTimestamp(timeWithMs);
    test:assertEquals(jsWithMs, 1609459200123.0d, "Milliseconds precision should be preserved");
    
    // Test pre-epoch date: December 31, 1969, 00:00:00 UTC = -86400000
    time:Utc preEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    decimal jsPreEpoch = check toJsTimestamp(preEpoch);
    test:assertEquals(jsPreEpoch, -86400000.0d, "Pre-epoch dates should have negative timestamps");
}

@test:Config {}
function testJsTimestampRoundTrip() returns error? {
    // Test round-trip conversion: timestamp -> UTC -> timestamp
    decimal originalJs = 1609459200123.456d; // with fractional milliseconds
    time:Utc utcTime = check fromJsTimestamp(originalJs);
    decimal backToJs = check toJsTimestamp(utcTime);
    
    // Allow small precision differences due to decimal/time conversions
    decimal difference = (originalJs - backToJs) < 0.0d ? (backToJs - originalJs) : (originalJs - backToJs);
    test:assertTrue(difference < 1.0d, "Round-trip JavaScript timestamp conversion should preserve accuracy within 1ms");
}

@test:Config {}
function testFromPythonTimestamp() returns error? {
    // Test Python epoch (January 1, 1970, 00:00:00 UTC)
    time:Utc epoch = check fromPythonTimestamp(0.0d);
    time:Utc expectedEpoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    test:assertEquals(epoch, expectedEpoch, "Python epoch should be 1970-01-01T00:00:00.000Z");
    
    // Test a known timestamp: 1609459200 = January 1, 2021, 00:00:00 UTC
    time:Utc time2021 = check fromPythonTimestamp(1609459200.0d);
    time:Utc expected2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    test:assertEquals(time2021, expected2021, "Python timestamp 1609459200 should be 2021-01-01T00:00:00.000Z");
    
    // Test with fractional seconds: 1609459200.123 = January 1, 2021, 00:00:00.123 UTC
    time:Utc timeWithFraction = check fromPythonTimestamp(1609459200.123d);
    time:Utc expectedWithFraction = check time:utcFromString("2021-01-01T00:00:00.123Z");
    test:assertEquals(timeWithFraction, expectedWithFraction, "Python timestamp with fractional seconds should preserve precision");
    
    // Test negative timestamp: -86400 = December 31, 1969, 00:00:00 UTC
    time:Utc preEpoch = check fromPythonTimestamp(-86400.0d);
    time:Utc expectedPreEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    test:assertEquals(preEpoch, expectedPreEpoch, "Negative Python timestamp should work for pre-epoch dates");
}

@test:Config {}
function testToPythonTimestamp() returns error? {
    // Test Python epoch
    time:Utc epoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    decimal pythonEpoch = check toPythonTimestamp(epoch);
    test:assertEquals(pythonEpoch, 0.0d, "1970-01-01T00:00:00.000Z should be Python timestamp 0");
    
    // Test a known date: January 1, 2021, 00:00:00 UTC = 1609459200
    time:Utc time2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    decimal python2021 = check toPythonTimestamp(time2021);
    test:assertEquals(python2021, 1609459200.0d, "2021-01-01T00:00:00.000Z should be Python timestamp 1609459200");
    
    // Test with fractional seconds: January 1, 2021, 00:00:00.123 UTC = 1609459200.123
    time:Utc timeWithFraction = check time:utcFromString("2021-01-01T00:00:00.123Z");
    decimal pythonWithFraction = check toPythonTimestamp(timeWithFraction);
    test:assertEquals(pythonWithFraction, 1609459200.123d, "Fractional seconds precision should be preserved");
    
    // Test pre-epoch date: December 31, 1969, 00:00:00 UTC = -86400
    time:Utc preEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    decimal pythonPreEpoch = check toPythonTimestamp(preEpoch);
    test:assertEquals(pythonPreEpoch, -86400.0d, "Pre-epoch dates should have negative timestamps");
}

@test:Config {}
function testPythonTimestampRoundTrip() returns error? {
    // Test round-trip conversion: timestamp -> UTC -> timestamp
    decimal originalPython = 1609459200.123456d; // with high precision
    time:Utc utcTime = check fromPythonTimestamp(originalPython);
    decimal backToPython = check toPythonTimestamp(utcTime);
    
    // Allow small precision differences due to decimal/time conversions
    decimal difference = (originalPython - backToPython) < 0.0d ? (backToPython - originalPython) : (originalPython - backToPython);
    test:assertTrue(difference < 0.001d, "Round-trip Python timestamp conversion should preserve accuracy within 1ms");
}

@test:Config {}
function testFromUnixTimestamp() returns error? {
    // Test Unix epoch (January 1, 1970, 00:00:00 UTC)
    time:Utc epoch = check fromUnixTimestamp(0);
    time:Utc expectedEpoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    test:assertEquals(epoch, expectedEpoch, "Unix epoch should be 1970-01-01T00:00:00.000Z");
    
    // Test a known timestamp: 1609459200 = January 1, 2021, 00:00:00 UTC
    time:Utc time2021 = check fromUnixTimestamp(1609459200);
    time:Utc expected2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    test:assertEquals(time2021, expected2021, "Unix timestamp 1609459200 should be 2021-01-01T00:00:00.000Z");
    
    // Test negative timestamp: -86400 = December 31, 1969, 00:00:00 UTC
    time:Utc preEpoch = check fromUnixTimestamp(-86400);
    time:Utc expectedPreEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    test:assertEquals(preEpoch, expectedPreEpoch, "Negative Unix timestamp should work for pre-epoch dates");
    
    // Test large timestamp: 2147483647 = January 19, 2038 (near 32-bit limit)
    time:Utc futureTime = check fromUnixTimestamp(2147483647);
    time:Utc expectedFutureTime = check time:utcFromString("2038-01-19T03:14:07.000Z");
    test:assertEquals(futureTime, expectedFutureTime, "Large Unix timestamp should work correctly");
}

@test:Config {}
function testToUnixTimestamp() returns error? {
    // Test Unix epoch
    time:Utc epoch = check time:utcFromString("1970-01-01T00:00:00.000Z");
    int unixEpoch = check toUnixTimestamp(epoch);
    test:assertEquals(unixEpoch, 0, "1970-01-01T00:00:00.000Z should be Unix timestamp 0");
    
    // Test a known date: January 1, 2021, 00:00:00 UTC = 1609459200
    time:Utc time2021 = check time:utcFromString("2021-01-01T00:00:00.000Z");
    int unix2021 = check toUnixTimestamp(time2021);
    test:assertEquals(unix2021, 1609459200, "2021-01-01T00:00:00.000Z should be Unix timestamp 1609459200");
    
    // Test with fractional seconds (should be truncated)
    time:Utc timeWithFraction = check time:utcFromString("2021-01-01T00:00:00.999Z");
    int unixWithFraction = check toUnixTimestamp(timeWithFraction);
    test:assertEquals(unixWithFraction, 1609459200, "Fractional seconds should be truncated in Unix timestamp");
    
    // Test pre-epoch date: December 31, 1969, 00:00:00 UTC = -86400
    time:Utc preEpoch = check time:utcFromString("1969-12-31T00:00:00.000Z");
    int unixPreEpoch = check toUnixTimestamp(preEpoch);
    test:assertEquals(unixPreEpoch, -86400, "Pre-epoch dates should have negative Unix timestamps");
    
    // Test large timestamp: January 19, 2038, 03:14:07 UTC = 2147483647
    time:Utc futureTime = check time:utcFromString("2038-01-19T03:14:07.000Z");
    int unixFutureTime = check toUnixTimestamp(futureTime);
    test:assertEquals(unixFutureTime, 2147483647, "Large Unix timestamp should work correctly");
}

@test:Config {}
function testUnixTimestampRoundTrip() returns error? {
    // Test round-trip conversion: timestamp -> UTC -> timestamp
    int originalUnix = 1609459200;
    time:Utc utcTime = check fromUnixTimestamp(originalUnix);
    int backToUnix = check toUnixTimestamp(utcTime);
    test:assertEquals(backToUnix, originalUnix, "Round-trip Unix timestamp conversion should be exact");
    
    // Test with negative timestamp
    int negativeUnix = -86400;
    time:Utc utcTimeNeg = check fromUnixTimestamp(negativeUnix);
    int backToUnixNeg = check toUnixTimestamp(utcTimeNeg);
    test:assertEquals(backToUnixNeg, negativeUnix, "Round-trip conversion should work with negative timestamps");
}

@test:Config {}
function testCrossCompatibilityTimestamps() returns error? {
    // Test compatibility between different timestamp formats
    
    // Use a known time: January 1, 2021, 00:00:00.000 UTC
    time:Utc referenceTime = check time:utcFromString("2021-01-01T00:00:00.000Z");
    
    // Convert to all formats
    decimal jsTimestamp = check toJsTimestamp(referenceTime);
    decimal pythonTimestamp = check toPythonTimestamp(referenceTime);
    int unixTimestamp = check toUnixTimestamp(referenceTime);
    
    // Verify relationships
    test:assertEquals(jsTimestamp, 1609459200000.0d, "JavaScript timestamp should be correct");
    test:assertEquals(pythonTimestamp, 1609459200.0d, "Python timestamp should be correct");
    test:assertEquals(unixTimestamp, 1609459200, "Unix timestamp should be correct");
    
    // Verify mathematical relationships
    test:assertEquals(jsTimestamp / 1000.0d, pythonTimestamp, "JavaScript timestamp / 1000 should equal Python timestamp");
    test:assertEquals(<int>pythonTimestamp, unixTimestamp, "Python timestamp (as int) should equal Unix timestamp");
    
    // Convert back from all formats and verify they're the same
    time:Utc fromJs = check fromJsTimestamp(jsTimestamp);
    time:Utc fromPython = check fromPythonTimestamp(pythonTimestamp);
    time:Utc fromUnix = check fromUnixTimestamp(unixTimestamp);
    
    test:assertEquals(fromJs, referenceTime, "Conversion from JavaScript timestamp should match reference");
    test:assertEquals(fromPython, referenceTime, "Conversion from Python timestamp should match reference");
    test:assertEquals(fromUnix, referenceTime, "Conversion from Unix timestamp should match reference");
}

@test:Config {}
function testTimestampEdgeCases() returns error? {
    // Test edge cases and boundary conditions
    
    // Test very small positive timestamp
    decimal smallJs = 1.0d; // 1 millisecond after epoch
    time:Utc smallTime = check fromJsTimestamp(smallJs);
    decimal backToSmall = check toJsTimestamp(smallTime);
    test:assertTrue((backToSmall - smallJs) < 1.0d, "Small timestamp should be handled accurately");
    
    // Test zero with different types
    time:Utc epochFromJs = check fromJsTimestamp(0.0d);
    time:Utc epochFromPython = check fromPythonTimestamp(0.0d);
    time:Utc epochFromUnix = check fromUnixTimestamp(0);
    
    test:assertEquals(epochFromJs, epochFromPython, "All epoch conversions should be identical");
    test:assertEquals(epochFromPython, epochFromUnix, "All epoch conversions should be identical");
    test:assertEquals(epochFromJs, epochFromUnix, "All epoch conversions should be identical");
    
    // Test precision limits
    decimal highPrecisionPython = 1609459200.999999d;
    time:Utc highPrecisionTime = check fromPythonTimestamp(highPrecisionPython);
    decimal backToHighPrecision = check toPythonTimestamp(highPrecisionTime);
    
    // Should maintain reasonable precision (within microsecond)
    decimal precisionDiff = (highPrecisionPython - backToHighPrecision) < 0.0d ? 
        (backToHighPrecision - highPrecisionPython) : (highPrecisionPython - backToHighPrecision);
    test:assertTrue(precisionDiff < 0.000001d, "High precision timestamps should be handled accurately");
}
