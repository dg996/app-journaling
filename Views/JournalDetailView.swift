//
//  JournalDetailView.swift
//  Journaling
//
//  Vista dettaglio di un singolo diario con tutte le sue pagine
//

import SwiftUI

struct JournalDetailView: View {
    @EnvironmentObject var journalStore: JournalStore
    @Environment(\.dismiss) var dismiss
    
    let journal: Journal
    @State private var showingAddEntry = false
    @State private var selectedEntry: JournalEntry?
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header con copertina del diario
                    JournalCoverHeader(journal: journal)
                    
                    // Statistiche
                    JournalStatsView(journal: journal)
                    
                    // Lista delle pagine/entry
                    if journal.entries.isEmpty {
                        EmptyEntriesView()
                    } else {
                        EntriesListView(
                            entries: journal.entries,
                            onEntryTap: { entry in
                                selectedEntry = entry
                            }
                        )
                    }
                    
                    Spacer(minLength: 100)
                }
            }
            
            // Pulsante per aggiungere nuova pagina
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddEntryButton(showingAddEntry: $showingAddEntry)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(journal.title)
                    .font(AppFonts.headline)
                    .foregroundColor(.textPrimary)
            }
        }
        .sheet(isPresented: $showingAddEntry) {
            JournalEntryEditorView(journal: journal, entry: nil)
        }
        .sheet(item: $selectedEntry) { entry in
            JournalEntryEditorView(journal: journal, entry: entry)
        }
    }
}

// Header con copertina
struct JournalCoverHeader: View {
    let journal: Journal
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(getCoverColor())
                    .frame(width: 160, height: 200)
                    .shadow(color: Color.black.opacity(0.12), radius: 12, x: 0, y: 6)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.3),
                                Color.clear
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 160, height: 200)
            }
            .padding(.top, 30)
        }
    }
    
    private func getCoverColor() -> Color {
        switch journal.coverColor {
        case "softSage": return Color.softSage
        case "dustyRose": return Color.dustyRose
        case "softLavender": return Color.softLavender
        case "paleBlue": return Color.paleBlue
        default: return Color.softBeige
        }
    }
}

// Statistiche del diario
struct JournalStatsView: View {
    let journal: Journal
    
    var body: some View {
        HStack(spacing: 40) {
            StatItem(
                icon: "doc.text",
                value: "\(journal.entries.count)",
                label: "Pagine"
            )
            
            StatItem(
                icon: "photo",
                value: "\(totalPhotos())",
                label: "Foto"
            )
            
            StatItem(
                icon: "calendar",
                value: daysSinceCreation(),
                label: "Giorni"
            )
        }
        .padding(.horizontal)
    }
    
    private func totalPhotos() -> Int {
        journal.entries.reduce(0) { $0 + $1.photos.count }
    }
    
    private func daysSinceCreation() -> String {
        let days = Calendar.current.dateComponents([.day], from: journal.createdDate, to: Date()).day ?? 0
        return "\(max(days, 0))"
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.textSecondary)
            
            Text(value)
                .font(AppFonts.headline)
                .foregroundColor(.textPrimary)
            
            Text(label)
                .font(AppFonts.caption)
                .foregroundColor(.textSecondary)
        }
    }
}

// Stato vuoto quando non ci sono entry
struct EmptyEntriesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "square.and.pencil")
                .font(.system(size: 48))
                .foregroundColor(.textTertiary)
                .padding(.top, 40)
            
            Text("Inizia a Scrivere")
                .font(AppFonts.title)
                .foregroundColor(.textSecondary)
            
            Text("Tocca + per creare la tua prima pagina")
                .font(AppFonts.body)
                .foregroundColor(.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.vertical, 40)
    }
}

// Lista delle entry del diario
struct EntriesListView: View {
    let entries: [JournalEntry]
    let onEntryTap: (JournalEntry) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Le Tue Pagine")
                .font(AppFonts.title)
                .foregroundColor(.textPrimary)
                .padding(.horizontal)
            
            ForEach(entries) { entry in
                EntryCardView(entry: entry)
                    .onTapGesture {
                        onEntryTap(entry)
                    }
            }
        }
    }
}

// Card per singola entry
struct EntryCardView: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack(spacing: 16) {
            // Thumbnail o placeholder
            if entry.photos.isEmpty {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.softBeige)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "doc.text")
                            .foregroundColor(.textTertiary)
                            .font(.system(size: 24))
                    )
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.softSage)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.textSecondary)
                            .font(.system(size: 24))
                    )
            }
            
            // Info entry
            VStack(alignment: .leading, spacing: 6) {
                Text(formatDate(entry.date))
                    .font(AppFonts.caption)
                    .foregroundColor(.textSecondary)
                
                Text(entry.text.isEmpty ? "Nessun testo" : entry.text)
                    .font(AppFonts.body)
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                
                HStack(spacing: 12) {
                    if !entry.photos.isEmpty {
                        Label("\(entry.photos.count)", systemImage: "photo")
                            .font(AppFonts.caption)
                            .foregroundColor(.textSecondary)
                    }
                    
                    if !entry.stickers.isEmpty {
                        Label("\(entry.stickers.count)", systemImage: "face.smiling")
                            .font(AppFonts.caption)
                            .foregroundColor(.textSecondary)
                    }
                    
                    if entry.frameType != .none {
                        Label(entry.frameType.rawValue, systemImage: "square.dashed")
                            .font(AppFonts.caption)
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.textTertiary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
}

// Pulsante per aggiungere nuova entry
struct AddEntryButton: View {
    @Binding var showingAddEntry: Bool
    
    var body: some View {
        Button(action: {
            showingAddEntry = true
        }) {
            ZStack {
                Circle()
                    .fill(Color.charcoalGray)
                    .frame(width: 60, height: 60)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    NavigationView {
        JournalDetailView(journal: Journal(title: "Il Mio Diario", coverColor: "softBeige"))
            .environmentObject(JournalStore())
    }
}

