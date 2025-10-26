//
//  EditJournalView.swift
//  Journaling
//
//  Vista per modificare nome e copertina del diario
//

import SwiftUI

struct EditJournalView: View {
    @EnvironmentObject var journalStore: JournalStore
    @Environment(\.dismiss) var dismiss
    
    @Binding var journal: Journal
    @State private var editedTitle: String
    @State private var editedCoverColor: String
    
    let availableColors = [
        ("softBeige", Color.softBeige),
        ("softSage", Color.softSage),
        ("dustyRose", Color.dustyRose),
        ("softLavender", Color.softLavender),
        ("paleBlue", Color.paleBlue)
    ]
    
    init(journal: Binding<Journal>) {
        self._journal = journal
        self._editedTitle = State(initialValue: journal.wrappedValue.title)
        self._editedCoverColor = State(initialValue: journal.wrappedValue.coverColor)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Preview della copertina
                        VStack(spacing: 16) {
                            Text("Anteprima")
                                .font(AppFonts.caption)
                                .foregroundColor(.textSecondary)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(getCoverColor(editedCoverColor))
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
                                
                                Text(editedTitle)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .shadow(color: Color.black.opacity(0.3), radius: 2)
                            }
                        }
                        .padding(.top, 30)
                        
                        // Modifica titolo
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Titolo del Diario")
                                .font(AppFonts.headline)
                                .foregroundColor(.textPrimary)
                            
                            TextField("Es. Il Mio Diario", text: $editedTitle)
                                .font(AppFonts.body)
                                .foregroundColor(.textPrimary)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.softGray, lineWidth: 1)
                                )
                        }
                        .padding(.horizontal)
                        
                        // Selezione colore copertina
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Colore della Copertina")
                                .font(AppFonts.headline)
                                .foregroundColor(.textPrimary)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 16) {
                                ForEach(availableColors, id: \.0) { colorName, color in
                                    ColorOptionView(
                                        color: color,
                                        colorName: colorName,
                                        isSelected: editedCoverColor == colorName,
                                        action: {
                                            editedCoverColor = colorName
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationTitle("Modifica Diario")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") {
                        dismiss()
                    }
                    .foregroundColor(.textSecondary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva") {
                        saveChanges()
                    }
                    .foregroundColor(.charcoalGray)
                    .fontWeight(.semibold)
                    .disabled(editedTitle.isEmpty)
                }
            }
        }
    }
    
    private func saveChanges() {
        journal.title = editedTitle
        journal.coverColor = editedCoverColor
        journal.lastModifiedDate = Date()
        dismiss()
    }
    
    private func getCoverColor(_ colorName: String) -> Color {
        switch colorName {
        case "softSage": return Color.softSage
        case "dustyRose": return Color.dustyRose
        case "softLavender": return Color.softLavender
        case "paleBlue": return Color.paleBlue
        default: return Color.softBeige
        }
    }
}

// Vista per ogni opzione di colore
struct ColorOptionView: View {
    let color: Color
    let colorName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 60, height: 60)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    if isSelected {
                        Circle()
                            .stroke(Color.charcoalGray, lineWidth: 3)
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.charcoalGray)
                            .background(Circle().fill(Color.white))
                            .offset(x: 25, y: -25)
                    }
                }
                
                Text(colorName.replacingOccurrences(of: "soft", with: "")
                    .replacingOccurrences(of: "dusty", with: "")
                    .replacingOccurrences(of: "pale", with: "")
                    .capitalized)
                    .font(AppFonts.caption)
                    .foregroundColor(isSelected ? .textPrimary : .textSecondary)
            }
        }
    }
}

#Preview {
    EditJournalView(journal: .constant(Journal(title: "Il Mio Diario", coverColor: "softBeige")))
        .environmentObject(JournalStore())
}

