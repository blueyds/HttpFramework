import Foundation

public struct HTTPRequest {
    private var urlComponents = URLComponents()
    public var method: HTTPMethod = .get // the struct we previously defined
    public var headers: [String: String] = [:]
    public var body: HTTPBody = EmptyBody()
    private var options = [ObjectIdentifier: Any]()
    public var id: UUID = UUID()
    
    public init() {
        urlComponents.scheme = "https"
    }
    public init(path: String){
        self.init()
        self.path = path
    }
    
}
extension HTTPRequest {
    
    public var scheme: String { urlComponents.scheme ?? "https" }
    
    public var host: String? {
        get { urlComponents.host }
        set { urlComponents.host = newValue }
    }
    
    public var path: String {
        get { urlComponents.path }
        set { urlComponents.path = newValue }
    }
    var url: URL? { urlComponents.url }
    
    public subscript<O: HTTPRequestOption>(option type: O.Type) -> O.Value {
        get {
            // create the unique identifier for this type as our lookup key
            let id = ObjectIdentifier(type)
            
            // pull out any specified value from the options dictionary, if it's the right type
            // if it's missing or the wrong type, return the defaultOptionValue
            guard let value = options[id] as? O.Value else { return type.defaultOptionValue }
            
            // return the value from the options dictionary
            return value
        }
        set {
            let id = ObjectIdentifier(type)
            // save the specified value into the options dictionary
            options[id] = newValue
        }
    }
    
    public var serverEnvironment: ServerEnvironment? {
        get { self[option: ServerEnvironment.self] }
        set { self[option: ServerEnvironment.self] = newValue }
    }
    
    public mutating func addQueryItem(item: URLQueryItem){
        urlComponents.queryItems?.append(item)
    }
    public func addQueryItem(name: String, value: String){
        addQueryItem(item: URLQueryItem(name: name, value: value))
    }
    
}


