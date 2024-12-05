//
//  GitHubAPIConstants.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

/// A utility struct that contains constants used for GitHub API requests.
///
/// This struct centralizes configuration details for the GitHub API, ensuring consistency across the application.
/// The constants defined here help simplify URL construction and improve maintainability.
public struct GitHubAPIConstants {
    /// The base URL for GitHub API requests.
    ///
    /// This URL is used as the foundation for all API calls to GitHub's user-related endpoints.
    /// Example: `https://api.github.com/users/`
    public static let baseURL = "https://api.github.com/users/"
    
    /// The path for fetching repositories associated with a GitHub user.
    ///
    /// This path is appended to the base URL to retrieve a user's repositories.
    /// Example: `repos`
    public static let repositoriesPath = "repos"
}
