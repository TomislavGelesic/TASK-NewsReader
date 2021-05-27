
import Foundation
import Alamofire
import Combine

public class RestManager {
    private static let manager: Alamofire.Session = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
    
    static func requestObservable<T: Codable>(url: String) -> AnyPublisher<Result<T, ErrorType>, Never> {
        return Future<Result<T, ErrorType>, Never> { promise in
            AF.request(url)
                .validate()
                .responseData(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        if let decodedObject: T = SerializationManager.parseData(jsonData: value) {
                            if let array = decodedObject as? [AnyObject],
                               array.isEmpty {
                                promise(.success(.failure(.recoverable)))
                            }
                            promise(.success(.success(decodedObject)))
                        } else {
                            promise(.success(.failure(.general)))
                        }
                        
                    case .failure(let error):
                        if let underlyingError = error.underlyingError {
                            if let urlError = underlyingError as? URLError {
                                switch urlError.code {
                                case .timedOut, .notConnectedToInternet, .networkConnectionLost:
                                    promise(.success(.failure(.noInternet)))
                                case .cannotDecodeRawData, .cannotDecodeContentData:
                                    promise(.success(.failure(.general)))
                                default: break
                                }
                            }
                        }
                        if let responseCode = error.responseCode,
                           responseCode == 400 {
                            promise(.success(.failure(.recoverable)))
                        }
                    }
                })
        }.eraseToAnyPublisher()
    }
}
