//
//  ContentView.swift
//  Journaling
//
//  Created on 2025-10-25
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var journalStore: JournalStore
    @State private var showingAddJournal = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background elegante
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Header con titolo
                        HeaderView()
                        
                        // Griglia dei diari
                        if journalStore.journals.isEmpty {
                            EmptyStateView()
                        } else {
                            JournalGridView()
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal)
                }
                
                // Pulsante floating per aggiungere nuovo diario
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddJournalButton(showingAddJournal: $showingAddJournal)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 24)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingAddJournal) {
            AddJournalView(isPresented: $showingAddJournal)
        }
    }
}

// Header della home page
struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("I Miei Diari")
                .font(AppFonts.largeTitle)
                .foregroundColor(.textPrimary)
            
            Text(getCurrentDateString())
                .font(AppFonts.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 40)
    }
    
    private func getCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "it_IT")
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter.string(from: Date())
    }
}

// Griglia dei diari
struct JournalGridView: View {
    @EnvironmentObject var journalStore: JournalStore
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(journalStore.journals) { journal in
                JournalCardView(journal: journal)
            }
        }
    }
}

// Card singolo diario
struct JournalCardView: View {
    let journal: Journal
    
    var body: some View {
        NavigationLink(destination: JournalDetailView(journalId: journal.id)) {
            VStack(alignment: .leading, spacing: 0) {
                // Copertina
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(getCoverColor())
                        .aspectRatio(0.75, contentMode: .fit)
                        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    
                    // Overlay con texture cartacea (opzionale)
                    RoundedRectangle(cornerRadius: 12)
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
                }
                
                // Titolo del diario
                VStack(alignment: .leading, spacing: 4) {
                    Text(journal.title)
                        .font(AppFonts.headline)
                        .foregroundColor(.textPrimary)
                        .lineLimit(2)
                    
                    Text("\(journal.entries.count) pagine")
                        .font(AppFonts.caption)
                        .foregroundColor(.textSecondary)
                }
                .padding(.top, 12)
            }
        }
    }
    
    private func getCoverColor() -> Color {
        switch journal.coverColor {
        case "softSage":
            return Color.softSage
        case "dustyRose":
            return Color.dustyRose
        case "softLavender":
            return Color.softLavender
        case "paleBlue":
            return Color.paleBlue
        default:
            return Color.softBeige
        }
    }
}

// Stato vuoto quando non ci sono diari
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed")
                .font(.system(size: 64))
                .foregroundColor(.textTertiary)
                .padding(.top, 60)
            
            Text("Nessun diario ancora")
                .font(AppFonts.title)
                .foregroundColor(.textSecondary)
            
            Text("Tocca + per creare il tuo primo diario")
                .font(AppFonts.body)
                .foregroundColor(.textTertiary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

// Pulsante per aggiungere nuovo diario
struct AddJournalButton: View {
    @Binding var showingAddJournal: Bool
    
    var body: some View {
        Button(action: {
            showingAddJournal = true
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
    ContentView()
        .environmentObject(JournalStore())
}

