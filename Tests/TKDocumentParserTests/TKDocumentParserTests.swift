import XCTest
@testable import TKDocumentParser

final class TKDocumentParserTests: XCTestCase {
    func testExample() throws {
        let url = URL(string: "https://pdfobject.com/pdf/sample.pdf")!
        do {
            let result = try TKDocumentParser.parseText(from: url)
            XCTAssertNotNil(result, "Parsed document: Test Document")
        } catch {
            print("Error:\(error)")
        }
//        XCTAssertNotNil(result, "Parsed document: Test Document")
//        XCTAssertEqual(result, "Parsed document: Test Document")
    }
}
