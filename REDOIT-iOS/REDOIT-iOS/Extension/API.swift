//
//  API.swift
//  REDOIT-iOS
//
//  Created by 강인혜 on 2023/10/12.
//

import Moya

enum API {
    case uploadInput(data: Data, prompt: String)
}

extension API: BaseAPI {
    typealias ErrorType = DomainErrorType
    
    var baseURL: URL {
        return URL(string: "https://port-0-redoit-spring-server-ac2nlkyjbi0s.sel4.cloudtype.app") ?? URL(string: "https://port-0-redoit-spring-server-ac2nlkyjbi0s.sel4.cloudtype.app")!
    }
    
    var path: String {
        switch self {
        case .uploadInput:
            return "/image"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadInput:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .uploadInput(data, prompt):
            var multiPartFormData = [MultipartFormData]()
            let imgData = MultipartFormData(
                provider: .data(data),
                name: "image",
                fileName: "image.png",
                mimeType: "image/png")
            multiPartFormData.append(imgData)
            return .uploadCompositeMultipart(
                multiPartFormData,
                urlParameters: [
                    "prompt": prompt
                ]
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadInput:
            return ["Content-Type": "multipart/form-data"]
        }
    }
    
    public var errorMap: [Int: ErrorType] {
        [
            400: .badRequest,
            500: .internalServerError
        ]
    }
}

public protocol BaseAPI: TargetType {
    associatedtype ErrorType: Error
    var errorMap: [Int: ErrorType] { get }
}
