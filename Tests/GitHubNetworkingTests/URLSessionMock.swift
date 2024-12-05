//
//  URLSessionMock.swift
//  GitHubNetworking
//
//  Created by JLSANCHEZP on 4/12/24.
//


import Foundation
@testable import GitHubNetworking


final class URLSessionMock: URLSessionProtocol, @unchecked Sendable {
    private let responseData: Data?
    private let statusCode: Int

    init(responseData: Data?, statusCode: Int) {
        self.responseData = responseData
        self.statusCode = statusCode
    }

    func data(from url: URL) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        return (responseData ?? Data(), response)
    }
}
