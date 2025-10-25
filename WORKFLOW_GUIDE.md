# 📝 Guida al Flusso di Journaling

Questa guida spiega come funziona l'app una volta che l'utente ha creato un diario.

## 🔄 Flusso Completo

### 1️⃣ **Home Page** (Tutti i Diari)
L'utente vede tutti i suoi diari in una griglia elegante.

**Azioni:**
- **Tap su un diario** → Apre il dettaglio del diario
- **Tap sul pulsante +** → Crea un nuovo diario

---

### 2️⃣ **Dettaglio Diario** (Vista Singolo Diario)
Quando si seleziona un diario, l'utente vede:

#### **Header**
- Copertina del diario
- Statistiche:
  - 📄 Numero di pagine
  - 📷 Numero totale di foto
  - 📅 Giorni dall'inizio

#### **Lista Pagine**
Ogni entry/pagina mostra:
- Data di creazione
- Anteprima del testo
- Icone per: numero foto, numero sticker, tipo di cornice
- Thumbnail visivo

**Azioni:**
- **Tap su una pagina** → Apre l'editor per modificare
- **Tap sul pulsante +** → Crea una nuova pagina

---

### 3️⃣ **Editor Pagina** (Crea/Modifica)
Qui l'utente crea o modifica una pagina del diario.

#### **Sezioni Principali:**

##### 📱 **Anteprima Live**
- Mostra in tempo reale come apparirà la pagina
- Aggiornamento automatico mentre l'utente scrive
- Visualizza: foto, testo, sticker, cornice applicata

##### 🛠️ **Barra degli Strumenti**
Tre pulsanti principali:

1. **📷 Foto**
   - Tap per aggiungere foto dalla galleria
   - Visualizzazione in scroll orizzontale
   - Pulsante X per rimuovere foto
   - Supporta multiple foto per pagina

2. **😊 Sticker**
   - Libreria di sticker/emoji
   - Grid con: ❤️ ⭐ ☀️ 🌙 ✨ 🔥 🍃 📷
   - Tap per aggiungere alla pagina
   - Personalizzabili (posizione, scala, rotazione)

3. **🖼️ Cornice**
   - 5 tipi di cornici:
     - **Nessuna**: senza cornice
     - **Semplice**: bordo sottile grigio
     - **Polaroid**: bordo spesso beige (stile foto istantanea)
     - **Vintage**: bordo medio rosa antico
     - **Elegante**: bordo sottile lavanda
   - Preview visiva per ogni tipo
   - Selezione con tap

##### ✍️ **Editor di Testo**
- Area di testo multilinea
- Placeholder suggestivo:
  - "Cosa è successo oggi?"
  - "Cosa hai provato?"
  - "Cosa hai imparato?"
- Aggiornamento live nell'anteprima
- Nessun limite di caratteri

##### 💾 **Salvataggio**
- Pulsante "Crea" (per nuove pagine)
- Pulsante "Salva" (per modifiche)
- Pulsante "Annulla" per uscire senza salvare

---

## 🎨 Caratteristiche UX

### **Feedback Visivo**
- ✅ Pulsanti cambiano colore quando attivi
- ✅ Hover effects su tutti gli elementi cliccabili
- ✅ Transizioni fluide tra schermate
- ✅ Shadow ed elevazione per profondità

### **Validazione**
- Pulsante "Crea" disabilitato se manca il titolo
- Auto-salvataggio della data corrente
- Possibilità di salvare pagine anche vuote

### **Organizzazione**
- Pagine ordinate dalla più recente
- Statistiche aggiornate automaticamente
- Contatori in tempo reale

---

## 📋 Modello Dati

### **Journal (Diario)**
```swift
- id: UUID
- title: String
- coverImage: String? (opzionale)
- createdDate: Date
- lastModifiedDate: Date
- entries: [JournalEntry] (array di pagine)
- coverColor: String (beige, sage, rose, lavender, blue)
```

### **JournalEntry (Pagina)**
```swift
- id: UUID
- date: Date
- text: String
- photos: [String] (array di path foto)
- stickers: [StickerData]
- frameType: FrameType (enum)
```

### **StickerData**
```swift
- id: UUID
- imageName: String
- position: CGPoint (x, y)
- scale: Double (dimensione)
- rotation: Double (rotazione in gradi)
```

### **FrameType (Enum)**
```swift
- none
- simple
- polaroid
- vintage
- elegant
```

---

## 🚀 Funzionalità Implementate

### ✅ **Completato**
- [x] Creazione e gestione diari
- [x] Vista dettaglio con statistiche
- [x] Editor pagine con anteprima live
- [x] Supporto testo multilinea
- [x] Sistema di sticker (8 emoji disponibili)
- [x] 5 tipologie di cornici
- [x] Aggiunta/rimozione foto (UI ready)
- [x] Lista pagine con preview
- [x] Navigazione completa tra schermate
- [x] Design minimalista e colori eleganti

### 🔜 **Da Implementare (Prossimi Step)**
- [ ] Integrazione reale con PhotosPicker di iOS
- [ ] Sistema di drag & drop per sticker
- [ ] Salvataggio persistente (CoreData/SwiftData)
- [ ] Zoom e crop per foto
- [ ] Filtri foto
- [ ] Export pagine come PDF o immagini
- [ ] Ricerca full-text nelle pagine
- [ ] Tag e categorie
- [ ] Backup iCloud
- [ ] Condivisione sui social
- [ ] Lock con Face ID/Touch ID

---

## 🎯 Casi d'Uso Tipici

### **Scenario 1: Diario di Viaggio**
1. Utente crea diario "Viaggio in Toscana"
2. Ogni giorno aggiunge una nuova pagina con:
   - Foto dei luoghi visitati
   - Testo con impressioni e ricordi
   - Sticker per mood (☀️ ❤️ ⭐)
   - Cornice Polaroid per look vintage

### **Scenario 2: Diario Personale Quotidiano**
1. Utente crea diario "Le Mie Riflessioni 2025"
2. Scrive pensieri quotidiani:
   - Principalmente testo
   - Poche foto (momenti speciali)
   - Cornice semplice o nessuna
   - Sticker per esprimere emozioni

### **Scenario 3: Diario Fotografico**
1. Utente crea diario "I Miei Scatti"
2. Focus sulle immagini:
   - Multiple foto per pagina
   - Testo minimo (didascalie)
   - Cornici eleganti o vintage
   - Sticker decorativi

---

## 💡 Best Practices UX

### **Design**
- Mantieni colori morbidi e non invadenti
- Usa spazi bianchi generosamente
- Font leggibili (serif per titoli, sans-serif per body)
- Icone intuitive e riconoscibili

### **Performance**
- Lazy loading per foto
- Thumbnails ottimizzati
- Cache immagini
- Animazioni a 60fps

### **Accessibilità**
- Testi con contrasto adeguato
- Dimensioni tap target ≥ 44pt
- Supporto Dynamic Type
- VoiceOver friendly

---

## 🔧 Note Tecniche

### **File Principali**
- `JournalDetailView.swift` - Vista dettaglio diario
- `JournalEntryEditorView.swift` - Editor pagine
- `ContentView.swift` - Home page con navigazione

### **Architettura**
- **SwiftUI** per UI
- **@EnvironmentObject** per state management
- **ObservableObject** per JournalStore
- **Codable** per persistenza futura

### **Navigazione**
- NavigationView root
- NavigationLink per dettaglio
- Sheet modals per editor

---

Creato con ❤️ per un'esperienza di journaling elegante e piacevole!

