import Foundation

public class PrintLoader: HTTPLoader {
    public override func load(task: HTTPTask) {
        print("Loading \(task.request.url?.absoluteString)")
		  task.addCompletionHandler(){result in
			  print("Got result \(result)")
			  //completion(result)
		  }
        super.load(task: task)
    }
    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        print("Loadingg \(request.url?.absoluteString)")
        super.load(request: request){ result in
            print("Got result \(result)")
            completion(result)
        }
    }
}
