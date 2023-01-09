import Foundation

public protocol BasicAuthDelegate: AnyObject {
    func basicAuth(_ loader: BasicAuth, retrieveCredentials callback: @escaping (BasicCredentials?) -> Void)
}

public class BasicAuth: HTTPLoader {
    public weak var delegate: BasicAuthDelegate?
    
    private var credentials: BasicCredentials?
    private var pendingTasks = Array<HTTPTask>()
    
    public override func load(task: HTTPTask) {
        if let customCredentials = task.request.basicCredentials {
            self.apply(customCredentials, to: task)
        } else if let mainCredentials = credentials {
            self.apply(mainCredentials, to: task)
        } else {
            self.pendingTasks.append(task)
            // TODO: ask delegate for credentials
        }
    }
    
    private func apply(_ credentials: BasicCredentials, to task: HTTPTask) {
        let joined = credentials.username + ":" + credentials.password
        let data = Data(joined.utf8)
        let encoded = data.base64EncodedString()
        let header:String = "Basic \(encoded)"
        task.request.headers.updateValue(header, forKey: "Authorization")
    }
}
