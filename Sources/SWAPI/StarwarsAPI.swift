import Foundation
import HttpFramework

extension ServerEnvironment {
    public static var swapi = ServerEnvironment(host: "swapi.dev", pathPrefix: "/api/")
}
public class StarWarsAPI:JSONSimpleDecode {
    private let loader: HTTPLoader
    public static var shared: StarWarsAPI = StarWarsAPI()
    private init(){
        let env: HTTPLoader = ApplyEnvironment(environment: .swapi)
        let load: HTTPLoader = URLLoader()
        let printer: HTTPLoader = PrintLoader()
        self.loader = env --> printer --> load
    }
    public func request(person: SWAPISelectPerson, completion: @escaping (SWAPI_Person) -> Void) {
        Task{
            loader.load(request: HTTPRequest(path: person.rawValue)) { [self] result in
                // TODO: interpret the result
                if result.response != nil {
                    var s = String()
                    result.response!.body!.forEach(){
                        s.append(Character(.init($0)))
                    }
                    print(s)
                    let d:SWAPI_Person = decode(from: result.response!.body!) 
                    completion(d)
                }
            }    
        }
        
    }
}
