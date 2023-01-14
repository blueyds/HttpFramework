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
        let urlLoad: HTTPLoader = URLLoader()
        let printer: HTTPLoader = PrintLoader()
        self.loader = env --> printer --> urlLoad
    }
    public func request(person: SWAPISelectPerson, completion: @escaping (SWAPI_Person) -> Void) {
        let request = HTTPRequest(path: person.rawValue)
		  let task = HTTPTask(request: request){[self] result in
			  if let body = result.response?.body? {
				  let d: SWAPI_Person = decode(from: body)
				  completion(d)
			  }
		  }
		  loader.load(task: task)
    }
}
