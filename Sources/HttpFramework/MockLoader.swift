import Foundation

public class MockLoader: HTTPLoader {
    public override func load(task: HTTPTask) {
        let status = HTTPStatus.ok
        let urlResponse = HTTPURLResponse(
            url: task.request.url!, 
            statusCode: status.rawValue, 
            httpVersion: "1.1", 
            headerFields: nil)!
        let response = HTTPResponse(
            request: task.request, 
            response: urlResponse, 
            body: nil)
        task.complete(with: .success(response))
    }
    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        let status = HTTPStatus.ok
        let urlResponse = HTTPURLResponse(
            url: request.url!, 
            statusCode: status.rawValue, 
            httpVersion: "1.1", 
            headerFields: nil)!
        let response = HTTPResponse(
            request: request, 
            response: urlResponse, 
            body: nil)
        completion(.success(response))
        
    } 
    
}
