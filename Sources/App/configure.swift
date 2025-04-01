import Fluent
import FluentSQLiteDriver
import Vapor

public func configure(_ app: Application) throws {
    // Configura banco SQLite em memória
    app.databases.use(.sqlite(.memory), as: .sqlite)
    
    // Registra migrações
    app.migrations.add(CreateTask())
    
    // Registra rotas
    try app.register(collection: TaskController())
    
    // Roda migrações automaticamente
    try app.autoMigrate().wait()
}
