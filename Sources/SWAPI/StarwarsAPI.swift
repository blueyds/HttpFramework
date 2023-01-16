import Foundation
import HttpFramework

extension ServerEnvironment {
    public static var swapi = ServerEnvironment(host: "swapi.dev", pathPrefix: "/api/")
}
public class StarWarsAPI:JSONSimpleDecode {
    private let loader: HTTPLoader
    public static var shared: StarWarsAPI = StarWarsAPI()
	 private let excludedPeople: Set<Int> = [17]
    private init(){
        let env: HTTPLoader = ApplyEnvironment(environment: .swapi)
        let urlLoad: HTTPLoader = URLLoader()
        let printer: HTTPLoader = PrintLoader()
		  let throttle: HTTPLoader = Throttle(maximumNumberOfRequests: 5)
        self.loader = env --> throttle --> printer --> urlLoad
    }
	 public func request(personID: Int, completion: @escaping (SWAPI_Person) -> Void){
		 if excludedPeople.contains(personID) || personID < 1 || personID > 83 { return }
		 let path: String = "people/\(personID)"
		 print(path)
		 let request = HTTPRequest(path: path)
		 let task = HTTPTask(request: request){[self] result in
			  if let body = result.response?.body {
				  print("Decoding \(personID)")
				  print(String(decoding: body, as: UTF8.self))
				  let d: SWAPI_Person = decode(from: body)
				  completion(d)
			  }
		  }
		  loader.load(task: task)
	 }
    public func request(person: SWAPISelectPerson, completion: @escaping (SWAPI_Person) -> Void) {
		 request(personID: person.rawValue, completion: completion)
    }
}
