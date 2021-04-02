//
//  NetworkManager.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest(request: Request, success:@escaping(responseSuccessHandler), fail:@escaping(responseErrorHandler)) {
        execute(request: request, success: success, fail: fail)
    }
    
    private func execute(request: Request, success:@escaping(responseSuccessHandler), fail:@escaping(responseErrorHandler)) {
        send(request: request, completionHandler: { (data, response, error) in
            do {
                print("Request: \(request.request.url?.absoluteString ?? "")")
                let (_data, _response, _status, message) = try self.validateResponse(data: data, response: response, error: error)
                try self.handlerResponseStatus(status: _status, response: _response, message: message)
                DispatchQueue.main.async {
                    success(_data)
                }
            } catch {
                DispatchQueue.main.async {
                    fail(error)
                }
            }
        })
    }
    
    private func validateResponse(data: Data?, response: URLResponse?, error: Error?) throws -> (data: Data, response: HTTPURLResponse, status: ResponseStatus, message: String?){
        if let _error = error {
            if (_error as NSError).code == NSURLErrorNotConnectedToInternet{
                throw APIError.NoInternetConnection
            } else if (_error as NSError).code == NSURLErrorTimedOut {
                throw APIError.ServerTimeout
            }
            throw APIError.ServerUnavailable
        }
        
        guard let _data = data, let _response = response as? HTTPURLResponse else {
            throw APIError.Unexpected(message: nil)
        }
        let message = ((try? JSONDecoder().decode(ServerError.self, from: _data).error_description) ?? (try? JSONDecoder().decode(ServerMesage.self, from: _data).message)) ?? String(data: _data, encoding: String.Encoding.utf8)
        print("ResponseStatus: \(_response.statusCode))")
        guard let status = ResponseStatus(rawValue: _response.statusCode) else {
            throw APIError.Unexpected(message: nil)
        }
        return (_data, _response, status, message)
    }
    
    private func handlerResponseStatus(status: ResponseStatus, response: HTTPURLResponse, message: String?) throws{
        switch status {
        case .OK, .NoContent:
            return
        case .BAD_REQUEST:
            throw APIError.BadRequest(message: message)
        case .NOT_FOUND:
            throw APIError.NotFound(message: message)
        }
    }
    
    private func send(request: Request, completionHandler:@escaping(responseHandler)){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request.request, completionHandler: completionHandler)
        task.resume()
    }
}
