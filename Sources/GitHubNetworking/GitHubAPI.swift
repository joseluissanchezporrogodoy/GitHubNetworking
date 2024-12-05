//
//  GitHubAPI.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

/// A protocol defining the contract for interacting with the GitHub API.
///
/// This protocol abstracts the implementation details of API calls, allowing the domain layer to work with GitHub data
/// without depending on specific network logic or frameworks.
/// By conforming to this protocol, different implementations (e.g., mock or real API clients)
public protocol GitHubAPI {
    
    /// Fetches the details of a GitHub user.
    ///
    /// - Parameter username: The username of the GitHub user to retrieve.
    /// - Returns: A `User` object containing the user's information.
    /// - Throws: An error if the request fails, such as `GitHubAPIError.userNotFound` or `GitHubAPIError.networkError`.
    func fetchUser(username: String) async throws -> User
    
    /// Fetches the repositories associated with a GitHub user.
    ///
    /// - Parameter username: The username of the GitHub user whose repositories are to be retrieved.
    /// - Returns: An array of `Repository` objects representing the user's repositories.
    /// - Throws: An error if the request fails, such as `GitHubAPIError.userNotFound` or `GitHubAPIError.networkError`.
    func fetchRepositories(username: String) async throws -> [Repository]
}
