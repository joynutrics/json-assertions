import JsonAssertions

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

#expectJsonEqual(expectedJson, actualJson)

