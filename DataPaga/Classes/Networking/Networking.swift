//
//  Networking.swift
//  DataPagaTestApp
//
//  Created by Jonathan Solorzano on 1/5/18.
//  https://www.linkedin.com/in/felixsolorzano
//  Copyright © 2018 Elaniin. All rights reserved.
//

import Foundation
import Alamofire

/// Structure for storing server side error messages
struct ErrorResponse: Codable {
    let error: String
}

/// Enum to markup DataPaga's backend response
public enum DataPagaResponse {
    case success(Data)
    case failure(DataPagaException)
}

/// Typealias shortcut for `((DataPagaResponse) -> Void)?`
public typealias RequestCompletion = ((DataPagaResponse) -> Void)?

/// Server wrapper class for handling requests
public class Server {
    
    /// Creates a DataRequest using the default SessionManager to retrieve the contents of the specified url, method, parameters, encoding and headers.
    /// - paramters:
    ///     - endpoint: Endpoint URL
    ///     - method: The HTTP method
    ///     - params: The parameters
    ///     - completionHandler: The request completion handler to execute
    public static func request(_ endpoint: String, method: HTTPMethod, params: Parameters, completionHandler completion: RequestCompletion){
        
        
        Alamofire.request(endpoint, method: method, parameters: params).responseJSON {
            response in
            
            switch response.result {
                
            case .success(_):
                
                let decoder = JSONDecoder()
                
                guard let jsonData = response.data else {
                    return
                }
                
                // Status Code Handling
                guard let statusCode = response.response?.statusCode else {
                    let error = DataPagaException(message: "Invalid response", code: "0")
                    completion?(.failure(error))
                    return
                }
                
                // Failure handling
                guard statusCode >= 200 && statusCode < 300 else {
                    do {
                        let ex = try decoder.decode(DataPagaException.self, from: jsonData)
                        completion?(.failure(ex))
                        
                    } catch {
                        let ex = DataPagaException(message: "Invalid JSON response from error decoding", code: "0")
                        completion?(.failure(ex))
                    }
                    return
                }
                
                // Real success
                completion?(.success(jsonData))
                
            case let .failure(error):
                
                let exception = DataPagaException(message: error.localizedDescription, code: "0")
                completion?(.failure(exception))
            }
        }
    }

}
