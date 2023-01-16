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
	private var isEmpty: Bool = true
	init(maximumNumberOfRequests: UInt){
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
			if pendingRequests == nil {
				pendingRequests = Queue([task])
				isEmpty = false
			} else {
				await pendingRequests!.enqueue(task)
				isEmpty = false
			}
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
			while executable && !(isEmpty) {
				// we have capicity to run more tasks and we have tasks to run
				let next = await pendingRequests!.dequeue()
				if next == nil {
					isEmpty = true
				} else {
					start(task: next!)
				}
			}
	}
}