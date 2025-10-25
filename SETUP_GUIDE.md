# 🚀 Guida Setup - Journaling App

Questa guida ti aiuterà a configurare e avviare l'app Journaling in Xcode.

## 📋 Prerequisiti

- **Mac** con macOS Ventura (13.0) o superiore
- **Xcode 15.0** o superiore (scaricabile dall'App Store)
- Conoscenze base di Swift/SwiftUI (opzionale)

## 🔧 Passaggi di Configurazione

### Passo 1: Apri Xcode

1. Avvia **Xcode** dal tuo Mac
2. Se è la prima volta, accetta i termini e condizioni

### Passo 2: Crea un Nuovo Progetto

1. In Xcode, vai su **File → New → Project** (⇧⌘N)
2. Seleziona la tab **iOS**
3. Scegli il template **App**
4. Clicca **Next**

### Passo 3: Configura il Progetto

Inserisci i seguenti dettagli:

- **Product Name**: `Journaling`
- **Team**: Seleziona il tuo team (o "None" per sviluppo locale)
- **Organization Identifier**: `com.tuonome` (personalizzalo)
- **Bundle Identifier**: Verrà generato automaticamente (es. `com.tuonome.Journaling`)
- **Interface**: Assicurati sia selezionato **SwiftUI**
- **Language**: **Swift**
- **Storage**: Lascia deselezionato "Use Core Data" per ora
- **Include Tests**: Opzionale (puoi lasciare selezionato)

Clicca **Next** e scegli dove salvare il progetto (puoi usare una cartella diversa da questa).

### Passo 4: Sostituisci i File

Ora devi sostituire/aggiungere i file che ho creato:

1. **Nel Finder**, apri la cartella `app journaling` dove si trovano tutti i file .swift
2. **In Xcode**, nel Project Navigator (pannello sinistro):

#### File da SOSTITUIRE:
- Trascina `JournalingApp.swift` → sostituisci il file esistente
- Se esiste `ContentView.swift` nella root, eliminalo

#### File da AGGIUNGERE:

**Crea le cartelle** (tasto destro sul nome progetto → New Group):
1. Crea una cartella chiamata `Models`
2. Crea una cartella chiamata `Views`
3. Crea una cartella chiamata `Theme`

**Aggiungi i file alle cartelle appropriate**:
- Trascina `Journal.swift` e `JournalStore.swift` → nella cartella **Models**
- Trascina `ContentView.swift` e `AddJournalView.swift` → nella cartella **Views**
- Trascina `AppColors.swift` → nella cartella **Theme**

**Quando Xcode chiede**:
- ✅ Seleziona "Copy items if needed"
- ✅ Assicurati che il target "Journaling" sia selezionato
- Clicca **Finish**

### Passo 5: Aggiorna Info.plist (Opzionale)

Il file `Info.plist` è già configurato. Se vuoi personalizzare:
1. Trova `Info.plist` nel Project Navigator
2. Puoi modificare il nome dell'app o altre impostazioni

### Passo 6: Build & Run

1. Seleziona un **simulatore iOS** dal menu in alto (es. iPhone 15)
2. Clicca il pulsante **▶ (Run)** o premi **⌘R**
3. Xcode compilerà ed eseguirà l'app

**Prima compilazione**: Potrebbe richiedere qualche minuto. Sii paziente! ☕

## 🎨 Cosa Vedrai

L'app mostrerà:
- Una **home page elegante** con sfondo minimalista
- **3 diari di esempio** in una griglia 2x2
- Un **pulsante +** in basso a destra per creare nuovi diari
- Colori morbidi: beige, salvia, lavanda, rosa

## 🧪 Testa l'App

1. **Clicca il pulsante +** per creare un nuovo diario
2. **Inserisci un titolo** (es. "Vacanze Estate 2025")
3. **Scegli un colore** per la copertina
4. **Clicca "Crea"**
5. Vedrai il nuovo diario apparire nella home!

## ❓ Problemi Comuni

### "No such module SwiftUI"
- Assicurati di aver selezionato **SwiftUI** come interfaccia durante la creazione del progetto
- Minimum Deployment Target deve essere iOS 14.0 o superiore

### File non trovati / Errors di compilazione
- Verifica che tutti i file .swift siano stati aggiunti al target "Journaling"
- Nel Project Navigator, clicca su ogni file → File Inspector (pannello destro) → Target Membership deve avere "Journaling" selezionato

### Build fallisce
1. Product → Clean Build Folder (⇧⌘K)
2. Chiudi e riapri Xcode
3. Build di nuovo (⌘B)

### Simulatore non parte
- Assicurati di aver scaricato i simulatori iOS: Xcode → Settings → Platforms
- Prova con un simulatore diverso (es. iPhone 14 invece di iPhone 15)

## 📱 Test su Dispositivo Reale (Opzionale)

Per testare su un iPhone reale:

1. Collega l'iPhone al Mac
2. In Xcode, seleziona il tuo iPhone dal menu dei dispositivi
3. Vai su **Signing & Capabilities** nelle impostazioni progetto
4. Seleziona il tuo **Team** (serve un Apple ID gratuito)
5. Xcode configurerà automaticamente il provisioning
6. Clicca **Run** (⌘R)

## 🎯 Prossimi Passi

Ora che l'app funziona, puoi:
- Esplorare il codice nei vari file .swift
- Modificare i colori in `AppColors.swift`
- Aggiungere nuove funzionalità
- Creare la vista dettaglio del diario
- Implementare foto, sticker, e cornici

## 💡 Suggerimenti

- Usa **⌘ + Click** su qualsiasi simbolo Swift per vedere la sua definizione
- **⌘ + B**: Build rapido
- **⌘ + R**: Run
- **⌘ + .**: Stop simulatore
- **Preview in real-time**: Guarda i file con `#Preview` - premi **Option + ⌘ + Enter** per vedere l'anteprima live!

## 🆘 Serve Aiuto?

Se qualcosa non funziona:
1. Controlla gli errori nella console di Xcode (pannello in basso)
2. Leggi il messaggio d'errore - spesso è molto chiaro
3. Fai una ricerca su Google o Stack Overflow

---

Buon divertimento con la tua app Journaling! 📖✨


