# JsonAssertions

`JsonAssertions` is a Swift package designed for unit tests, providing a simple and powerful way to assert the equality of two JSON strings. It includes a macro for comparing JSON strings, which can be extended in the future to support other JSON-related assertions.

The equality check is performed independently of line breaks, spaces, key order (including in nested nodes), and array value order.

## Installation

You can add `JsonAssertions` to your project using Swift Package Manager.

1. Open your project in Xcode.
2. Navigate to **File > Swift Packages > Add Package Dependency**.
3. Enter the repository URL:
```
https://github.com/joynutrics/json-assertions.git
```

4. Follow the prompts to complete the installation.

## Usage

The package currently provides a single assertion macro, `#expectJsonEqual`, to compare two JSON strings in your unit tests.

### Example

```swift
import JsonAssertions
import Testing

struct MyTests {

 @Test
 func testJsonEquality() {
     let expectedJson = """
     {
         "name": "John",
         "age": 30
     }
     """
     
     let actualJson = """
     {
         "age": 30,
         "name": "John"
     }
     """
     
     // Assert that the two JSON strings are equal
     #expectJsonEqual(expectedJson, actualJson)
 }
}
```
In the above example, the `#expectJsonEqual(expected, actual)` macro will compare the two JSON strings (expectedJson and actualJson) and assert that they are equal. The comparison is independent of:
* Line breaks
* White spaces
* Key order (including in nested nodes)
* Array value order

If they are not equal based on these rules, the test will fail.

## Contributing

Feel free to open issues or submit pull requests if you want to improve this package. Contributions are welcome!

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/joynutrics/json-assertions/blob/main/LICENSE) file for more details.
