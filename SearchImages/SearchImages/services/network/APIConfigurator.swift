//
//  APIConfigurator.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

//protocol that uses NetworkManager and parses data with the help of DecodableService
protocol APIConfigurator {
    var method: HTTPMethod { get }
    var path: String { get }
    var query: Parameters? { get }
    var timeInterval: TimeInterval { get }
}

extension APIConfigurator {
    
    var timeInterval: TimeInterval {
        return 60
    }
    
    private var request: Request? {
        return Request(path: path, httpMethod: method, timeInterval: timeInterval, with: query)
    }
    
    func decodeOne<Entity: Codable>(success:@escaping((Entity)->()), fail:@escaping(responseErrorHandler)){
        guard let request = request else {
            return
        }
        
        NetworkManager(request: request).callRequest(success: { data in
            DecodableService.shared.decodeOne(data: data, success: success, fail: fail)
        }, fail: fail)
    }
}
