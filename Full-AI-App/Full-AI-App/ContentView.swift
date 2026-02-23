//
//  ContentView.swift
//  Full-AI-App
//
//  Created by Zachary Jensen on 2/4/26.
//

import SwiftUI

#if os(iOS)
import AudioToolbox
#endif

// MARK: - App State

@Observable
final class InspireModel {
    var quotes: [Quote] = defaultQuotes
    var currentIndex: Int = Int.random(in: 0..<defaultQuotes.count)
    var favorites: [Quote] = []
    var history: [Quote] = []

    var inspirationsCount: Int = 0
    var hapticsEnabled: Bool = true
    var soundEnabled: Bool = true
    var autoSaveSharedImage: Bool = false
    var backgroundStyle: BackgroundStyle = .liquid

    private let defaults = UserDefaults.standard
    private let favoritesKey = "favorites_data"
    private let historyKey = "history_data"
    private let dailyQuoteIDKey = "daily_quote_id"
    private let dailyQuoteDateKey = "daily_quote_date"

    var current: Quote { quotes[currentIndex] }

    init() {
        loadPersistence()
        setupDailyQuoteIfNeeded()
    }

    func shuffle() {
        if hapticsEnabled {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.7)
            #endif
        }
        var newIndex = currentIndex
        repeat {
            newIndex = Int.random(in: 0..<quotes.count)
        } while newIndex == currentIndex && quotes.count > 1
        currentIndex = newIndex
        inspirationsCount += 1
        if [5, 10, 25, 50, 100].contains(inspirationsCount) {
            NotificationCenter.default.post(name: .inspireAchievement, object: inspirationsCount)
        }
        history.insert(current, at: 0)
        if history.count > 50 { history.removeLast(history.count - 50) }
        persist()
    }

    func toggleFavorite() {
        if let i = favorites.firstIndex(of: current) {
            favorites.remove(at: i)
        } else {
            favorites.insert(current, at: 0)
        }
        persist()
    }

    func removeFavorite(_ quote: Quote) {
        favorites.removeAll { $0 == quote }
        persist()
    }

    func clearHistory() {
        history.removeAll()
        persist()
    }

    func randomizeBackground() {
        if let newStyle = BackgroundStyle.allCases.randomElement() { backgroundStyle = newStyle }
    }

    func saveNow() { persist() }

    private func loadPersistence() {
        if let favsData = defaults.data(forKey: favoritesKey),
           let decodedFavs = try? JSONDecoder().decode([Quote].self, from: favsData) {
            favorites = decodedFavs
        }
        if let histData = defaults.data(forKey: historyKey),
           let decodedHist = try? JSONDecoder().decode([Quote].self, from: histData) {
            history = decodedHist
        }
    }

    private func persist() {
        if let favs = try? JSONEncoder().encode(favorites) { defaults.set(favs, forKey: favoritesKey) }
        if let hist = try? JSONEncoder().encode(history) { defaults.set(hist, forKey: historyKey) }
    }

    private func setupDailyQuoteIfNeeded() {
        let calendar = Calendar.current
        let lastTime = defaults.double(forKey: dailyQuoteDateKey)
        let lastDate = Date(timeIntervalSince1970: lastTime)
        let storedID = defaults.string(forKey: dailyQuoteIDKey)
        if !calendar.isDateInToday(lastDate) || storedID == nil {
            defaults.set(current.id.uuidString, forKey: dailyQuoteIDKey)
            defaults.set(Date().timeIntervalSince1970, forKey: dailyQuoteDateKey)
        }
    }

    var todaysQuote: Quote? {
        guard let idString = defaults.string(forKey: dailyQuoteIDKey), let uuid = UUID(uuidString: idString) else { return nil }
        return (quotes + favorites).first { $0.id == uuid }
    }
    
    var dailyStreak: Int {
        let calendar = Calendar.current
        let lastTime = defaults.double(forKey: dailyQuoteDateKey)
        let lastDate = Date(timeIntervalSince1970: lastTime)
        if calendar.isDateInToday(lastDate) {
            return defaults.integer(forKey: "daily_streak")
        } else {
            // Increment if yesterday, otherwise reset
            if let yesterday = calendar.date(byAdding: .day, value: -1, to: Date()), calendar.isDate(lastDate, inSameDayAs: yesterday) {
                let newVal = defaults.integer(forKey: "daily_streak") + 1
                defaults.set(newVal, forKey: "daily_streak")
                defaults.set(Date().timeIntervalSince1970, forKey: dailyQuoteDateKey)
                return newVal
            } else {
                defaults.set(1, forKey: "daily_streak")
                defaults.set(Date().timeIntervalSince1970, forKey: dailyQuoteDateKey)
                return 1
            }
        }
    }

    enum BackgroundStyle: String, CaseIterable, Identifiable {
        case liquid, rainbow, dark
        var id: String { rawValue }
    }
}

// MARK: - Root View

struct ContentView: View {
    @State private var model = InspireModel()

    var body: some View {
        TabView {
            InspireTab(model: model)
                .tabItem { Label("Inspire", systemImage: "sparkles") }

            FavoritesTab(model: model)
                .tabItem { Label("Favorites", systemImage: "heart.fill") }

            ComposeTab(model: model)
                .tabItem { Label("Compose", systemImage: "plus.bubble") }

            SettingsTab(model: model)
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
    }
}

// MARK: - Inspire Tab

struct InspireTab: View {
    @Bindable var model: InspireModel
    @State private var spin = false
    @State private var gradientPhase: CGFloat = 0.0
    @State private var isPressed = false
    @State private var showShare = false
    @State private var showConfetti = false
    @State private var showHistory = false
    @State private var showAchievement = false
    @State private var shareImage: UIImage? = nil

    var body: some View {
        ZStack {
            backgroundView
                .ignoresSafeArea()

            VStack(spacing: 24) {
                header

                if let today = model.todaysQuote {
                    DailyQuoteBanner(quote: today)
                }

                Spacer(minLength: 0)
                QuoteCard(quote: model.current)
                    .rotation3DEffect(.degrees(spin ? 360 : 0), axis: (x: 0.1, y: 1, z: 0), perspective: 0.6)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.2), value: spin)
                    .onLongPressGesture(minimumDuration: 0.4) {
                        model.toggleFavorite()
                        #if os(iOS)
                        if model.hapticsEnabled { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
                        #endif
                    }

                controls
                historyList
            }
            .padding()
        }
        .overlay(alignment: .top) {
            if showConfetti { ConfettiView().transition(.opacity) }
        }
        .overlay(alignment: .top) {
            if showAchievement { AchievementBanner().transition(.move(edge: .top).combined(with: .opacity)) }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                gradientPhase = 1.0
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .inspireAchievement)) { _ in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) { showAchievement = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { withAnimation { showAchievement = false } }
        }
        .sheet(isPresented: $showShare) {
            if let img = shareImage {
                ActivityView(text: "", image: img)
            } else {
                let text = "\"\(model.current.text)\" — \(model.current.author) \(model.current.emoji)"
                ActivityView(text: text)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showHistory = true } label: { Image(systemName: "clock.arrow.circlepath") }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button { model.randomizeBackground() } label: { Image(systemName: "paintpalette") }
            }
        }
        .sheet(isPresented: $showHistory) { HistorySheet(model: model) }
    }

    private var backgroundView: some View {
        Group {
            switch model.backgroundStyle {
            case .liquid:
                AnimatedBackground(phase: gradientPhase)
            case .rainbow:
                AngularGradient(gradient: Gradient(colors: stride(from: 0.0, to: 1.0, by: 0.1).map { Color(hue: $0, saturation: 0.8, brightness: 0.95) }), center: .center)
                    .blur(radius: 40)
            case .dark:
                LinearGradient(colors: [.black, .gray.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("InspireMe")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundStyle(.white.opacity(0.95))
                .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)

            Text("Streak: \(model.dailyStreak) day\(model.dailyStreak == 1 ? "" : "s") • A tiny burst of joy, every tap.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.top, 8)
    }

    private var controls: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button {
                    model.toggleFavorite()
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { showConfetti = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { withAnimation { showConfetti = false } }
                } label: {
                    Image(systemName: model.favorites.contains(model.current) ? "heart.fill" : "heart")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay { Circle().strokeBorder(.white.opacity(0.35), lineWidth: 1) }
                }
                .accessibilityLabel("Toggle favorite")

                Button {
                    #if os(iOS)
                    let card = QuoteCard(quote: model.current)
                        .padding()
                        .background(AnimatedBackground(phase: gradientPhase))
                    shareImage = card.snapshotImage()
                    if model.autoSaveSharedImage, let img = shareImage {
                        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                    }
                    #endif
                    showShare = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay { Circle().strokeBorder(.white.opacity(0.35), lineWidth: 1) }
                }
                .accessibilityLabel("Share quote")

                Button {
                    #if os(iOS)
                    UIPasteboard.general.string = "\"\(model.current.text)\" — \(model.current.author) \(model.current.emoji)"
                    #endif
                } label: {
                    Image(systemName: "doc.on.doc")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay { Circle().strokeBorder(.white.opacity(0.35), lineWidth: 1) }
                }
                .accessibilityLabel("Copy quote")

                Spacer()

                Button {
                    shuffle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "sparkles")
                        Text("Inspire Me")
                            .fontWeight(.semibold)
                    }
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay { Capsule().strokeBorder(.white.opacity(0.35), lineWidth: 1) }
                    .scaleEffect(isPressed ? 0.96 : 1.0)
                }
                .buttonStyle(.plain)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in withAnimation(.spring(response: 0.2)) { isPressed = true } }
                        .onEnded { _ in withAnimation(.spring(response: 0.2)) { isPressed = false } }
                )
            }

            Text("Inspirations this session: \(model.inspirationsCount)")
                .font(.footnote.monospacedDigit())
                .foregroundStyle(.white.opacity(0.9))
                .padding(.top, 2)
        }
    }

    private var historyList: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !model.history.isEmpty {
                Text("History")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 8)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(model.history.prefix(12)) { item in
                            Text(item.emoji)
                                .font(.title3)
                                .padding(8)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .overlay { RoundedRectangle(cornerRadius: 10).strokeBorder(.white.opacity(0.25), lineWidth: 1) }
                                .accessibilityLabel("\(item.text) by \(item.author)")
                        }
                    }
                }
            }
        }
    }

    private func shuffle() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            spin.toggle()
        }
        model.shuffle()
        #if os(iOS)
        if model.soundEnabled { AudioServicesPlaySystemSound(1104) }
        #endif
    }
}

// MARK: - Favorites Tab

struct FavoritesTab: View {
    @Bindable var model: InspireModel
    @State private var query: String = ""

    var body: some View {
        NavigationStack {
            Group {
                if model.favorites.isEmpty {
                    ContentUnavailableView("No Favorites Yet", systemImage: "heart", description: Text("Save quotes you love and they’ll appear here."))
                } else {
                    List {
                        Section {
                            ForEach(model.favorites.filter { query.isEmpty ? true : ($0.text.localizedCaseInsensitiveContains(query) || $0.author.localizedCaseInsensitiveContains(query)) }) { quote in
                                FavoriteRow(quote: quote) {
                                    model.removeFavorite(quote)
                                }
                                .listRowBackground(Color.clear)
                            }
                            .onDelete { indexSet in
                                for index in indexSet { model.favorites.remove(at: index) }
                            }
                            .onMove { indices, newOffset in
                                model.favorites.move(fromOffsets: indices, toOffset: newOffset)
                                model.saveNow()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(LinearGradient(colors: [Color.black.opacity(0.9), Color.purple.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                }
            }
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search favorites")
            .navigationTitle("Favorites")
            .toolbar { EditButton() }
        }
    }
}

private struct FavoriteRow: View {
    let quote: Quote
    let onRemove: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(quote.emoji)
                .font(.title2)
            VStack(alignment: .leading, spacing: 6) {
                Text("\"\(quote.text)\"")
                    .font(.body)
                Text("— \(quote.author)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(role: .destructive, action: onRemove) {
                Image(systemName: "trash")
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Compose Tab

struct ComposeTab: View {
    @Bindable var model: InspireModel
    @State private var text: String = ""
    @State private var author: String = ""
    @State private var emoji: String = "✨"
    @State private var showAlert = false

    private let emojis = ["✨","🌟","🔥","💡","🚀","🎯","🌈","🎨","⚡️","💖","🍀","🧠"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Quote") {
                    TextField("What’s the inspiration?", text: $text, axis: .vertical)
                        .lineLimit(2...5)
                    TextField("Author", text: $author)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(emojis, id: \.self) { e in
                                Text(e)
                                    .font(.title2)
                                    .padding(6)
                                    .background(emoji == e ? Color.accentColor.opacity(0.2) : Color.clear, in: RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture { emoji = e }
                            }
                        }
                    }
                }
                Section {
                    Button {
                        addQuote()
                    } label: {
                        Label("Add to Favorites", systemImage: "heart.fill")
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationTitle("Compose")
            .alert("Please enter a quote", isPresented: $showAlert) { Button("OK", role: .cancel) {} }
        }
    }

    private func addQuote() {
        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !t.isEmpty else { showAlert = true; return }
        let a = author.trimmingCharacters(in: .whitespacesAndNewlines)
        let q = Quote(text: t, author: a.isEmpty ? "Unknown" : a, emoji: emoji)
        model.favorites.insert(q, at: 0)
        model.saveNow()
        text = ""; author = ""; emoji = "✨"
    }
}

// MARK: - Settings Tab

struct SettingsTab: View {
    @Bindable var model: InspireModel

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Haptics", isOn: $model.hapticsEnabled)
                    Toggle("Sound Effects", isOn: $model.soundEnabled)
                    #if os(iOS)
                    Toggle("Auto-Save Shared Image", isOn: $model.autoSaveSharedImage)
                    #endif
                    Picker("Background", selection: $model.backgroundStyle) {
                        ForEach(InspireModel.BackgroundStyle.allCases) { style in
                            Text(style.rawValue.capitalized).tag(style)
                        }
                    }
                }

                Section("About") {
                    LabeledContent("Version", value: "1.0")
                    LabeledContent("Made with", value: "SwiftUI ❤️")
                }
                
                Section("Streaks") {
                    Button("Reset Streak", role: .destructive) {
                        UserDefaults.standard.set(0, forKey: "daily_streak")
                        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "daily_quote_date")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Components

private struct QuoteCard: View {
    let quote: Quote

    var body: some View {
        VStack(spacing: 16) {
            Text(quote.emoji)
                .font(.system(size: 56))
                .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 3)

            Text("“\(quote.text)”")
                .multilineTextAlignment(.center)
                .font(.system(.title2, design: .serif, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.35), radius: 10, x: 0, y: 6)

            Text("— \(quote.author)")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 28)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(LinearGradient(colors: [.white.opacity(0.35), .clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

private struct AnimatedBackground: View {
    var phase: CGFloat

    var body: some View {
        TimelineView(.animation) { _ in
            LinearGradient(
                colors: [
                    Color(hue: 0.60, saturation: 0.75, brightness: 0.95),
                    Color(hue: 0.83, saturation: 0.70, brightness: 0.95),
                    Color(hue: 0.97, saturation: 0.80, brightness: 0.95),
                    Color(hue: 0.10, saturation: 0.85, brightness: 0.98)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(Double(phase) * 90))
            .saturation(1.05)
            .overlay {
                RadialGradient(
                    colors: [
                        .white.opacity(0.10),
                        .clear
                    ],
                    center: .init(x: 0.7, y: 0.3),
                    startRadius: 10,
                    endRadius: 500
                )
            }
        }
    }
}

private struct DailyQuoteBanner: View {
    let quote: Quote
    var body: some View {
        HStack(spacing: 12) {
            Text("📅")
            VStack(alignment: .leading, spacing: 2) {
                Text("Today’s Quote")
                    .font(.caption.weight(.semibold))
                Text("\"\(quote.text)\"")
                    .font(.footnote)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay { RoundedRectangle(cornerRadius: 14).strokeBorder(.white.opacity(0.3), lineWidth: 1) }
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}

private struct ConfettiView: View {
    @State private var particles: [Confetti] = (0..<24).map { _ in Confetti.random() }
    var body: some View {
        ZStack {
            ForEach(particles) { p in
                Circle()
                    .fill(p.color)
                    .frame(width: p.size, height: p.size)
                    .offset(x: p.x, y: p.y)
                    .opacity(p.opacity)
                    .animation(.interpolatingSpring(stiffness: 60, damping: 8).delay(p.delay), value: p.id)
            }
        }
        .onAppear {
            for i in particles.indices {
                particles[i].explode()
            }
        }
        .frame(height: 140)
        .padding(.top, 8)
    }
}

private struct Confetti: Identifiable {
    let id = UUID()
    var x: CGFloat = 0
    var y: CGFloat = 0
    var size: CGFloat
    var color: Color
    var opacity: Double = 1
    var delay: Double

    static func random() -> Confetti {
        Confetti(size: .random(in: 6...12), color: [.pink, .yellow, .mint, .orange, .purple, .blue].randomElement()!, delay: .random(in: 0...0.3))
    }

    mutating func explode() {
        x = .random(in: -160...160)
        y = .random(in: 40...140)
        opacity = .random(in: 0.6...1)
    }
}

// MARK: - Extended Components

private struct HistorySheet: View {
    @Bindable var model: InspireModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                if model.history.isEmpty {
                    ContentUnavailableView("No History", systemImage: "clock", description: Text("Shuffle to build your inspiration trail."))
                } else {
                    ForEach(model.history) { q in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(q.emoji + "  \"" + q.text + "\"")
                            Text("— " + q.author).font(.caption).foregroundStyle(.secondary)
                        }
                        .contextMenu {
                            Button { UIPasteboard.general.string = "\"\(q.text)\" — \(q.author) \(q.emoji)" } label: { Label("Copy", systemImage: "doc.on.doc") }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Close") { dismiss() } }
                ToolbarItem(placement: .topBarTrailing) { Button("Clear", role: .destructive) { model.clearHistory() } }
            }
        }
    }
}

private struct AchievementBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "rosette")
                .symbolRenderingMode(.multicolor)
                .font(.title3)
            Text("Milestone reached! Keep going ✨")
                .font(.subheadline.weight(.semibold))
        }
        .padding(12)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay { Capsule().strokeBorder(.white.opacity(0.3), lineWidth: 1) }
        .padding(.top, 12)
    }
}

// MARK: - Share Sheet (UIKit wrapper)

#if os(iOS)
import UIKit
private struct ActivityView: UIViewControllerRepresentable {
    let text: String
    var image: UIImage? = nil
    func makeUIViewController(context: Context) -> UIActivityViewController {
        var items: [Any] = []
        if !text.isEmpty { items.append(text) }
        if let image { items.append(image) }
        return UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
#else
private struct ActivityView: View { let text: String; var body: some View { Text(text) } }
#endif

// MARK: - Notification Extension

private extension Notification.Name {
    static let inspireAchievement = Notification.Name("inspire_achievement")
}

#if os(iOS)
private extension View {
    func snapshotImage() -> UIImage {
        let controller = UIHostingController(rootView: self.ignoresSafeArea())
        let view = controller.view
        let targetSize = CGSize(width: 600, height: 600)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true) }
    }
}
#endif

// MARK: - Model

struct Quote: Identifiable, Hashable, Equatable, Codable {
    let id = UUID()
    let text: String
    let author: String
    let emoji: String
}

private let defaultQuotes: [Quote] = [
    Quote(text: "Creativity is intelligence having fun.", author: "Albert Einstein", emoji: "🎨"),
    Quote(text: "Stay hungry. Stay foolish.", author: "Steve Jobs", emoji: "🍏"),
    Quote(text: "What you do today can improve all your tomorrows.", author: "Ralph Marston", emoji: "🌅"),
    Quote(text: "Simplicity is the ultimate sophistication.", author: "Leonardo da Vinci", emoji: "✨"),
    Quote(text: "Make it work, make it right, make it fast.", author: "Kent Beck", emoji: "⚡️"),
    Quote(text: "The only limit to our realization of tomorrow is our doubts of today.", author: "Franklin D. Roosevelt", emoji: "🚀"),
    Quote(text: "Small steps every day.", author: "Unknown", emoji: "👣"),
    Quote(text: "Focus on the step in front of you, not the whole staircase.", author: "Unknown", emoji: "🧗‍♀️"),
    Quote(text: "You don’t have to be extreme, just consistent.", author: "Unknown", emoji: "📈"),
    Quote(text: "Dream big. Start small. Act now.", author: "Robin Sharma", emoji: "🌟")
]

#Preview {
    ContentView()
}
