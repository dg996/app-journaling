//
//  Journal.swift
//  Journaling
//
//  Created on 2025-10-25
//

import Foundation
import SwiftUI

// Modello per un singolo diario/journal
struct Journal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var coverImage: String? // Nome dell'immagine o path
    var createdDate: Date
    var lastModifiedDate: Date
    var entries: [JournalEntry]
    var coverColor: String // Colore della copertina se non c'è immagine
    var moodEntries: [MoodEntry] // Tracciamento umore
    var gratitudeEntries: [GratitudeEntry] // Log gratitudine
    var habits: [Habit] // Abitudini da tracciare
    var tags: [JournalTag] // Tags personalizzati
    
    init(title: String, coverColor: String = "softBeige") {
        self.title = title
        self.createdDate = Date()
        self.lastModifiedDate = Date()
        self.entries = []
        self.coverColor = coverColor
        self.moodEntries = []
        self.gratitudeEntries = []
        self.habits = []
        self.tags = []
    }
}

// Modello per una singola entry nel journal
struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var text: String
    var photos: [String] // Array di path delle foto
    var stickers: [StickerData]
    var frameType: FrameType
    var template: JournalTemplate // Template usato
    var mood: MoodType? // Umore associato
    var tags: [JournalTag] // Tags per categorizzare
    var washiTapes: [WashiTapeStyle] // Decorazioni washi tape
    var gratitudeItems: [String] // Items di gratitudine per questo entry
    
    init(text: String = "", frameType: FrameType = .none, template: JournalTemplate = .freeform) {
        self.date = Date()
        self.text = text
        self.photos = []
        self.stickers = []
        self.frameType = frameType
        self.template = template
        self.mood = nil
        self.tags = []
        self.washiTapes = []
        self.gratitudeItems = []
    }
}

// Stile Washi Tape per decorazioni
struct WashiTapeStyle: Identifiable, Codable {
    var id = UUID()
    var pattern: WashiTapePattern
    var color: String
    var position: TapePosition
    var rotation: Double
    
    enum TapePosition: String, Codable {
        case top
        case bottom
        case left
        case right
        case diagonal
    }
}

// Dati per gli sticker
struct StickerData: Identifiable, Codable {
    var id = UUID()
    var imageName: String
    var position: CGPoint
    var scale: Double
    var rotation: Double
}

// Tipologie di cornici
enum FrameType: String, Codable, CaseIterable {
    case none = "Nessuna"
    case simple = "Semplice"
    case polaroid = "Polaroid"
    case vintage = "Vintage"
    case elegant = "Elegante"
}

