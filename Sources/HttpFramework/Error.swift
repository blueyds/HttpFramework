import Foundation

public struct HTTPError: Error {
    /// The high-level classification of this error
    public let code: Code

    /// The HTTPRequest that resulted in this error
    public let request: HTTPRequest

    /// Any HTTPResponse (partial or otherwise) that we might have
    public let response: HTTPResponse?

    /// If we have more information about the error that caused this, stash it here
    public let underlyingError: Error?
    
    public init(code: Code, request: HTTPRequest, response: HTTPResponse?, underlyingError: Error?){
        self.code = code
        self.request = request
        self.response = response
        self.underlyingError = underlyingError
    }
    
    public init(code: Code, request: HTTPRequest){
        self.init(code: code, request: request, response: nil, underlyingError: nil)
    }

    public enum Code {
        case invalidRequest     // the HTTPRequest could not be turned into a URLRequest
        case cannotConnect      // some sort of connectivity problem
        case cancelled          // the user cancelled the request
        case insecureConnection // couldn't establish a secure connection to the server
        case invalidResponse    // the system did not receive a valid HTTP response
                               // other scenarios we may wish to expose; fill them in as necessary
        case unknown            // we have no idea what the problem is
    }
}
