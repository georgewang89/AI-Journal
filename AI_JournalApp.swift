import SwiftUI
import SwiftData

@main
struct AI_JournalApp: App {
    // Initialize the ModelContainer
    let container: ModelContainer
    
    init() {
        do {
            // Create a model configuration
            let modelConfig = ModelConfiguration(
                schema: Schema([Note.self])
            )
            
            // Initialize container with configuration
            container = try ModelContainer(for: Note.self, configurations: modelConfig)
            
            // Add a welcome note for first launch
            if try container.mainContext.fetch(FetchDescriptor<Note>()).isEmpty {
                let welcome = Note(
                    title: "Welcome to AI Journal!",
                    content: "Start writing your first note by tapping the + button."
                )
                container.mainContext.insert(welcome)
            }
        } catch {
            fatalError("Failed to configure SwiftData container: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}

// End of file. No additional code.
