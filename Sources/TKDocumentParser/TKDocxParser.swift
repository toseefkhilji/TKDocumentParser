//
//  TKDocxParser.swift
//  TKDocParser
//
//  Created by Toseef on 19/07/24.
//

import Foundation
import ZIPFoundation
import SwiftyXMLParser

/// A parser for extracting text from DOCX documents.
///
/// Conforms to the `TextParsable` protocol, providing functionality to parse and extract text from DOCX files.
class TKDocxParser: TextParsable {

    /// Extracts text from a DOCX document located at the specified URL.
    /// - Parameter url: The URL of the DOCX file to parse.
    /// - Returns: The extracted text from the DOCX document.
    /// - Throws: `TextParsingError.parseError` if there is an issue unzipping the file or parsing XML.
    ///           `TextParsingError.fileNotFound` if the `document.xml` file cannot be found.
    static func parseText(from url: URL) throws -> String {
        do {
            // Unzip the DOCX file to a temporary directory.
            let fileManager = FileManager.default
            let tempDirectoryURL = fileManager.temporaryDirectory.appendingPathComponent(UUID().uuidString)
            try fileManager.createDirectory(at: tempDirectoryURL, withIntermediateDirectories: true, attributes: nil)

            do {
                try fileManager.unzipItem(at: url, to: tempDirectoryURL)
            } catch {
                throw TextParsingError.parseError("Failed to unzip DOCX file.")
            }

            // Locate and read the document.xml file within the unzipped contents.
            let documentXMLURL = tempDirectoryURL.appendingPathComponent("word/document.xml")
            let documentXMLData: Data
            do {
                documentXMLData = try Data(contentsOf: documentXMLURL)
            } catch {
                throw TextParsingError.fileNotFound
            }

            // Parse the document.xml file using SwiftyXMLParser.
            let xml = XML.parse(documentXMLData)
            var text = ""
            if let body = xml["w:document"]["w:body"].element {
                text = parseXMLBody(body)
            }

            // Clean up by removing the temporary directory.
            try fileManager.removeItem(at: tempDirectoryURL)

            return text
        } catch {
            // Print error for debugging and rethrow as a parsing error.
            print("Error parsing text from DOCX: \(error)")
            throw TextParsingError.parseError("Failed to parse XML.")
        }
    }

    /// Parses the XML body element to extract text.
    /// - Parameter body: The XML body element containing text elements.
    /// - Returns: The extracted text from the body element.
    private static func parseXMLBody(_ body: XML.Element) -> String {
        var text = ""
        for element in body.childElements {
            if element.name == "w:p" {
                text += parseParagraph(element) + "\n"
            }
        }
        return text
    }

    /// Parses a paragraph XML element to extract text.
    /// - Parameter paragraph: The XML paragraph element containing run elements.
    /// - Returns: The extracted text from the paragraph element.
    private static func parseParagraph(_ paragraph: XML.Element) -> String {
        var text = ""
        for element in paragraph.childElements {
            if element.name == "w:r" {
                text += parseRun(element)
            }
        }
        return text
    }

    /// Parses a run XML element to extract text.
    /// - Parameter run: The XML run element containing text elements.
    /// - Returns: The extracted text from the run element.
    private static func parseRun(_ run: XML.Element) -> String {
        var text = ""
        for element in run.childElements {
            if element.name == "w:t" {
                text += element.text ?? ""
            }
        }
        return text
    }
}
