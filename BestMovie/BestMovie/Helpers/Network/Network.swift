//
//  Network.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation
import Alamofire

enum OnResult<T> {
  case success(T)
  case emptyResponse
  case failure(Error)
}

class Network {
  static func performDecodableRequest<T: Codable>(with endpoint: Endpoint, responseType: T.Type, completion: @escaping (OnResult<T>)->()) {
    AF.request(endpoint.path,
               method: endpoint.method,
               parameters: endpoint.parameters,
               encoding: endpoint.encoding,
               headers: endpoint.headers)
      .validate(statusCode: 200 ... 417)
      .responseData { processDecodableResponse(endpoint: endpoint, response: $0, completion: completion) }
  }
  
  static func processDecodableResponse<T: Codable>(endpoint: Endpoint, response: AFDataResponse<Data>, completion: @escaping (OnResult<T>)->()) {
    switch response.result {
      case .success(let data):
          let log = """
                              \n Date: \(Date())
                              \n ServerBase: \(endpoint.baseUrl)
                              \n ApiVersiont: \(endpoint.version.v)
                              \n Endpoint: \(endpoint.path)
                              \n Params: \(endpoint.parameters ?? [:])
                              \n Method: \(endpoint.method)
                              \n Headers: \(endpoint.headers ?? [:])
                              \n Response \(Date()) \n\(data.prettyPrintedJSONString ?? "")
                              \n
                            """ as NSString
          debugPrint(log)
        do {
          let decoder = APIDecoder()
          let model = try decoder.decode(data: data, of: T.self)
          completion(.success(model))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
    }
  }
}
