//
//  SidebarView.swift
//  Journaling
//
//  Sidebar navigation elegante
//

import SwiftUI

struct SidebarView: View {
    @Binding var selectedSection: NavigationSection
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background con blur
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Sidebar
                SidebarHeader()
                
                // Menu Items
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(NavigationSection.allCases, id: \.self) { section in
                            SidebarMenuItem(
                                section: section,
                                isSelected: selectedSection == section,
                                action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        selectedSection = section
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
                
                Spacer()
                
                // Footer con settings e info
                SidebarFooter()
            }
        }
    }
}

// MARK: - Navigation Sections

enum NavigationSection: String, CaseIterable {
    case home = "Home"
    // Temporaneamente nascosti - da implementare
    // case moodTracker = "Mood Tracker"
    // case gratitude = "Gratitudine"
    // case prompts = "Prompts"
    // case habits = "Abitudini"
    // case analytics = "Statistiche"
    // case templates = "Template"
    // case settings = "Impostazioni"
    
    var icon: String {
        switch self {
        case .home:
            return "book.closed.fill"
        case .moodTracker:
            return "face.smiling.fill"
        case .gratitude:
            return "heart.fill"
        case .prompts:
            return "lightbulb.fill"
        case .habits:
            return "checkmark.circle.fill"
        case .analytics:
            return "chart.bar.fill"
        case .templates:
            return "square.grid.2x2.fill"
        case .settings:
            return "gearshape.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .charcoalGray
        case .moodTracker:
            return Color(red: 1.0, green: 0.8, blue: 0.0)
        case .gratitude:
            return .dustyRose
        case .prompts:
            return .softLavender
        case .habits:
            return .softSage
        case .analytics:
            return .paleBlue
        case .templates:
            return .softBeige
        case .settings:
            return .textSecondary
        }
    }
}

// MARK: - Sidebar Header

struct SidebarHeader: View {
    var body: some View {
        VStack(spacing: 16) {
            // App Icon/Logo
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.softLavender, Color.dustyRose],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                
                Image(systemName: "book.pages.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
            .padding(.top, 60)
            
            // App Name
            VStack(spacing: 4) {
                Text("Journaling")
                    .font(AppFonts.title)
                    .foregroundColor(.textPrimary)
                
                Text("Crescita & Gratitudine")
                    .font(AppFonts.caption)
                    .foregroundColor(.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)
        .background(
            Color.white.opacity(0.5)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

// MARK: - Sidebar Menu Item

struct SidebarMenuItem: View {
    let section: NavigationSection
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(section.color.opacity(0.2))
                            .frame(width: 44, height: 44)
                    }
                    
                    Image(systemName: section.icon)
                        .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? section.color : .textSecondary)
                        .frame(width: 44, height: 44)
                }
                
                // Label
                Text(section.rawValue)
                    .font(isSelected ? AppFonts.headline : AppFonts.body)
                    .foregroundColor(isSelected ? .textPrimary : .textSecondary)
                
                Spacer()
                
                // Selection Indicator
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(section.color)
                        .frame(width: 4, height: 24)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.white : Color.clear)
                    .shadow(
                        color: isSelected ? Color.black.opacity(0.06) : Color.clear,
                        radius: 8,
                        x: 0,
                        y: 2
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Sidebar Footer

struct SidebarFooter: View {
    var body: some View {
        VStack(spacing: 12) {
            Divider()
                .padding(.horizontal)
            
            // User Profile (future implementation)
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.softLavender)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Il Mio Profilo")
                        .font(AppFonts.body)
                        .foregroundColor(.textPrimary)
                    
                    Text("Journaling da 12 giorni")
                        .font(AppFonts.caption)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Main Content with Sidebar

struct MainContentView: View {
    @State private var selectedSection: NavigationSection = .home
    @State private var showingSidebar = false
    @EnvironmentObject var journalStore: JournalStore
    
    var body: some View {
        NavigationView {
            // Sidebar
            SidebarView(selectedSection: $selectedSection)
                .frame(width: 280)
            
            // Main Content
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                // Solo Home per ora
                HomeContentView()
            }
        }
        .navigationViewStyle(.columns)
    }
}

// MARK: - Home Content (existing ContentView content)

struct HomeContentView: View {
    @EnvironmentObject var journalStore: JournalStore
    @State private var showingAddJournal = false
    @AppStorage("selectedBackground") private var selectedBackgroundString: String = "bookshelf"
    
    private var selectedBackground: BackgroundType {
        switch selectedBackgroundString {
        case "plain":
            return .plain
        case "bookshelf":
            return .bookshelf
        case "desk":
            return .desk
        case "botanical":
            return .botanical
        case "readingCorner":
            return .readingCorner
        default:
            return .bookshelf
        }
    }
    
    var body: some View {
        ZStack {
            // Background decorativo (da settings) - extends behind nav bar
            selectedBackground.view()
                .ignoresSafeArea(.all, edges: .all)
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    HeaderView()
                    
                    // Griglia dei diari
                    if journalStore.journals.isEmpty {
                        EmptyStateView()
                    } else {
                        JournalGridView()
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal)
            }
            
            // Pulsante floating
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    AddJournalButton(showingAddJournal: $showingAddJournal)
                }
                .padding(.trailing, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("I Miei Journals")
                    .font(AppFonts.headline)
                    .foregroundColor(.textPrimary)
                    .shadow(color: Color.white.opacity(0.8), radius: 3, x: 0, y: 1)
            }
        }
        .sheet(isPresented: $showingAddJournal) {
            AddJournalView(isPresented: $showingAddJournal)
        }
    }
}

// MARK: - Placeholder Views (da implementare)

struct MoodTrackerPlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "face.smiling.fill",
            title: "Mood Tracker",
            subtitle: "Traccia il tuo umore quotidiano",
            color: Color(red: 1.0, green: 0.8, blue: 0.0)
        )
    }
}

struct GratitudePlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "heart.fill",
            title: "Gratitudine",
            subtitle: "Coltiva gratitudine ogni giorno",
            color: .dustyRose
        )
    }
}

struct PromptsPlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "lightbulb.fill",
            title: "Journaling Prompts",
            subtitle: "21 domande per la riflessione",
            color: .softLavender
        )
    }
}

struct HabitsPlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "checkmark.circle.fill",
            title: "Habit Tracker",
            subtitle: "Traccia le tue abitudini",
            color: .softSage
        )
    }
}

struct AnalyticsPlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "chart.bar.fill",
            title: "Statistiche",
            subtitle: "Insights sul tuo journaling",
            color: .paleBlue
        )
    }
}

struct TemplatesPlaceholder: View {
    var body: some View {
        PlaceholderView(
            icon: "square.grid.2x2.fill",
            title: "Template",
            subtitle: "8 template per ogni esigenza",
            color: .softBeige
        )
    }
}

struct SettingsContentView: View {
    var body: some View {
        SettingsView()
    }
}

// MARK: - Generic Placeholder

struct PlaceholderView: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 120, height: 120)
                
                Image(systemName: icon)
                    .font(.system(size: 48))
                    .foregroundColor(color)
            }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(AppFonts.largeTitle)
                    .foregroundColor(.textPrimary)
                
                Text(subtitle)
                    .font(AppFonts.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Text("🚧 In sviluppo")
                .font(AppFonts.caption)
                .foregroundColor(.textTertiary)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.softBeige)
                .cornerRadius(20)
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    MainContentView()
        .environmentObject(JournalStore())
}

