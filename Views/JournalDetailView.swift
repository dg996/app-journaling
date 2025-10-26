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
    @State private var currentPageIndex = 0
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            if journal.entries.isEmpty {
                // Empty state
                EmptyEntriesView()
            } else {
                // Page viewer with swipe
                TabView(selection: $currentPageIndex) {
                    ForEach(Array(journal.entries.enumerated()), id: \.element.id) { index, entry in
                        JournalPageView(entry: entry, pageNumber: index + 1)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                
                // Page Indicator
                VStack {
                    HStack {
                        Spacer()
                        Text("\(currentPageIndex + 1) di \(journal.entries.count)")
                            .font(AppFonts.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.textSecondary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
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
    }
}

// Full page view for journal entry
struct JournalPageView: View {
    let entry: JournalEntry
    let pageNumber: Int
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Date header
                Text(formatDate(entry.date))
                    .font(.system(size: 13))
                    .foregroundColor(.textTertiary)
                    .fontWeight(.medium)
                    .textCase(.uppercase)
                    .tracking(0.8)
                    .padding(.top, 40)
                
                // Photo if present
                if !entry.photos.isEmpty {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: [Color.softBeige, Color(red: 0.83, green: 0.77, blue: 0.72)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 200)
                        .overlay(
                            Image(systemName: "photo.fill")
                                .font(.system(size: 64))
                                .foregroundColor(.white.opacity(0.6))
                        )
                        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .overlay(alignment: .topTrailing) {
                            if !entry.stickers.isEmpty {
                                Text(entry.stickers[0].imageName)
                                    .font(.system(size: 36))
                                    .padding(12)
                                    .shadow(color: Color.black.opacity(0.2), radius: 2)
                            }
                        }
                }
                
                // Text content
                Text(entry.text.isEmpty ? "Nessun testo" : entry.text)
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(.textPrimary)
                    .lineSpacing(8)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Stickers at bottom
                if entry.stickers.count > 1 {
                    HStack(spacing: 16) {
                        Spacer()
                        ForEach(Array(entry.stickers.dropFirst()), id: \.id) { sticker in
                            Text(sticker.imageName)
                                .font(.system(size: 32))
                                .shadow(color: Color.black.opacity(0.15), radius: 2)
                        }
                    }
                }
                
                // Page number
                Text("Pagina \(pageNumber)")
                    .font(AppFonts.caption)
                    .foregroundColor(.textTertiary)
                    .padding(.top, 8)
                    .padding(.bottom, 40)
            }
            .padding(.horizontal, 28)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 8)
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(getFrameStyle(), lineWidth: getFrameWidth())
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
        )
    }
    
    private func getFrameStyle() -> Color {
        switch entry.frameType {
        case .none:
            return Color.clear
        case .simple:
            return Color.charcoalGray
        case .polaroid:
            return Color.softBeige
        case .vintage:
            return Color(red: 0.79, green: 0.65, blue: 0.50)
        case .elegant:
            return Color.softLavender
        }
    }
    
    private func getFrameWidth() -> CGFloat {
        switch entry.frameType {
        case .none:
            return 0
        case .simple:
            return 2
        case .polaroid:
            return 14
        case .vintage:
            return 5
        case .elegant:
            return 3
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
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

