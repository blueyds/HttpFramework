import Foundation

public class Throttle: HTTPLoader {
	// TODO: thread safety
	// TODO: Cancel
	// TODO: Reset
	// TODO: Unthrottled request
	public var maximumNumberOfRequests = UInt.max
	private var requestsExecuting = UInt(0)
	private var pendingRequests: Queue<HTTPTask> = Queue<HTTPTask>()
	
	private var executable: Bool { // we can execute more tasks
		UInt(requestsExecuting) < maximumNumberOfRequests
	}
	
	public init(maximumNumberOfRequests: UInt){
		self.maximumNumberOfRequests = maximumNumberOfRequests
	}
	public override func load(task: HTTPTask){
		task.addCompletionHandler { [self] _ in
			self.end()
			Task{
				await self.startNextTasksIfAble()
			}
		}
		Task{
			await pendingRequests.enqueue(task)
			await startNextTasksIfAble()
		}
	}
	
	private func begin(){
		requestsExecuting += 1
	}
	private func end(){
		requestsExecuting -= 1
	}
	
	private func start(task: HTTPTask){
		self.begin()
		super.load(task: task)
	}
	private func startNextTasksIfAble() async{
		let isEmpty = await pendingRequests.isEmpty
		print("Empty - \(isEmpty)\t Requests = \(requestsExecuting)\t ")
		while isEmpty {
			if executable {
				print("executing next task from throttle")
				// we have capicity to run more tasks and we have tasks to run
				if let next = await pendingRequests.dequeue(){
					start(task: next)
				}	
			}
			
		}
	}
}