//
//  TKPDFParser.swift
//  TKDocParser
//
//  Created by Toseef on 19/07/24.
//

import Foundation
import PDFKit

/// A parser for extracting text from PDF documents.
///
/// Conforms to the `TextParsable` protocol, providing functionality to parse and extract text from PDF files.
class TKPDFParser: TextParsable {

    /// Extracts text from a PDF document located at the specified URL.
    /// - Parameter url: The URL of the PDF file to parse.
    /// - Returns: The extracted text from the PDF document.
    /// - Throws: `TextParsingError.fileNotFound` if the PDF document cannot be loaded.
    ///           `TextParsingError.invalidFile` if a page in the PDF cannot be accessed.
    static func parseText(from url: URL) throws -> String {
        // Attempt to load the PDF document from the given URL.
        guard let pdfDocument = PDFDocument(url: url) else {
            throw TextParsingError.fileNotFound
        }

        // Initialize an empty string to accumulate text from all pages.
        var text = ""

        // Iterate through each page in the PDF document.
        let pageCount = pdfDocument.pageCount
        for pageIndex in 0..<pageCount {
            // Attempt to access the page at the current index.
            guard let page = pdfDocument.page(at: pageIndex) else {
                throw TextParsingError.invalidFile
            }
            // Append the text of the current page to the accumulated text.
            text += page.string ?? ""
        }

        // Return the accumulated text from all pages.
        return text
    }
}
