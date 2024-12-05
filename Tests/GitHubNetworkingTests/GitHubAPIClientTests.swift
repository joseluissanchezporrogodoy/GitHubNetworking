//
//  Untitled.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//

import Testing
@testable import GitHubNetworking


/// A test suite for verifying the functionality of the `GitHubAPIClient` class.
///
/// These tests cover various scenarios, including successful responses for fetching users and repositories,
/// as well as handling errors for non-existent users.
struct GitHubAPIClientTests {
    
    // MARK: - Properties
    
    /// The `GitHubAPIClient` instance being tested.
    private var apiClient: GitHubAPIClient!
    
    // MARK: - Initialization
    
    /// Initializes the test suite by configuring the `apiClient`.
    ///
    /// This is equivalent to the `setUp` method in traditional XCTest frameworks.
    init() {
        // Configuración inicial (equivalente a setUp en XCTest)
        apiClient = GitHubAPIClient()
    }
    
    // MARK: - Tests

   /// Tests fetching a valid GitHub user.
   ///
   /// This test verifies that the API correctly retrieves a user given a valid username.
   /// - Throws: An error if the test encounters unexpected failures.
    @Test
    func testFetchUserSuccess() async throws {
        
        let username = "joseluissanchezporrogodoy"
        
        do {
            let user = try await apiClient.fetchUser(username: username)
    
            assert(user.login == username, "El nombre de usuario no coincide.")
            assert(user.avatarUrl != nil, "El avatar debería estar definido.")
        } catch {
            Issue.record("La solicitud falló con error: \(error)")
        }
    }
    
    /// Tests fetching repositories for a valid GitHub user.
    ///
    /// This test ensures that the API retrieves repositories for a given username and validates their details.
    /// - Throws: An error if the test encounters unexpected failures.
    @Test
    func testFetchRepositoriesSuccess() async throws {
        
        let username = "octocat"
        
        do {
            let repositories = try await apiClient.fetchRepositories(username: username)
            
            // Validaciones básicas
            assert(!repositories.isEmpty, "El usuario debería tener repositorios.")
            assert(repositories.first?.name != nil, "El repositorio debería tener un nombre.")
        } catch {
            Issue.record("La solicitud falló con error: \(error)")
        }
    }
    
    /// Tests the response for a non-existent GitHub user.
    ///
    /// This test verifies that the API throws a `userNotFound` error when attempting to fetch details for a non-existent user.
    /// - Throws: An error if the test encounters unexpected failures.
    @Test
    func testFetchNonExistentUser() async throws {
       
        let username = "this_user_should_not_exist_12345"
        
        do {
            _ = try await apiClient.fetchUser(username: username)
            Issue.record("La solicitud debería fallar para un usuario inexistente.")
        } catch GitHubAPIError.userNotFound {
            assert(true, GitHubAPIError.userNotFound.errorDescription)
        } catch {
            Issue.record("Se recibió un error inesperado: \(error)")
        }
    }
    
    /// Tests fetching repositories for a non-existent GitHub user.
    ///
    /// This test ensures that the API throws a `userNotFound` error when attempting to retrieve repositories for a non-existent user.
    /// - Throws: An error if the test encounters unexpected failures.
    @Test
    func testFetchRepositoriesForNonExistentUser() async throws {
       
        let username = "this_user_should_not_exist_12345"
        
        do {
            _ = try await apiClient.fetchRepositories(username: username)
            Issue.record("La solicitud debería fallar para un usuario inexistente.")
        } catch GitHubAPIError.userNotFound {
            assert(true, GitHubAPIError.userNotFound.errorDescription)
        } catch {
            Issue.record("Se recibió un error inesperado: \(error)")
        }
    }
}
