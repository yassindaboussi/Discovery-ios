//
//  TokenInterceptor.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import Foundation
import Alamofire
class TokenInterceptor: RequestInterceptor {
    private let authToken: String

    init(authToken: String) {
        self.authToken = authToken
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // No retry necessary
        completion(.doNotRetry)
    }
}
