//
//  Untitled.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//
import Foundation

/// A protocol that defines an interface for performing network requests.
///
/// This protocol abstracts the `URLSession` class to allow dependency injection
/// and easier testing by mocking network calls.
public protocol URLSessionProtocol {
    
    /// Fetches data from the given URL asynchronously.
    /// - Parameter url: The `URL` to fetch data from.
    /// - Returns: A tuple containing the raw `Data` and the `URLResponse` from the network request.
    /// - Throws: An error if the network request fails.
    func data(from url: URL) async throws -> (Data, URLResponse)
}


/// Conformance of `URLSession` to the `URLSessionProtocol` protocol.
///
/// This extension allows `URLSession` to be used wherever `URLSessionProtocol` is required,
/// enabling testability and flexibility.
extension URLSession: URLSessionProtocol {
    
    /// Fetches data from the given URL asynchronously using a `URLRequest`.
    /// - Parameter url: The `URL` to fetch data from.
    /// - Returns: A tuple containing the raw `Data` and the `URLResponse` from the network request.
    /// - Throws: An error if the network request fails.
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        try await self.data(for: URLRequest(url: url))
    }
}
