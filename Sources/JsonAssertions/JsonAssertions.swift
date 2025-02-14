// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A freestanding macro that compares two JSON strings for equality. The comparison
/// is done in a way that ignores whitespace, line breaks, key order, and array value
/// order. It works for both flat and nested JSON structures.
///
/// The macro will trigger a failure if the JSON strings are not equal, and pass silently
/// if they are equal.
///
/// Usage:
/// ```swift
/// #expectJsonEqual(expected, actual)
/// ```
/// where `expected` and `actual` are JSON strings.
///
/// The macro ensures that the two JSON strings are semantically equal, ignoring
/// differences in formatting, key order, and array value order.
///
/// Example:
/// ```swift
/// let expectedJson = "{\"name\":\"John\", \"age\":30}"
/// let actualJson = "{\"age\":30, \"name\":\"John\"}"
/// #expectJsonEqual(expectedJson, actualJson)  // This will pass silently
/// ```
///
/// - Parameters:
///   - expected: A string representing the expected JSON value.
///   - actual: A string representing the actual JSON value.
/// - Note: If the JSON strings are not equal, this macro will trigger a test failure.
@freestanding(expression)
public macro expectJsonEqual(_ expected: String, _ actual: String) = #externalMacro(module: "JsonAssertionsMacros", type: "ExpectJsonEqualMacro")
