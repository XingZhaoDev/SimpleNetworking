//
//  WebService.swift
//  PetAdoption
//
//  Created by Xing Zhao on 2021/10/4.
//

import Foundation
import CoreData
import SwiftUI

public enum NetworkError: Error {
    case badRequest
    case decodingError
}

public class WebService {
    
    public init() { }
    public func fetch<T:Codable>(url: URL, parse: @escaping (Data) -> T?, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.decodingError))
                return
            }
            let result = parse(data)
            completion(.success(result))
        }
    }
}
