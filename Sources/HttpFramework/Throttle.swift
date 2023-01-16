import Foundation

public class Throttle: HTTPLoader {
	// TODO: thread safety
	// TODO: Cancel
	// TODO: Reset
	// TODO: Unthrottled request
	public var maximumNumberOfRequests = UInt.max
	private var requestsExecuting = UInt(0)
	private var pendingRequests: Queue<HTTPTask>? = nil
	private var executable: Bool { // we can execute more tasks
		UInt(requestsExecuting) < maximumNumberOfRequests
	}
	init(maximumNumberOfRequests: UInt){
		self.maximumNumberOfRequests = maximunNumberOfRequests
	}
	public override func load(task: HTTPTask){
		task.addCompletionHandler { [self]
			self.end()
			self.startNextTasksIfAble()
		}
		Task{
			if pendingRequests == nil {
				pendingResults = await Stack([task])
			} else {
				pendingResults!.push(task)
			}
		}
		startNextTasksIfAble()
	}
	private func begin(){
		requestsExecuting++
	}
	private func end(){
		requestsExecuting--
	}
	
	private func start(task: HTTPTask){
		self.begin()
		super.load(task: task)
	}
	private func startNextTasksIfAble() {
		Task{
			while executable && !(pendingRequests.isEmpty) {
				// we have capicity to run more tasks and we have tasks to run
				let next = await pendingRequests.removeFirst()
				start(task: next)
			}
		}
	}
}