import Vapor

struct TaskController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let tasks = routes.grouped("tasks")
        tasks.get(use: index)
        tasks.post(use: create)
        tasks.put(":id", use: update)
        tasks.delete(":id", use: delete)
    }

    // GET /tasks
    func index(req: Request) throws -> EventLoopFuture<[Task]> {
        return Task.query(on: req.db).all()
    }

    // POST /tasks
    func create(req: Request) throws -> EventLoopFuture<Task> {
        let task = try req.content.decode(Task.self)
        return task.save(on: req.db).map { task }
    }

    // PUT /tasks/:id
    func update(req: Request) throws -> EventLoopFuture<Task> {
        let updatedTask = try req.content.decode(Task.self)
        return Task.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { task in
                task.title = updatedTask.title
                task.isCompleted = updatedTask.isCompleted
                return task.save(on: req.db).map { task }
            }
    }

    // DELETE /tasks/:id
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Task.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
