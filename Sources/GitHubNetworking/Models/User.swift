//
//  User.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Foundation

/// A simplified representation of a GitHub user.
///
/// This struct is designed to include only the essential fields required for the application's functionality.
/// Additional fields provided by the API are intentionally omitted to streamline the development process.
public struct User: Codable, Sendable {
    
    /// The username of the GitHub user.
    public let login: String
    
    /// The URL of the user's avatar image, if available.
    public let avatarUrl: String?
    
    /// The full name of the GitHub user, if provided.
    public let name: String?
    
    public init(login: String, avatarUrl: String? = nil, name: String? = nil) {
            self.login = login
            self.avatarUrl = avatarUrl
            self.name = name
    }
    
    /// Coding keys to map the JSON response to the `User` struct properties.
    /// - Note: The keys are mapped to match the API's response format.
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
    }
    
    
}
