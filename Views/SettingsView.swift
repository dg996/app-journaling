//
//  SettingsView.swift
//  Journaling
//
//  Impostazioni dell'app
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedBackground") private var selectedBackground: String = "bookshelf"
    @AppStorage("enableNotifications") private var enableNotifications: Bool = true
    @AppStorage("dailyReminderTime") private var dailyReminderTime: Date = Calendar.current.date(from: DateComponents(hour: 20, minute: 0)) ?? Date()
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    SettingsHeaderView()
                    
                    VStack(spacing: 24) {
                        // Appearance Section
                        SettingsSection(title: "Aspetto") {
                            BackgroundPickerRow(selectedBackground: $selectedBackground)
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                icon: "moon.fill",
                                iconColor: .charcoalGray,
                                title: "Modalità Scura",
                                subtitle: "In arrivo prossimamente"
                            )
                        }
                        
                        // Notifications Section
                        SettingsSection(title: "Notifiche") {
                            SettingsToggleRow(
                                icon: "bell.fill",
                                iconColor: .paleBlue,
                                title: "Promemoria Giornaliero",
                                subtitle: "Ricorda di scrivere nel journal",
                                isOn: $enableNotifications
                            )
                            
                            if enableNotifications {
                                Divider()
                                    .padding(.leading, 60)
                                
                                DatePicker(
                                    selection: $dailyReminderTime,
                                    displayedComponents: .hourAndMinute
                                ) {
                                    HStack(spacing: 12) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.softLavender.opacity(0.3))
                                                .frame(width: 44, height: 44)
                                            
                                            Image(systemName: "clock.fill")
                                                .foregroundColor(.softLavender)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("Orario")
                                                .font(AppFonts.body)
                                                .foregroundColor(.textPrimary)
                                            
                                            Text("Scegli quando ricevere il promemoria")
                                                .font(AppFonts.caption)
                                                .foregroundColor(.textSecondary)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        // About Section
                        SettingsSection(title: "Informazioni") {
                            SettingsRow(
                                icon: "info.circle.fill",
                                iconColor: .softSage,
                                title: "Versione",
                                subtitle: "1.0.0"
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                icon: "heart.fill",
                                iconColor: .dustyRose,
                                title: "Feedback & Supporto",
                                subtitle: "Aiutaci a migliorare"
                            )
                        }
                        
                        // Data Section
                        SettingsSection(title: "Dati") {
                            SettingsRow(
                                icon: "square.and.arrow.up.fill",
                                iconColor: .paleBlue,
                                title: "Esporta Dati",
                                subtitle: "Backup completo dei tuoi journal"
                            )
                            
                            Divider()
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                icon: "icloud.fill",
                                iconColor: .softSage,
                                title: "Backup iCloud",
                                subtitle: "Sincronizza su tutti i dispositivi"
                            )
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Settings Header

struct SettingsHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 50))
                .foregroundColor(.charcoalGray)
                .padding(.top, 40)
            
            Text("Impostazioni")
                .font(AppFonts.largeTitle)
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 30)
    }
}

// MARK: - Settings Section

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.textSecondary)
                .padding(.leading, 20)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
        }
    }
}

// MARK: - Background Picker Row

struct BackgroundPickerRow: View {
    @Binding var selectedBackground: String
    @State private var showingPicker = false
    
    let backgrounds: [(id: String, name: String, icon: String, color: Color)] = [
        ("bookshelf", "Libreria", "books.vertical.fill", .softBeige),
        ("plain", "Semplice", "rectangle.fill", .softGray),
        ("desk", "Scrivania", "pencil.and.outline", Color(red: 0.9, green: 0.85, blue: 0.8)),
        ("botanical", "Botanico", "leaf.fill", .softSage),
        ("readingCorner", "Angolo Lettura", "book.closed.fill", .dustyRose)
    ]
    
    var currentBackground: (id: String, name: String, icon: String, color: Color) {
        backgrounds.first(where: { $0.id == selectedBackground }) ?? backgrounds[0]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                showingPicker.toggle()
            }) {
                HStack(spacing: 12) {
                    // Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(currentBackground.color.opacity(0.3))
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: currentBackground.icon)
                            .foregroundColor(currentBackground.color)
                    }
                    
                    // Text
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Sfondo Home")
                            .font(AppFonts.body)
                            .foregroundColor(.textPrimary)
                        
                        Text(currentBackground.name)
                            .font(AppFonts.caption)
                            .foregroundColor(.textSecondary)
                    }
                    
                    Spacer()
                    
                    // Chevron
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.textTertiary)
                }
                .padding()
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expanded picker
            if showingPicker {
                VStack(spacing: 0) {
                    Divider()
                    
                    ForEach(backgrounds, id: \.id) { background in
                        Button(action: {
                            selectedBackground = background.id
                            withAnimation {
                                showingPicker = false
                            }
                        }) {
                            HStack(spacing: 12) {
                                // Preview icon
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(background.color.opacity(0.2))
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: background.icon)
                                        .font(.system(size: 20))
                                        .foregroundColor(background.color)
                                }
                                
                                // Name
                                Text(background.name)
                                    .font(AppFonts.body)
                                    .foregroundColor(.textPrimary)
                                
                                Spacer()
                                
                                // Checkmark if selected
                                if selectedBackground == background.id {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.softSage)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(
                                selectedBackground == background.id ?
                                Color.softSage.opacity(0.1) : Color.clear
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if background.id != backgrounds.last?.id {
                            Divider()
                                .padding(.leading, 74)
                        }
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

// MARK: - Settings Row

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.3))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppFonts.body)
                    .foregroundColor(.textPrimary)
                
                Text(subtitle)
                    .font(AppFonts.caption)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textTertiary)
        }
        .padding()
    }
}

// MARK: - Settings Toggle Row

struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.3))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .foregroundColor(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppFonts.body)
                    .foregroundColor(.textPrimary)
                
                Text(subtitle)
                    .font(AppFonts.caption)
                    .foregroundColor(.textSecondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}

