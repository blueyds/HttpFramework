import Foundation

public class URLLoader: HTTPLoader {
    private let session: URLSession = URLSession.shared
    public override func load(task: HTTPTask) {
        let urlRequest = generateUrlRequest(from: task)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            // construct a Result<HTTPResponse, HTTPError> out of the triplet of data, url response, and url error
            let result = HTTPResult(
                request: task.request, 
                responseData: data, 
                response: response, 
                error: error)
            complete(result)
        }
        
        // off we go!
        dataTask.resume()

    }
    
    private func generateUrlRequest(from task: HTTPTask) -> URLRequest{
        guard let url = task.request.url else {
            // we couldn't construct a proper URL out of the request's URLComponents
            task.fail(HTTPError(code: .invalidRequest, request: task.request, response: nil, underlyingError: nil))
            return
        }
        
        // construct the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = task.request.method.rawValue
        
        // copy over any custom HTTP headers
        for (header, value) in task.request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        if task.request.body.isEmpty == false {
            // if our body defines additional headers, add them
            for (header, value) in task.request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            
            // attempt to retrieve the body data
            do {
                urlRequest.httpBody = try task.request.body.encode()
            } catch {
                // something went wrong creating the body; stop and report back
                task.fail(HTTPError(code: .unknown, request: task.request, response: nil, underlyingError: nil))
                return
            }
        }
        return urlRequest
    }
     
}
