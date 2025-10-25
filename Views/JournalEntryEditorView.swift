//
//  JournalEntryEditorView.swift
//  Journaling
//
//  Editor per creare/modificare una pagina del diario
//

import SwiftUI
import PhotosUI

struct JournalEntryEditorView: View {
    @EnvironmentObject var journalStore: JournalStore
    @Environment(\.dismiss) var dismiss
    
    let journal: Journal
    let entry: JournalEntry?
    
    @State private var text: String = ""
    @State private var selectedPhotos: [String] = []
    @State private var selectedStickers: [StickerData] = []
    @State private var selectedFrame: FrameType = .none
    
    @State private var showingPhotosPicker = false
    @State private var showingStickerPicker = false
    @State private var showingFramePicker = false
    
    var isEditing: Bool {
        entry != nil
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Preview della pagina
                        PagePreviewView(
                            text: text,
                            photos: selectedPhotos,
                            stickers: selectedStickers,
                            frameType: selectedFrame
                        )
                        .padding(.top, 20)
                        
                        // Barra degli strumenti
                        ToolbarOptionsView(
                            showingPhotosPicker: $showingPhotosPicker,
                            showingStickerPicker: $showingStickerPicker,
                            showingFramePicker: $showingFramePicker
                        )
                        
                        // Editor di testo
                        TextEditorSection(text: $text)
                        
                        // Sezione foto
                        if !selectedPhotos.isEmpty || showingPhotosPicker {
                            PhotosSection(
                                photos: $selectedPhotos,
                                showingPicker: $showingPhotosPicker
                            )
                        }
                        
                        // Sezione sticker
                        if !selectedStickers.isEmpty || showingStickerPicker {
                            StickersSection(
                                stickers: $selectedStickers,
                                showingPicker: $showingStickerPicker
                            )
                        }
                        
                        // Sezione cornice
                        if showingFramePicker {
                            FrameSection(selectedFrame: $selectedFrame)
                        }
                        
                        Spacer(minLength: 60)
                    }
                }
            }
            .navigationTitle(isEditing ? "Modifica Pagina" : "Nuova Pagina")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") {
                        dismiss()
                    }
                    .foregroundColor(.textSecondary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Salva" : "Crea") {
                        saveEntry()
                    }
                    .foregroundColor(.charcoalGray)
                    .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            loadEntry()
        }
    }
    
    private func loadEntry() {
        if let entry = entry {
            text = entry.text
            selectedPhotos = entry.photos
            selectedStickers = entry.stickers
            selectedFrame = entry.frameType
        }
    }
    
    private func saveEntry() {
        var updatedJournal = journal
        
        if let existingEntry = entry,
           let index = updatedJournal.entries.firstIndex(where: { $0.id == existingEntry.id }) {
            // Modifica entry esistente
            updatedJournal.entries[index].text = text
            updatedJournal.entries[index].photos = selectedPhotos
            updatedJournal.entries[index].stickers = selectedStickers
            updatedJournal.entries[index].frameType = selectedFrame
        } else {
            // Crea nuova entry
            var newEntry = JournalEntry(text: text, frameType: selectedFrame)
            newEntry.photos = selectedPhotos
            newEntry.stickers = selectedStickers
            updatedJournal.entries.insert(newEntry, at: 0)
        }
        
        updatedJournal.lastModifiedDate = Date()
        journalStore.updateJournal(updatedJournal)
        dismiss()
    }
}

// Preview della pagina
struct PagePreviewView: View {
    let text: String
    let photos: [String]
    let stickers: [StickerData]
    let frameType: FrameType
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Anteprima")
                .font(AppFonts.caption)
                .foregroundColor(.textSecondary)
            
            ZStack {
                // Sfondo della pagina
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 280, height: 380)
                    .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 6)
                
                // Cornice se selezionata
                if frameType != .none {
                    FrameOverlay(frameType: frameType)
                        .frame(width: 280, height: 380)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    // Foto placeholder
                    if !photos.isEmpty {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.softSage)
                            .frame(height: 140)
                            .overlay(
                                VStack(spacing: 4) {
                                    Image(systemName: "photo")
                                        .font(.system(size: 32))
                                        .foregroundColor(.white)
                                    Text("\(photos.count) foto")
                                        .font(AppFonts.caption)
                                        .foregroundColor(.white)
                                }
                            )
                    }
                    
                    // Testo
                    if !text.isEmpty {
                        Text(text)
                            .font(.system(size: 12))
                            .foregroundColor(.textPrimary)
                            .lineLimit(8)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    // Indicatori sticker
                    if !stickers.isEmpty {
                        HStack(spacing: 4) {
                            ForEach(0..<min(stickers.count, 3), id: \.self) { _ in
                                Circle()
                                    .fill(Color.softBeige)
                                    .frame(width: 20, height: 20)
                                    .overlay(
                                        Image(systemName: "face.smiling")
                                            .font(.system(size: 10))
                                            .foregroundColor(.textSecondary)
                                    )
                            }
                            if stickers.count > 3 {
                                Text("+\(stickers.count - 3)")
                                    .font(.system(size: 10))
                                    .foregroundColor(.textSecondary)
                            }
                        }
                    }
                }
                .padding(20)
                .frame(width: 280, height: 380)
            }
        }
    }
}

// Overlay cornice
struct FrameOverlay: View {
    let frameType: FrameType
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(getFrameStyle(), lineWidth: getFrameWidth())
            .padding(8)
    }
    
    private func getFrameStyle() -> Color {
        switch frameType {
        case .none:
            return Color.clear
        case .simple:
            return Color.charcoalGray
        case .polaroid:
            return Color.softBeige
        case .vintage:
            return Color.dustyRose
        case .elegant:
            return Color.softLavender
        }
    }
    
    private func getFrameWidth() -> CGFloat {
        switch frameType {
        case .none:
            return 0
        case .simple:
            return 2
        case .polaroid:
            return 8
        case .vintage:
            return 4
        case .elegant:
            return 3
        }
    }
}

// Barra degli strumenti
struct ToolbarOptionsView: View {
    @Binding var showingPhotosPicker: Bool
    @Binding var showingStickerPicker: Bool
    @Binding var showingFramePicker: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            ToolButton(
                icon: "photo",
                label: "Foto",
                isActive: showingPhotosPicker,
                action: { showingPhotosPicker.toggle() }
            )
            
            ToolButton(
                icon: "face.smiling",
                label: "Sticker",
                isActive: showingStickerPicker,
                action: { showingStickerPicker.toggle() }
            )
            
            ToolButton(
                icon: "square.dashed",
                label: "Cornice",
                isActive: showingFramePicker,
                action: { showingFramePicker.toggle() }
            )
        }
        .padding(.horizontal)
    }
}

struct ToolButton: View {
    let icon: String
    let label: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(isActive ? Color.charcoalGray : Color.softBeige)
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(isActive ? .white : .textSecondary)
                }
                
                Text(label)
                    .font(AppFonts.caption)
                    .foregroundColor(isActive ? .textPrimary : .textSecondary)
            }
        }
    }
}

// Sezione editor di testo
struct TextEditorSection: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Scrivi i tuoi pensieri", systemImage: "text.alignleft")
                .font(AppFonts.headline)
                .foregroundColor(.textPrimary)
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text("Cosa è successo oggi?\nCosa hai provato?\nCosa hai imparato?")
                        .font(AppFonts.body)
                        .foregroundColor(.textTertiary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $text)
                    .font(AppFonts.body)
                    .foregroundColor(.textPrimary)
                    .frame(minHeight: 150)
                    .scrollContentBackground(.hidden)
                    .padding(4)
                    .focused($isFocused)
            }
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFocused ? Color.charcoalGray : Color.softGray, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

// Sezione foto
struct PhotosSection: View {
    @Binding var photos: [String]
    @Binding var showingPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Foto", systemImage: "photo")
                .font(AppFonts.headline)
                .foregroundColor(.textPrimary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // Pulsante aggiungi foto
                    Button(action: {
                        // Simula aggiunta foto
                        photos.append("photo_\(photos.count + 1)")
                    }) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.softBeige)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(.textSecondary)
                            )
                    }
                    
                    // Foto aggiunte
                    ForEach(photos, id: \.self) { photo in
                        PhotoThumbnailView(photo: photo, onDelete: {
                            photos.removeAll { $0 == photo }
                        })
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .padding(.horizontal)
    }
}

struct PhotoThumbnailView: View {
    let photo: String
    let onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.softSage)
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "photo.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.white.opacity(0.7))
                )
            
            Button(action: onDelete) {
                Circle()
                    .fill(Color.charcoalGray)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            .offset(x: 8, y: -8)
        }
    }
}

// Sezione sticker
struct StickersSection: View {
    @Binding var stickers: [StickerData]
    @Binding var showingPicker: Bool
    
    let availableStickers = ["heart.fill", "star.fill", "sun.max.fill", "moon.fill", "sparkles", "flame.fill", "leaf.fill", "camera.fill"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Sticker", systemImage: "face.smiling")
                .font(AppFonts.headline)
                .foregroundColor(.textPrimary)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 12) {
                ForEach(availableStickers, id: \.self) { icon in
                    Button(action: {
                        let newSticker = StickerData(
                            imageName: icon,
                            position: .zero,
                            scale: 1.0,
                            rotation: 0.0
                        )
                        stickers.append(newSticker)
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.black.opacity(0.06), radius: 4)
                            
                            Image(systemName: icon)
                                .font(.system(size: 24))
                                .foregroundColor(.charcoalGray)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.softBeige.opacity(0.3))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

// Sezione cornice
struct FrameSection: View {
    @Binding var selectedFrame: FrameType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Cornice", systemImage: "square.dashed")
                .font(AppFonts.headline)
                .foregroundColor(.textPrimary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(FrameType.allCases, id: \.self) { frameType in
                        FrameOptionView(
                            frameType: frameType,
                            isSelected: selectedFrame == frameType,
                            action: { selectedFrame = frameType }
                        )
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.softBeige.opacity(0.3))
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

struct FrameOptionView: View {
    let frameType: FrameType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: 80, height: 100)
                    
                    if frameType != .none {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(getFrameColor(), lineWidth: getFrameWidth())
                            .frame(width: 70, height: 90)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.charcoalGray : Color.clear, lineWidth: 3)
                        .frame(width: 80, height: 100)
                )
                
                Text(frameType.rawValue)
                    .font(AppFonts.caption)
                    .foregroundColor(isSelected ? .textPrimary : .textSecondary)
            }
        }
    }
    
    private func getFrameColor() -> Color {
        switch frameType {
        case .simple: return Color.charcoalGray
        case .polaroid: return Color.softBeige
        case .vintage: return Color.dustyRose
        case .elegant: return Color.softLavender
        default: return Color.clear
        }
    }
    
    private func getFrameWidth() -> CGFloat {
        switch frameType {
        case .simple: return 2
        case .polaroid: return 8
        case .vintage: return 4
        case .elegant: return 3
        default: return 0
        }
    }
}

#Preview {
    JournalEntryEditorView(
        journal: Journal(title: "Il Mio Diario", coverColor: "softBeige"),
        entry: nil
    )
    .environmentObject(JournalStore())
}

