import Foundation

public struct HTTPResponse {
    public let request: HTTPRequest
    public let response: HTTPURLResponse
    public let body: Data?
    
    
    public var status: HTTPStatus {
        // A struct of similar construction to HTTPMethod
        HTTPStatus(rawValue: response.statusCode)
    }
    
    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }
    
    public var headers: [AnyHashable: Any] { response.allHeaderFields }
}
