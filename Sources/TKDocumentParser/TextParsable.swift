//
//  TextParsable.swift
//  TKDocParser
//
//  Created by Toseef on 19/07/24.
//

import Foundation

/// A protocol defining the requirements for text parsers.
///
/// Conforming types must implement the `parseText(from:)` method to extract text from a given document URL.
public protocol TextParsable {

    /// Parses text from a document located at the specified URL.
    /// - Parameter url: The URL of the document to parse.
    /// - Returns: The extracted text from the document.
    /// - Throws: An error if parsing fails.
    static func parseText(from url: URL) throws -> String
}

/// Enum representing errors that can occur during text parsing.
///
/// Conforms to the `Error` protocol to be used in `throws` statements.
public enum TextParsingError: Error {
    case fileNotFound // Error indicating the file was not found at the specified URL.
    case invalidFile // Error indicating that the file is not valid or is of an unsupported format.
    case parseError(String) // Error indicating a parsing failure with an associated error message.
}

extension TextParsingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .invalidFile:
            return "invalid File"
        case .parseError(let string):
            return string
        }
    }
}
