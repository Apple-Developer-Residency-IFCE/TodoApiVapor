import Fluent
import Vapor


final class Task: Model, Content, @unchecked Sendable{
    static let schema = "tasks"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "is_completed")
    var isCompleted: Bool
    
    init() {}
    
    init(id: UUID? = nil, title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
