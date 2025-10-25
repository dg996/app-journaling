//
//  JournalingModels.swift
//  Journaling
//
//  Modelli specifici per Journaling, Mood Tracking, Gratitude, Habits
//

import Foundation
import SwiftUI

// MARK: - Mood Tracking

enum MoodType: String, Codable, CaseIterable {
    case amazing = "Fantastico"
    case happy = "Felice"
    case good = "Bene"
    case okay = "Ok"
    case sad = "Triste"
    case anxious = "Ansioso"
    case angry = "Arrabbiato"
    case tired = "Stanco"
    
    var emoji: String {
        switch self {
        case .amazing: return "🤩"
        case .happy: return "😊"
        case .good: return "🙂"
        case .okay: return "😐"
        case .sad: return "😢"
        case .anxious: return "😰"
        case .angry: return "😠"
        case .tired: return "😴"
        }
    }
    
    var color: Color {
        switch self {
        case .amazing: return Color(red: 1.0, green: 0.8, blue: 0.0)
        case .happy: return Color(red: 1.0, green: 0.95, blue: 0.4)
        case .good: return Color(red: 0.6, green: 0.9, blue: 0.6)
        case .okay: return Color(red: 0.8, green: 0.9, blue: 0.95)
        case .sad: return Color(red: 0.6, green: 0.7, blue: 0.9)
        case .anxious: return Color(red: 0.9, green: 0.75, blue: 0.6)
        case .angry: return Color(red: 0.95, green: 0.6, blue: 0.6)
        case .tired: return Color(red: 0.8, green: 0.8, blue: 0.85)
        }
    }
    
    var score: Int {
        switch self {
        case .amazing: return 5
        case .happy: return 4
        case .good: return 3
        case .okay: return 2
        case .sad: return 1
        case .anxious: return 1
        case .angry: return 1
        case .tired: return 2
        }
    }
}

struct MoodEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var mood: MoodType
    var note: String
    
    init(mood: MoodType, note: String = "") {
        self.date = Date()
        self.mood = mood
        self.note = note
    }
}

// MARK: - Gratitude Journal

struct GratitudeEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var items: [String] // 3 cose per cui sei grato/a
    
    init(items: [String] = ["", "", ""]) {
        self.date = Date()
        self.items = items
    }
}

// MARK: - Journaling Prompts

enum JournalingPromptCategory: String, Codable, CaseIterable {
    case gratitude = "Gratitudine"
    case reflection = "Riflessione"
    case goals = "Obiettivi"
    case selfCare = "Cura di Sé"
    case creativity = "Creatività"
    case relationships = "Relazioni"
    case growth = "Crescita"
}

struct JournalingPrompt: Identifiable, Codable {
    var id = UUID()
    var category: JournalingPromptCategory
    var question: String
    var icon: String
    
    static let prompts: [JournalingPrompt] = [
        // Gratitudine
        JournalingPrompt(category: .gratitude, question: "Quali 3 cose mi hanno reso felice oggi?", icon: "heart.fill"),
        JournalingPrompt(category: .gratitude, question: "Chi ha avuto un impatto positivo sulla mia giornata?", icon: "person.fill"),
        JournalingPrompt(category: .gratitude, question: "Quale piccolo momento mi ha fatto sorridere?", icon: "face.smiling"),
        
        // Riflessione
        JournalingPrompt(category: .reflection, question: "Cosa ho imparato oggi su me stesso/a?", icon: "brain.head.profile"),
        JournalingPrompt(category: .reflection, question: "Come mi sento in questo momento e perché?", icon: "heart.text.square"),
        JournalingPrompt(category: .reflection, question: "Quale sfida ho affrontato oggi e cosa mi ha insegnato?", icon: "mountain.2"),
        
        // Obiettivi
        JournalingPrompt(category: .goals, question: "Cosa voglio realizzare questa settimana?", icon: "target"),
        JournalingPrompt(category: .goals, question: "Quale piccolo passo posso fare oggi verso il mio obiettivo?", icon: "arrow.up.forward"),
        JournalingPrompt(category: .goals, question: "Cosa mi impedisce di raggiungere i miei sogni?", icon: "questionmark.diamond"),
        
        // Self-Care
        JournalingPrompt(category: .selfCare, question: "Come posso prendermi cura di me oggi?", icon: "leaf.fill"),
        JournalingPrompt(category: .selfCare, question: "Di cosa ho bisogno in questo momento?", icon: "heart.circle"),
        JournalingPrompt(category: .selfCare, question: "Cosa mi fa sentire in pace?", icon: "sun.max.fill"),
        
        // Creatività
        JournalingPrompt(category: .creativity, question: "Se potessi fare qualsiasi cosa oggi, cosa farei?", icon: "sparkles"),
        JournalingPrompt(category: .creativity, question: "Cosa mi ispira in questo momento?", icon: "lightbulb.fill"),
        JournalingPrompt(category: .creativity, question: "Come posso esprimere la mia creatività oggi?", icon: "paintbrush.fill"),
        
        // Relazioni
        JournalingPrompt(category: .relationships, question: "A chi voglio dire 'grazie' oggi?", icon: "hands.sparkles"),
        JournalingPrompt(category: .relationships, question: "Come posso essere più presente con le persone che amo?", icon: "person.2.fill"),
        JournalingPrompt(category: .relationships, question: "Quale relazione voglio nutrire di più?", icon: "heart.2.fill"),
        
        // Crescita
        JournalingPrompt(category: .growth, question: "In cosa sto crescendo ultimamente?", icon: "chart.line.uptrend.xyaxis"),
        JournalingPrompt(category: .growth, question: "Quale paura voglio affrontare?", icon: "figure.climb"),
        JournalingPrompt(category: .growth, question: "Come posso essere una versione migliore di me?", icon: "star.fill")
    ]
}

// MARK: - Habit Tracking

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var color: String
    var frequency: HabitFrequency
    var completedDates: [Date]
    var createdDate: Date
    
    init(name: String, icon: String = "checkmark.circle", color: String = "softSage", frequency: HabitFrequency = .daily) {
        self.name = name
        self.icon = icon
        self.color = color
        self.frequency = frequency
        self.completedDates = []
        self.createdDate = Date()
    }
    
    func isCompletedToday() -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return completedDates.contains { Calendar.current.isDate($0, inSameDayAs: today) }
    }
    
    func completionRate(days: Int = 30) -> Double {
        let calendar = Calendar.current
        let endDate = Date()
        guard let startDate = calendar.date(byAdding: .day, value: -days, to: endDate) else { return 0 }
        
        let completed = completedDates.filter { $0 >= startDate && $0 <= endDate }.count
        return Double(completed) / Double(days)
    }
}

enum HabitFrequency: String, Codable, CaseIterable {
    case daily = "Giornaliero"
    case weekly = "Settimanale"
    case monthly = "Mensile"
}

// MARK: - Entry Templates

enum JournalTemplate: String, CaseIterable, Codable {
    case freeform = "Scrittura Libera"
    case gratitude = "Gratitudine"
    case reflection = "Riflessione Giornaliera"
    case goals = "Obiettivi"
    case dreamLog = "Diario dei Sogni"
    case travelLog = "Diario di Viaggio"
    case moodLog = "Log dell'Umore"
    case photoMemory = "Ricordo Fotografico"
    
    var icon: String {
        switch self {
        case .freeform: return "doc.text"
        case .gratitude: return "heart.fill"
        case .reflection: return "brain.head.profile"
        case .goals: return "target"
        case .dreamLog: return "moon.stars.fill"
        case .travelLog: return "airplane"
        case .moodLog: return "face.smiling"
        case .photoMemory: return "photo.on.rectangle"
        }
    }
    
    var color: Color {
        switch self {
        case .freeform: return .softBeige
        case .gratitude: return .dustyRose
        case .reflection: return .softLavender
        case .goals: return .paleBlue
        case .dreamLog: return .softLavender
        case .travelLog: return .softSage
        case .moodLog: return Color(red: 1.0, green: 0.95, blue: 0.4)
        case .photoMemory: return .softBeige
        }
    }
    
    var prompts: [String] {
        switch self {
        case .freeform:
            return ["Scrivi liberamente i tuoi pensieri..."]
        case .gratitude:
            return ["Oggi sono grato/a per...", "Mi ha fatto sorridere...", "Ho apprezzato..."]
        case .reflection:
            return ["Come mi sento oggi?", "Cosa ho imparato?", "Di cosa sono orgoglioso/a?"]
        case .goals:
            return ["Il mio obiettivo è...", "Passi per raggiungerlo:", "Ostacoli da superare:"]
        case .dreamLog:
            return ["Ho sognato che...", "Emozioni nel sogno:", "Significato possibile:"]
        case .travelLog:
            return ["Luogo visitato:", "Esperienze e scoperte:", "Persone incontrate:"]
        case .moodLog:
            return ["Umore di oggi:", "Cosa l'ha influenzato?", "Come posso migliorarlo?"]
        case .photoMemory:
            return ["Descrizione del ricordo:", "Dove e quando:", "Perché è speciale:"]
        }
    }
}

// MARK: - Scrapbooking Elements

enum WashiTapePattern: String, CaseIterable, Codable {
    case dots = "Pois"
    case stripes = "Righe"
    case floral = "Floreale"
    case geometric = "Geometrico"
    case stars = "Stelle"
    case hearts = "Cuori"
    case waves = "Onde"
    case solid = "Tinta Unita"
    
    func patternView(color: Color = .softBeige) -> some View {
        Rectangle()
            .fill(color)
            .overlay(
                getPattern(color: color.opacity(0.6))
            )
    }
    
    @ViewBuilder
    private func getPattern(color: Color) -> some View {
        switch self {
        case .dots:
            Circle()
                .fill(color)
                .frame(width: 4, height: 4)
        case .stripes:
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [color, .clear, color, .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        case .floral, .geometric, .stars, .hearts, .waves:
            color
        case .solid:
            EmptyView()
        }
    }
}

struct ScrapbookElement: Identifiable, Codable {
    var id = UUID()
    var type: ElementType
    var position: CGPoint
    var rotation: Double
    var scale: Double
    var color: String
    
    enum ElementType: String, Codable {
        case washiTape
        case sticker
        case doodle
        case stamp
        case clipArt
    }
}

// MARK: - Tags

struct JournalTag: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var color: String
    var icon: String
    
    static let defaultTags: [JournalTag] = [
        JournalTag(name: "Lavoro", color: "paleBlue", icon: "briefcase.fill"),
        JournalTag(name: "Famiglia", color: "dustyRose", icon: "house.fill"),
        JournalTag(name: "Amici", color: "softSage", icon: "person.2.fill"),
        JournalTag(name: "Salute", color: "softLavender", icon: "heart.fill"),
        JournalTag(name: "Obiettivi", color: "softBeige", icon: "target"),
        JournalTag(name: "Viaggio", color: "softSage", icon: "airplane"),
        JournalTag(name: "Creatività", color: "dustyRose", icon: "paintbrush.fill"),
        JournalTag(name: "Sport", color: "paleBlue", icon: "figure.run")
    ]
}

