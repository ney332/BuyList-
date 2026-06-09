//
//  AppBackgroundModifier.swift
//  Buy list
//
//  Created by Assistant on 02/03/26.
//

import SwiftUI

enum AppTheme {
    static let tint = Color(red: 0.21, green: 0.62, blue: 0.50)
    static let secondaryTint = Color(red: 0.34, green: 0.56, blue: 0.90)
    static let cardFill = Color.white.opacity(0.68)
    static let cardStroke = Color.white.opacity(0.55)
    static let shadow = Color.black.opacity(0.08)
    static let success = Color.green
    static let warning = Color.orange
    static let danger = Color.red
}

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(uiColor: .systemGroupedBackground),
                    Color(red: 0.92, green: 0.97, blue: 0.95),
                    Color(red: 0.89, green: 0.93, blue: 0.99)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Circle()
                .fill(AppTheme.tint.opacity(0.14))
                .frame(width: 240, height: 240)
                .blur(radius: 20)
                .offset(x: 120, y: -280)

            Circle()
                .fill(AppTheme.secondaryTint.opacity(0.12))
                .frame(width: 280, height: 280)
                .blur(radius: 24)
                .offset(x: -140, y: 260)

            content
        }
    }
}

struct GlassCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(18)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(AppTheme.cardFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(AppTheme.cardStroke, lineWidth: 1)
            )
            .shadow(color: AppTheme.shadow, radius: 20, x: 0, y: 12)
    }
}

struct SectionTitle: View {
    let title: String
    let subtitle: String?

    init(_ title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MetricTile: View {
    let label: String
    let value: String
    let systemImage: String
    var tint: Color = AppTheme.tint

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: systemImage)
                    .font(.headline)
                    .foregroundStyle(tint)

                Text(value)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)

                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PrimaryCapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(AppTheme.tint.gradient)
            )
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.92 : 1)
    }
}

extension View {
    func appBackground() -> some View {
        modifier(AppBackgroundModifier())
    }
}
