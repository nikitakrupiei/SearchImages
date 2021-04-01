//
//  NetworkHelper.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

public typealias Parameters = [String:Any]
typealias responseHandler = (Data?, URLResponse?, Error?) -> Void
typealias responseErrorHandler = (_ response:Error)->()
typealias responseSuccessHandler = (_ data:Data)->()

enum HTTPMethod: String {
    case POST
    case GET
    case DELETE
    case PUT
}

struct ServerMesage: Decodable {
    var message: String

    enum CodingKeys: String, CodingKey{
        case message = "Message"
    }
}

struct ServerError: Decodable {
    var error: String
    var error_description: String
}

enum ResponseStatus: Int {
    case OK = 200
    case NoContent = 204
    case BAD_REQUEST = 400
    case NOT_FOUND = 404
}

enum APIError: Error {
    case NoInternetConnection
    case ServerUnavailable
    case ServerTimeout
    case Unexpected(message: String?)
    case DecodeDataError(message: String)
    case BadRequest(message: String?)
    case NotFound(message: String?)
    
    var local: String {
        switch self {
        case .DecodeDataError(let message):
            return message
        case .NoInternetConnection:
            return "No Internet connection. Please check your network settings or try again later.";
        case .ServerUnavailable:
            return "Server error happened, service unavailable. Please try again later.";
        case .ServerTimeout:
            return "Connection timeout expired. Please check your network settings or try again later.";
        case .Unexpected(let message):
            return message ?? "An unexpected error happened, please, try later";
        case .BadRequest(let message):
            return message ?? "Incorrect request data";
        case .NotFound(let message):
            return message ?? "Not found";
        }
    }
}

struct Request {
    
    var request: URLRequest
    
    init?(path: String, httpMethod: HTTPMethod, timeInterval: TimeInterval, with query: Parameters?){
        
        guard var requestPath = EnvironmentConfiguration.baseApiUrl else {
            return nil
        }
        if let apiVersion = EnvironmentConfiguration.apiVersion {
            requestPath.appendPathComponent(apiVersion)
        }
        requestPath = URL(string: requestPath.absoluteString)?.appendingPathComponent(path) ?? requestPath
        var baseRequest = URLRequest(url: requestPath, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeInterval)
        baseRequest.httpMethod = httpMethod.rawValue
        
        if let query = query {
            baseRequest.encodeParameters(parameters: query)
        }
        
        self.request = baseRequest
    }
    
}

extension URLRequest {
    mutating func encodeParameters(parameters: Parameters) {
        guard let url = self.url else { return }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            self.url = urlComponents.url
        }
    }
}
