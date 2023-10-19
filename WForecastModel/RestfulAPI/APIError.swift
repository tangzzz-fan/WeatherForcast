//
//  APIError.swift
//  WForecastModel
//
//  Created by 小苹果 on 2023/10/19.
//

import Foundation

public enum APIErrorCodes: Int {
    case unauthorized = 401
    case forbidden = 403
    case internalServerError = 500
    case conflict = 409
    case notFound = 404
    case accessTokenExpired = 10004
}

public struct APIError: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case errCode = "err_code"
        case errMsg = "err_msg"
        case statusCode
    }
    
    public let errCode: Int
    public let errMsg: String
    public var statusCode: Int?
}

public typealias APIErrorResponse = APIError

extension APIErrorResponse: LocalizedError {
    
    public var errorDescription: String? {
        return errMsg
    }
    
}
