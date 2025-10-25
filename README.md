# 📖 Journaling - App iOS per Diari Personali

Un'elegante applicazione iOS per creare e gestire diari personali con foto, sticker, cornici e molto altro.

## ✨ Caratteristiche

- **Design Minimalista**: Colori morbidi e palette elegante
- **Diari Personalizzati**: Crea diari con titoli e colori personalizzati
- **Multi-formato**: Supporto per testo, foto, sticker
- **Cornici Diverse**: Polaroid, vintage, eleganti e altre
- **Interfaccia Intuitiva**: UI pulita e facile da usare

## 🎨 Design

L'app utilizza una palette di colori delicati e minimalisti:
- Beige morbido
- Salvia delicato
- Rosa polveroso
- Lavanda chiaro
- Blu pallido

## 🚀 Come Iniziare

### Requisiti
- macOS con Xcode 15.0 o superiore
- iOS 17.0 o superiore
- Swift 5.9+

### Installazione

1. **Crea un nuovo progetto Xcode**:
   - Apri Xcode
   - File → New → Project
   - Seleziona "App" sotto iOS
   - Nome prodotto: `Journaling`
   - Interface: SwiftUI
   - Language: Swift
   - Crea il progetto

2. **Aggiungi i file al progetto**:
   - Trascina tutti i file `.swift` nella cartella del progetto Xcode
   - Assicurati di organizzare i file nelle cartelle:
     - `Models/` per Journal.swift e JournalStore.swift
     - `Views/` per ContentView.swift e AddJournalView.swift
     - `Theme/` per AppColors.swift
   - Sostituisci il file `Info.plist` se necessario

3. **Build & Run**:
   - Seleziona un simulatore iOS (iPhone 15 consigliato)
   - Premi ⌘R per compilare ed eseguire

## 📁 Struttura del Progetto

```
app journaling/
├── JournalingApp.swift          # Entry point dell'app
├── Models/
│   ├── Journal.swift            # Modello dati per i diari
│   └── JournalStore.swift       # Store per gestire i diari
├── Views/
│   ├── ContentView.swift        # Home page principale
│   └── AddJournalView.swift     # Vista per creare nuovi diari
├── Theme/
│   └── AppColors.swift          # Palette colori e font
├── Info.plist                   # Configurazione app
└── README.md                    # Questo file
```

## 🎯 Prossimi Passi

- [ ] Implementare la vista dettaglio del diario
- [ ] Aggiungere supporto per foto dalla galleria
- [ ] Creare libreria di sticker
- [ ] Implementare diverse tipologie di cornici
- [ ] Aggiungere persistenza dati (CoreData/SwiftData)
- [ ] Implementare funzionalità di modifica
- [ ] Aggiungere animazioni ed effetti

## 🔧 Note Tecniche

- L'app utilizza **SwiftUI** per l'interfaccia utente
- I dati sono attualmente in memoria (da implementare persistenza)
- Include dati di esempio per la demo

## 📱 Screenshot

(Da aggiungere dopo il primo build)

## 👨‍💻 Sviluppo

Questa è la versione base dell'app. Le funzionalità avanzate come sticker, cornici polaroid, e modifica completa saranno aggiunte nelle prossime iterazioni.

---

Creato con ❤️ in SwiftUI

