import SwiftUI
import SwiftData

struct HomeView: View {
    // Access model context
    @Environment(\.modelContext) private var modelContext
    
    // Query notes
    @Query(sort: \Note.timestamp, order: .reverse) private var notes: [Note]
    @State private var isAddingNote = false
    
    // Grid layout configuration
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    if notes.isEmpty {
                        // Display a sample note if there are no notes
                        NoteCard(note: Note.sample)
                            .frame(height: 200)
                    } else {
                        ForEach(notes) { note in
                            NoteCard(note: note)
                                .frame(height: 200)
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("My Notes")
            .toolbar {
                Button(action: {
                    isAddingNote = true
                }) {
                    Label("Add Note", systemImage: "plus")
                }
            }
            .sheet(isPresented: $isAddingNote) {
                AddNoteView()
            }
        }
    }
}

struct NoteCard: View {
    let note: Note
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(note.content)
                .font(.subheadline)
                .lineLimit(6)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(note.timestamp, style: .date)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
        .contextMenu {
            Button(role: .destructive) {
                modelContext.delete(note)
                try? modelContext.save()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let note = Note(title: title, content: content)
                        modelContext.insert(note)
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

extension Note {
    static let sample = Note(title: "Sample Note", content: "This is a sample note.")
}

#Preview {
    HomeView()
        .modelContainer(for: Note.self, inMemory: true)
}

// End of file. No additional code.
