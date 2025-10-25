//
//  AppColors.swift
//  Journaling
//
//  Created on 2025-10-25
//

import SwiftUI

// Palette di colori minimalista ed elegante
extension Color {
    // Colori primari - toni neutri e morbidi
    static let softBeige = Color(red: 245/255, green: 240/255, blue: 235/255)
    static let warmCream = Color(red: 250/255, green: 248/255, blue: 245/255)
    static let softGray = Color(red: 220/255, green: 220/255, blue: 220/255)
    static let charcoalGray = Color(red: 60/255, green: 60/255, blue: 60/255)
    
    // Colori secondari - accenti delicati
    static let softSage = Color(red: 220/255, green: 230/255, blue: 220/255)
    static let dustyRose = Color(red: 235/255, green: 220/255, blue: 225/255)
    static let softLavender = Color(red: 230/255, green: 225/255, blue: 240/255)
    static let paleBlue = Color(red: 225/255, green: 235/255, blue: 245/255)
    
    // Colori per il testo
    static let textPrimary = Color(red: 40/255, green: 40/255, blue: 40/255)
    static let textSecondary = Color(red: 120/255, green: 120/255, blue: 120/255)
    static let textTertiary = Color(red: 160/255, green: 160/255, blue: 160/255)
    
    // Background
    static let backgroundPrimary = Color(red: 252/255, green: 252/255, blue: 250/255)
}

// Stili personalizzati
struct AppFonts {
    static let largeTitle = Font.system(size: 32, weight: .light, design: .serif)
    static let title = Font.system(size: 24, weight: .light, design: .serif)
    static let headline = Font.system(size: 18, weight: .medium, design: .rounded)
    static let body = Font.system(size: 16, weight: .regular, design: .rounded)
    static let caption = Font.system(size: 14, weight: .light, design: .rounded)
}

