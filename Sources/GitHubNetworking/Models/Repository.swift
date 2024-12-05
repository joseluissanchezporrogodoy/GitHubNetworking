//
//  Repository.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Foundation

/// A simplified representation of a GitHub repository.
///
/// This struct is intentionally designed with only the essential fields required for the application's functionality.
/// The API's full data transfer object (DTO) contains additional parameters, but they have been omitted to streamline development and focus on relevant data for this project.
public struct Repository: Codable, Sendable {
    
    /// The name of the repository.
    public let name: String
    
    /// The primary programming language used in the repository, if available.
    public let language: String?
    
    public init(name: String, language: String? = nil) {
            self.name = name
            self.language = language
    }
    
}
