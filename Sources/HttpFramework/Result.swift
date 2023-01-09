import Foundation

public typealias HTTPResult = Result<HTTPResponse, HTTPError>

extension HTTPResult {

    init(request: HTTPRequest,
         responseData: Data?,
         response: URLResponse?,
         error: Error?){
        var httpResponse: HTTPResponse?
        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request: request, response: r, body: responseData ?? Data())
        }
        
        if let e = error as? URLError {
            let code: HTTPError.Code
            switch e.code {
            case .badURL: code = .invalidRequest
            case .unsupportedURL: code = .unknown
            case .cannotFindHost: code = .unknown
            default: code = .unknown
            }
            self = .failure(HTTPError(code: code, request: request, response: httpResponse, underlyingError: e))
        } else if let someError = error {
            // an error, but not a URL error
            self = .failure(HTTPError(code: .unknown, request: request, response: httpResponse, underlyingError: someError))
        } else if let r = httpResponse {
            // not an error, and an HTTPURLResponse
            self = .success(r)
        } else {
            // not an error, but also not an HTTPURLResponse
            self = .failure(HTTPError(code: .invalidResponse, request: request, response: nil, underlyingError: error))
        }
    }
    public var request: HTTPRequest {
        switch self {
        case .success(let response): return response.request
        case .failure(let error): return error.request
        }
    }
    
    public var response: HTTPResponse? {
        switch self {
        case .success(let response): return response
        case .failure(let error): return error.response
        }
    }
    
}

