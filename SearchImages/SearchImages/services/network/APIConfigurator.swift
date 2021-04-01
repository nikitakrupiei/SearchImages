//
//  APIConfigurator.swift
//  SearchImages
//
//  Created by admin on 01.04.2021.
//

import Foundation

//protocol that uses NetworkManager and parses data with the help of DecodableService
protocol APIConfigurator: NetworkManager {}

extension APIConfigurator {
    func decodeMany<Entity: Codable>(success:@escaping((Entity)->()), fail:@escaping(responseErrorHandler)){
        self.callRequest(success: { data in
            
        }, fail: fail)
    }
}
