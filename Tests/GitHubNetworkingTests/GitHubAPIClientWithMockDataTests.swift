//
//  GitHubAPIClientWithMockDataTests.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Testing
@testable import GitHubNetworking

/// A test suite for verifying the functionality of `GitHubAPIClient` using mock data.
///
/// This test suite focuses on testing various scenarios, including successful user and repository fetches,
/// handling of "user not found" errors, and network-related errors. It uses `URLSessionMock` to simulate API responses.
struct GitHubNetworkingTests {
    
    // MARK: - Mock Data
    
    /// A mock JSON response representing a GitHub user.
    ///
    /// This data is used to simulate a successful response from the API when fetching a user.
    let userData = """
    {
        "login": "octocat",
        "avatar_url": "https://github.com/images/error/octocat_happy.gif",
        "name": "The Octocat"
    }
    """.data(using: .utf8)!
    
    // MARK: - Tests

    /// Tests fetching a valid GitHub user.
    ///
    /// This test verifies that the `fetchUser` method correctly retrieves user information when the API responds with valid data.
    /// - Throws: An error if the request or test verification fails.
    @Test
    func testFetchUserSuccess() async throws {
        let mockSession = URLSessionMock(responseData: userData, statusCode: 200)
        let apiClient = GitHubAPIClient(session: mockSession)
        
        // Acción
        let user = try await apiClient.fetchUser(username: "octocat")
        
        // Verificación
        #expect(user.login == "octocat", "El login del usuario no coincide.")
        #expect(user.avatarUrl == "https://github.com/images/error/octocat_happy.gif", "El avatar no es el esperado.")
        #expect(user.name ==  "The Octocat", "El nombre no coincide.")
    }
    
    /// Tests handling of a "user not found" error.
    ///
    /// This test ensures that the `fetchUser` method throws a `GitHubAPIError.userNotFound` error
    /// when the API responds with a 404 status code.
    @Test
    func testFetchUserNotFound() async {
        let mockSession = URLSessionMock(responseData: nil, statusCode: 404)
        let apiClient = GitHubAPIClient(session: mockSession)

        do {
            _ = try await apiClient.fetchUser(username: "nonexistent")
            Issue.record("Se esperaba un error, pero no fue lanzado.")
        } catch {
            #expect(error as? GitHubAPIError == GitHubAPIError.userNotFound, "El error no coincide con 'userNotFound'.")
        }
    }
    
    /// Tests handling of a "repositories not found" error.
    ///
    /// This test ensures that the `fetchRepositories` method throws a `GitHubAPIError.userNotFound` error
    /// when the API responds with a 404 status code.
    @Test
    func testFetchRepositoriesNotFound() async {
        let mockSession = URLSessionMock(responseData: nil, statusCode: 404)
        let apiClient = GitHubAPIClient(session: mockSession)

        do {
            _ = try await apiClient.fetchRepositories(username: "nonexistent")
            Issue.record("Se esperaba un error, pero no fue lanzado.")
        } catch {
            #expect(error as? GitHubAPIError == .userNotFound, "El error no coincide con 'userNotFound'.")
        }
    }

    /// Tests handling of a network-related error.
    ///
    /// This test ensures that the `fetchUser` method throws a `GitHubAPIError.networkError` error
    /// when the API responds with a 500 status code.
    @Test
    func testFetchNetworkError() async {
        let mockSession = URLSessionMock(responseData: nil, statusCode: 500)
        let apiClient = GitHubAPIClient(session: mockSession)

        do {
            _ = try await apiClient.fetchUser(username: "nonexistent")
            Issue.record("Se esperaba un error, pero no fue lanzado.")
        } catch {
            #expect(error as? GitHubAPIError == .networkError, "El error no coincide con 'networkError'.")
        }
    }
}





