import Fluent

struct CreateTask: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("tasks")
            .id()
            .field("title", .string, .required)
//            .field("is_completed", .bool, .required) 
            .create()
    }

    func revert(on database: any Database) -> EventLoopFuture<Void> {
        database.schema("tasks").delete()
    }
}
