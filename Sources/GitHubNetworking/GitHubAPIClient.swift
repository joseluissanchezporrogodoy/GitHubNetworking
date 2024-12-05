//
//  GitHubAPIClient.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Foundation


/// A concrete implementation of the `GitHubAPI` protocol for interacting with the GitHub API.
///
/// This class handles the details of constructing API requests, decoding responses,
/// and validating errors. It abstracts the network logic to be used in the domain layer,
/// enabling clean and testable architecture.
public class GitHubAPIClient: GitHubAPI {
    
    // MARK: - Properties
    
    /// The base URL for GitHub API requests.
    private let baseURL: URL
    
    /// The session used to perform network requests. Defaults to `URLSession.shared`.
    private let urlSession: URLSessionProtocol
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `GitHubAPIClient`.
    ///
    /// - Parameters:
    ///   - baseURL: The base URL for the GitHub API. Defaults to `GitHubAPIConstants.baseURL`.
    ///   - session: The `URLSessionProtocol` implementation for network requests. Defaults to `URLSession.shared`.
    public init(baseURL: String = GitHubAPIConstants.baseURL, session: URLSessionProtocol = URLSession.shared) {
        guard let baseURL = URL(string: baseURL) else {
            fatalError("Invalid base URL")
        }
        self.baseURL = baseURL
        self.urlSession = session
    }
    
    // MARK: - Public Methods
    
    /// Fetches user information from the GitHub API.
    ///
    /// - Parameter username: The username of the GitHub user to fetch.
    /// - Returns: A `User` object containing the user's information.
    /// - Throws: A `GitHubAPIError` if the request fails, such as `.userNotFound` or `.networkError`.
    public func fetchUser(username: String) async throws -> User {
        let url = baseURL.appendingPathComponent(username)
        return try await fetchDecodable(from: url, responseType: User.self)
    }
    
    /// Fetches the repositories of a GitHub user from the API.
    ///
    /// - Parameter username: The username of the GitHub user whose repositories to fetch.
    /// - Returns: An array of `Repository` objects representing the user's repositories.
    /// - Throws: A `GitHubAPIError` if the request fails, such as `.userNotFound` or `.networkError`.
    public func fetchRepositories(username: String) async throws -> [Repository] {
        let url = baseURL.appendingPathComponent("\(username)/\(GitHubAPIConstants.repositoriesPath)")
        return try await fetchDecodable(from: url, responseType: [Repository].self)
    }
    
    // MARK: - Private Helpers

    /// Fetches and decodes data from the given URL.
    ///
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - responseType: The type of the object to decode the response into.
    /// - Returns: An object of type `T` decoded from the response data.
    /// - Throws: A `GitHubAPIError` if the request fails or decoding fails.
    private func fetchDecodable<T: Decodable>(from url: URL, responseType: T.Type) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)
        try validateResponse(response)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw GitHubAPIError.decodingError
        }
    }
    
    /// Validates the HTTP response for errors.
    ///
    /// - Parameter response: The `URLResponse` to validate.
    /// - Throws: A `GitHubAPIError` if the response is invalid or contains an error status code.
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw GitHubAPIError.networkError
        }
        switch httpResponse.statusCode {
        case 200:
            return
        case 404:
            throw GitHubAPIError.userNotFound
        default:
            throw GitHubAPIError.networkError
        }
    }
}
