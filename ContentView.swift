// Import necessary frameworks for UI and data handling
import SwiftUI
import SwiftData

// Define the main view structure
struct ContentView: View {
    // Access the model context for data operations
    @Environment(\.modelContext) private var modelContext
    
    // Query notes from SwiftData, sorted by timestamp in reverse order
    @Query(sort: \Note.timestamp, order: .reverse) private var notes: [Note]
    // State variable to keep track of the selected tab
    @State private var selectedTab = 0
    
    // Define the body of the view
    var body: some View {
        NavigationStack {
            // Create a tab view with two tabs
            TabView(selection: $selectedTab) {
                // First tab: Home view
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                // Second tab: Progress view
                ProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.fill")
                    }
                    .tag(1)
            }
        }
    }
}

// Preview provider for ContentView
#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}

// End of file. No additional code.
