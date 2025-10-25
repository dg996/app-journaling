//
//  JournalStore.swift
//  Journaling
//
//  Created on 2025-10-25
//

import Foundation
import SwiftUI

// Store per gestire tutti i diari
class JournalStore: ObservableObject {
    @Published var journals: [Journal] = []
    
    init() {
        // Aggiungi alcuni diari di esempio per testing
        loadSampleData()
    }
    
    func addJournal(_ journal: Journal) {
        journals.append(journal)
        saveJournals()
    }
    
    func deleteJournal(at offsets: IndexSet) {
        journals.remove(atOffsets: offsets)
        saveJournals()
    }
    
    func updateJournal(_ journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index] = journal
            saveJournals()
        }
    }
    
    // Salvataggio persistente (da implementare con UserDefaults o CoreData)
    private func saveJournals() {
        // TODO: Implementare il salvataggio
    }
    
    // Dati di esempio per visualizzazione
    private func loadSampleData() {
        let sample1 = Journal(title: "Il Mio Primo Diario", coverColor: "softBeige")
        let sample2 = Journal(title: "Viaggi 2025", coverColor: "softSage")
        let sample3 = Journal(title: "Ricordi Preziosi", coverColor: "softLavender")
        
        journals = [sample1, sample2, sample3]
    }
}

