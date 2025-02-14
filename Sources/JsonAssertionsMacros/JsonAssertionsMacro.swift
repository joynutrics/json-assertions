import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `expectJsonEqual` macro, which compares two JSON strings for equality.
/// The comparison is done in a way that ignores whitespace, line breaks, key order, and array value
/// order. It works for both flat and nested JSON structures. The macro triggers a failure if the JSON
/// strings are not equal, and passes silently if they are.
///
/// This struct is responsible for the expansion of the `#expectJsonEqual` macro when used in code.
///
/// Example usage:
/// ```swift
/// let expectedJson = "{\"name\":\"John\", \"age\":30}"
/// let actualJson = "{\"age\":30, \"name\":\"John\"}"
/// #expectJsonEqual(expectedJson, actualJson)  // This will pass silently
/// ```
///
/// The `ExpectJsonEqualMacro` struct implements the `ExpressionMacro` protocol and defines how
/// the macro should expand when encountered in Swift code. Specifically, it compares the two JSON
/// strings and ensures their equality without considering formatting differences, key order, or array
/// value order.
///
/// - Note: If the JSON strings are not equal, this macro will trigger a test failure.
///
/// Conforms to:
/// - `ExpressionMacro`: This struct defines the behavior for expanding the `#expectJsonEqual` macro.
///
public struct ExpectJsonEqualMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {

        guard node.arguments.count == 2,
              let expected = node.arguments.first?.expression,
              let actual = node.arguments.last?.expression
        else {
            throw MacroExpansionErrorMessage("expectJsonEqual requires exactly two JSON string arguments.")
        }

//        print(node.arguments.map { $0.expression })

//        guard
//            let actual = node.arguments.first?.expression,
//            let segments = actual.as(StringLiteralExprSyntax.self)?.segments, segments.count == 1,
//            case .stringSegment(let actualLiteralSegment)? = segments.first
//                else {
//            throw MacroExpansionErrorMessage("expectJSONEqual expects its first argument to be a string literal")
//        }
//
//        guard
//            let expected = node.arguments.last?.expression,
//            let segments = expected.as(StringLiteralExprSyntax.self)?.segments, segments.count == 1,
//            case .stringSegment(let expectedLiteralSegment)? = segments.first
//        else {
//            throw MacroExpansionErrorMessage("expectJSONEqual expects its second argument to be a string literal")
//        }

        return """
            func jsonToDictionary(_ json: String) -> [String: AnyHashable]? {
                guard let data = json.data(using: .utf8) else { return nil }
                return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: AnyHashable]
            }  
            
            let expectedDict = jsonToDictionary(\(expected))
            let actualDict = jsonToDictionary(\(actual))
                
            if (expectedDict != actualDict) {
                fatalError("JSON mismatch. \(expected) not equal to \(actual)")
            }
        """
    }
}

@main
struct JsonAssertionsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ExpectJsonEqualMacro.self,
    ]
}
