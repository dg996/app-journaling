//
//  BackgroundViews.swift
//  Journaling
//
//  Sfondi decorativi per diverse sezioni
//

import SwiftUI

// MARK: - Bookshelf Background

struct BookshelfBackgroundView: View {
    var body: some View {
        ZStack {
            // Base background
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            // Shelves pattern
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        Spacer()
                        
                        // Shelf
                        Rectangle()
                            .fill(Color(red: 139/255, green: 90/255, blue: 43/255))
                            .opacity(0.06)
                            .frame(height: 3)
                        
                        // Books on shelf
                        HStack(spacing: 8) {
                            Spacer()
                                .frame(width: CGFloat.random(in: 20...60))
                            
                            ForEach(0..<Int.random(in: 3...6)) { _ in
                                BookSpine()
                            }
                            
                            Spacer()
                        }
                        .frame(height: 80)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .opacity(0.08)
            
            // Decorative elements
            VStack {
                HStack {
                    Spacer()
                    Text("🌿")
                        .font(.system(size: 40))
                        .opacity(0.2)
                        .padding()
                }
                .padding(.top, 60)
                
                Spacer()
                
                HStack {
                    Text("📚")
                        .font(.system(size: 35))
                        .opacity(0.15)
                        .padding()
                    
                    Spacer()
                }
                .padding(.bottom, 80)
            }
        }
    }
}

// MARK: - Book Spine Component

struct BookSpine: View {
    let colors: [Color] = [
        Color(red: 0.6, green: 0.5, blue: 0.4),
        Color(red: 0.5, green: 0.6, blue: 0.5),
        Color(red: 0.7, green: 0.6, blue: 0.5),
        Color(red: 0.5, green: 0.7, blue: 0.6),
        .softBeige,
        .softSage,
        .dustyRose
    ]
    
    var body: some View {
        Rectangle()
            .fill(colors.randomElement() ?? .softBeige)
            .opacity(0.3)
            .frame(width: CGFloat.random(in: 8...15), height: CGFloat.random(in: 60...75))
            .cornerRadius(1)
    }
}

// MARK: - Desk Background

struct DeskBackgroundView: View {
    var body: some View {
        ZStack {
            // Base
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            // Desk texture
            LinearGradient(
                colors: [
                    Color(red: 0.92, green: 0.88, blue: 0.85),
                    Color(red: 0.95, green: 0.92, blue: 0.90)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.3)
            .ignoresSafeArea()
            
            // Wood grain subtle lines
            VStack(spacing: 30) {
                ForEach(0..<15) { _ in
                    Rectangle()
                        .fill(Color.brown.opacity(0.02))
                        .frame(height: 1)
                }
            }
            
            // Decorative desk items
            VStack {
                Spacer()
                
                HStack(alignment: .bottom, spacing: 30) {
                    // Coffee cup
                    Text("☕️")
                        .font(.system(size: 45))
                        .opacity(0.15)
                    
                    Spacer()
                    
                    // Plant
                    Text("🪴")
                        .font(.system(size: 40))
                        .opacity(0.15)
                    
                    Spacer()
                    
                    // Pen
                    Text("✒️")
                        .font(.system(size: 35))
                        .opacity(0.12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
    }
}

// MARK: - Minimalist Pattern Background

struct PatternBackgroundView: View {
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            // Subtle dot pattern
            GeometryReader { geometry in
                Path { path in
                    let spacing: CGFloat = 30
                    let rows = Int(geometry.size.height / spacing) + 1
                    let cols = Int(geometry.size.width / spacing) + 1
                    
                    for row in 0..<rows {
                        for col in 0..<cols {
                            let x = CGFloat(col) * spacing
                            let y = CGFloat(row) * spacing
                            path.addEllipse(in: CGRect(x: x, y: y, width: 2, height: 2))
                        }
                    }
                }
                .fill(Color.textTertiary.opacity(0.1))
            }
        }
    }
}

// MARK: - Nature/Botanical Background

struct BotanicalBackgroundView: View {
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()
            
            // Subtle leaves pattern
            VStack(spacing: 80) {
                ForEach(0..<6) { row in
                    HStack(spacing: 60) {
                        ForEach(0..<4) { col in
                            Text(["🌿", "🍃", "🌱"].randomElement() ?? "🌿")
                                .font(.system(size: 25))
                                .opacity(0.08)
                                .rotationEffect(.degrees(Double.random(in: -30...30)))
                        }
                    }
                    .offset(x: row % 2 == 0 ? 30 : 0)
                }
            }
        }
    }
}

// MARK: - Cozy Reading Corner Background

struct ReadingCornerBackgroundView: View {
    var body: some View {
        ZStack {
            // Warm gradient base
            LinearGradient(
                colors: [
                    Color(red: 0.98, green: 0.97, blue: 0.95),
                    Color(red: 0.96, green: 0.94, blue: 0.92)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Corner lamp
            VStack {
                HStack {
                    Spacer()
                    Text("💡")
                        .font(.system(size: 50))
                        .opacity(0.12)
                        .padding(.top, 40)
                        .padding(.trailing, 30)
                }
                Spacer()
            }
            
            // Stack of books bottom left
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("📕")
                            .font(.system(size: 30))
                        Text("📗")
                            .font(.system(size: 30))
                            .offset(x: 5)
                        Text("📘")
                            .font(.system(size: 30))
                            .offset(x: -3)
                    }
                    .opacity(0.15)
                    .padding(.leading, 30)
                    .padding(.bottom, 50)
                    
                    Spacer()
                }
            }
            
            // Tea cup top left
            VStack {
                HStack {
                    Text("🍵")
                        .font(.system(size: 35))
                        .opacity(0.12)
                        .padding(.leading, 40)
                        .padding(.top, 80)
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// MARK: - Background Type Enum

enum BackgroundType: String, CaseIterable {
    case plain = "Semplice"
    case bookshelf = "Libreria"
    case desk = "Scrivania"
    case pattern = "Pattern"
    case botanical = "Botanico"
    case readingCorner = "Angolo Lettura"
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .plain:
            Color.backgroundPrimary
        case .bookshelf:
            BookshelfBackgroundView()
        case .desk:
            DeskBackgroundView()
        case .pattern:
            PatternBackgroundView()
        case .botanical:
            BotanicalBackgroundView()
        case .readingCorner:
            ReadingCornerBackgroundView()
        }
    }
}

#Preview("Bookshelf") {
    BookshelfBackgroundView()
}

#Preview("Desk") {
    DeskBackgroundView()
}

#Preview("Reading Corner") {
    ReadingCornerBackgroundView()
}

