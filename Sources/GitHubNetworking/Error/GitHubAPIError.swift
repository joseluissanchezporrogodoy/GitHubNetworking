//
//  GitHubAPIError.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Foundation

/// An enumeration that represents the possible errors that can occur when interacting with the GitHub API.
public enum GitHubAPIError: Error, LocalizedError {
    
    /// Indicates that the requested user was not found.
    case userNotFound
    
    /// Indicates a network-related issue occurred during the API request.
    case networkError
    
    /// Indicates that the response from the server could not be decoded.
    case decodingError
    
    /// A localized description of the error.
    /// - Returns: A user-friendly error message describing the issue.
    public var errorDescription: String {
        switch self {
        case .userNotFound:
            /// Error description when the user is not found.
            return "User not found. Please enter another name."
        case .networkError:
            /// Error description for network-related issues.
            return "A network error has occurred. Check your Internet connection and try again later."
        case .decodingError:
            /// Error description for decoding failures.
            return "Failed to decode the response from the server."
        }
    }
}
