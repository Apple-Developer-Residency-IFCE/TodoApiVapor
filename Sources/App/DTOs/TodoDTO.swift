import Fluent
import Vapor


struct TodoDTO: Content {
    var id: UUID?
    var title: String?
    
    func toModel() -> Task {
        let model = Task()
        model.id = self.id
        model.title = self.title ?? "" 
        return model
    }
}
