import SwiftUI
import SwiftData

// Progress view showing statistics and achievements
struct ProgressView: View {
    @Query private var notes: [Note]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Statistics") {
                    HStack {
                        Label("Total Notes", systemImage: "note.text")
                        Spacer()
                        Text("\(notes.count)")
                    }
                    
                    HStack {
                        Label("Latest Entry", systemImage: "calendar")
                        Spacer()
                        Text(notes.first?.timestamp.formatted(date: .abbreviated, time: .omitted) ?? "No entries")
                    }
                }
            }
            .navigationTitle("Progress")
        }
    }
}

// Preview provider
#Preview {
    ProgressView()
}

// End of file. No additional code.
