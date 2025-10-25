//
//  AddJournalView.swift
//  Journaling
//
//  Created on 2025-10-25
//

import SwiftUI

struct AddJournalView: View {
    @EnvironmentObject var journalStore: JournalStore
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var selectedColor: String = "softBeige"
    
    let availableColors = [
        ("softBeige", Color.softBeige),
        ("softSage", Color.softSage),
        ("dustyRose", Color.dustyRose),
        ("softLavender", Color.softLavender),
        ("paleBlue", Color.paleBlue)
    ]
    
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
                                    .fill(getSelectedColor())
                                    .frame(width: 200, height: 260)
                                    .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 6)
                                
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
                                    .frame(width: 200, height: 260)
                                
                                if !title.isEmpty {
                                    Text(title)
                                        .font(AppFonts.title)
                                        .foregroundColor(.textPrimary)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                }
                            }
                        }
                        .padding(.top, 20)
                        
                        // Campo titolo
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Titolo del Diario")
                                .font(AppFonts.headline)
                                .foregroundColor(.textPrimary)
                            
                            TextField("Es. Il mio viaggio...", text: $title)
                                .font(AppFonts.body)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.softGray, lineWidth: 1)
                                )
                        }
                        .padding(.horizontal)
                        
                        // Selezione colore
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Colore Copertina")
                                .font(AppFonts.headline)
                                .foregroundColor(.textPrimary)
                            
                            HStack(spacing: 16) {
                                ForEach(availableColors, id: \.0) { colorName, color in
                                    ColorButton(
                                        color: color,
                                        isSelected: selectedColor == colorName,
                                        action: { selectedColor = colorName }
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Nuovo Diario")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") {
                        isPresented = false
                    }
                    .foregroundColor(.textSecondary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Crea") {
                        createJournal()
                    }
                    .foregroundColor(.charcoalGray)
                    .fontWeight(.semibold)
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func getSelectedColor() -> Color {
        availableColors.first(where: { $0.0 == selectedColor })?.1 ?? Color.softBeige
    }
    
    private func createJournal() {
        let newJournal = Journal(title: title, coverColor: selectedColor)
        journalStore.addJournal(newJournal)
        isPresented = false
    }
}

// Pulsante per la selezione del colore
struct ColorButton: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(Color.charcoalGray, lineWidth: isSelected ? 3 : 0)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.charcoalGray)
                }
            }
        }
    }
}

#Preview {
    AddJournalView(isPresented: .constant(true))
        .environmentObject(JournalStore())
}

