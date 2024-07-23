//
//  TKDocParser.swift
//  TKDocumentParser
//
//  Created by Toseef on 19/07/24.
//

import Foundation
//import UIKit

class TKDocParser: TextParsable {
    static func parseText(from url: URL) throws -> String {
        throw TextParsingError.parseError("DOC files are not natively supported. Please convert to DOCX or use a third-party service.")
    }
}
