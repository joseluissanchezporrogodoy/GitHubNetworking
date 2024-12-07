# GitHubNetworking

GitHubNetworking is a lightweight Swift package designed to interact with the GitHub API. It provides a simple and modular interface for fetching user data and repositories, while adhering to principles like modularity, testability, and dependency injection.

---

## Features

- Fetch detailed user profiles from GitHub.
- Retrieve repositories for a specific user.
- Error handling with clear error types (e.g., network errors, user not found).
- Written in Swift with modern Swift concurrency (`async/await`).
- Adheres to the **MVVM** architecture for easy integration.
- Designed with **SOLID principles** to ensure scalability and testability.

---

## Installation

### Using Swift Package Manager (SPM)

To integrate `GitHubNetworking` into your project, add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-repo/GitHubNetworking.git", from: "1.0.0")
]
```
## Error Handling

The package uses a `GitHubAPIError` enum to manage common errors:

- `.networkError`: Indicates a failure in network connectivity.
- `.userNotFound`: Indicates that the user does not exist.
- `.unknown`: A fallback for unexpected issues.

### Example

```swift
do {
    let user = try await apiClient.fetchUser(username: "invalidUser")
} catch let error as GitHubAPIError {
    switch error {
    case .userNotFound:
        print("The user was not found.")
    case .networkError:
        print("Please check your internet connection.")
    default:
        print("An unknown error occurred.")
    }
}
```
---

## Testing

### Unit Tests

The package includes unit tests (written in swift testing) for all major functionalities. Mocks are used for testing network requests without making actual API calls. 

### Example Test

```swift
import Testing
@testable import GitHubNetworking

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
}
```
## Contributing

Contributions are welcome! Please follow these steps to contribute to the project:

1. **Fork the Repository**  
   Fork the repository to your GitHub account by clicking the "Fork" button on the top right of the repository page.

2. **Clone the Repository Locally**  
   Clone your forked repository to your local machine:
   ```bash
   git clone https://github.com/your-username/GitHubNetworking.git
   cd GitHubNetworking
    ```
3.	Create a Feature Branch
    Create a new branch to work on your feature or fix:
   	```bash
    git checkout -b feature-name
    ```
4.	Make Your Changes
    Implement your changes in the codebase. Make sure to follow the Swift API design guidelines and write unit tests for any new features or bug fixes.

5.	Commit Your Changes
    Commit your changes with a clear and concise commit message:
	  ```bash
    git add .
    git commit -m "Add feature-name or fix description"
    ```
6.	Push Your Branch
    Push your branch to your forked repository:
    ```bash
    git push origin feature-name
    ```
7.	Open a Pull Request
    Open a Pull Request from your branch to the main repository’s main branch. Include a description of your changes and reference any relevant issues or discussions.

   Guidelines

	•	Ensure your code adheres to the Swift API design guidelines.
	•	Write unit tests for new features or bug fixes.
	•	Keep your changes focused and avoid including unrelated modifications.
	•	Follow a clear and concise commit message format.
	•	Check that your code passes all tests before submitting.
	•	Be respectful and constructive in code reviews and discussions.

---
Roadmap

  -	Add support for additional GitHub API endpoints.
  -	Improve error handling for rate limits and authentication.
  -	Expand documentation with more examples.
 ---
 
 License
  
  GitHubNetworking is released under the MIT License.
---

   
