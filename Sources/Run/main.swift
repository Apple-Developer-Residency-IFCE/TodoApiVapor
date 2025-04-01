import Vapor
import Logging
import NIOCore
import NIOPosix

@main
enum Entrypoint {
    static func main() async throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        
        let app = try await Application.make(env)
        defer { app.shutdown() }
        
        do {
            try await configure(app)
            try await app.run()
        } catch {
            app.logger.report(error: error)
            throw error
        }
    }
}
