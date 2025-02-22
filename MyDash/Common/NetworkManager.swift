//
//  NetworkManager.swift
//  MyDash
//
//  Created by Abhishek on 18/01/25.
//

import Foundation

// MARK: - Custom Errors
enum NetworkError: Error, LocalizedError {
    case badUrl
    case invalidResponse(Int)
    case decodingError(Error)
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "The provided URL is invalid."
        case .invalidResponse(let statusCode):
            return "Invalid server response with status code: \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}


enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            "GET"
        case .post(_):
            "POST"
        case .delete:
            "DELETE"
        }
    }
    
    func configure(request: inout URLRequest) {
        switch self {
        case .get(let queryItems):
            var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            request.url = components?.url
        case .post(_):
            break
        case .delete:
            break
        }
    }
}


struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String]?
    var method: HttpMethod = .get([])
}


class NetworkManager {
    
    func load<T: Codable>(resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        if let resourceHeader = resource.headers {
            for (key, value) in resourceHeader {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        // Set HTTP method and configure the request
        request.httpMethod = resource.method.name
        //        resource.method.configure(request: &request)
        
        // Creating a network session for performing HTTP requests
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        // Perform the network call
        let (data, response) = try await session.data(for: request)
        
        // Validate the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(0)
        }
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse(httpResponse.statusCode)
        }
        
        // Decode the response
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
