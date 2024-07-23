//
//  TKDocParser.swift
//  TKDocParser
//
//  Created by Toseef on 19/07/24.
//

import Foundation

/// A parser for handling and extracting text from different document types.
public class TKDocumentParser {

    /// Parses text from a document file located at the specified URL.
    /// - Parameter url: The URL of the document file to parse.
    /// - Returns: The extracted text from the document.
    /// - Throws: `TextParsingError` if the file type is unsupported or if an error occurs during parsing.
    public static func parseText(from url: URL) throws -> String {
        let fileType = determineFileType(from: url)

        // Determine the appropriate parser based on the file type
        switch fileType {
        case .pdf:
            return try TKPDFParser.parseText(from: url)  // Parse PDF files
        case .doc:
            return try TKDocParser.parseText(from: url)  // Parse DOC files
        case .docx:
            return try TKDocxParser.parseText(from: url) // Parse DOCX files
        case .unknown:
            throw TextParsingError.parseError("Unsupported file type.") // Handle unsupported file types
        }
    }

    /// Determines the type of the file based on its extension.
    /// - Parameter url: The URL of the file whose type is to be determined.
    /// - Returns: A `FileType` enum representing the file type.
    private static func determineFileType(from url: URL) -> FileType {
        let fileExtension = url.pathExtension.lowercased()

        // Match the file extension to the known types
        switch fileExtension {
        case "pdf":
            return .pdf
        case "doc":
            return .doc
        case "docx":
            return .docx
        default:
            return .unknown
        }
    }
}

/// Enum representing the types of files supported for parsing.
private enum FileType {
    case pdf   // Portable Document Format
    case doc   // Older Microsoft Word document format
    case docx  // Modern Microsoft Word document format
    case unknown // File type that is not supported or recognized
}
