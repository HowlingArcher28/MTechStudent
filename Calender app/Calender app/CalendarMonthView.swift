import SwiftUI

struct CalendarMonthView: View {
    @EnvironmentObject private var eventStore: LocalEventStore
    @StateObject private var viewModel = CalendarViewModel()

    @State private var showingDayDetail = false

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

    var body: some View {
        VStack(spacing: 8) {
            header
            weekdayHeader
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(viewModel.days) { day in
                    DayCellView(
                        date: day.date,
                        isCurrentMonth: day.isCurrentMonth,
                        isToday: day.isToday,
                        isSelected: viewModel.selectedDate.map { Calendar.current.isDate($0, inSameDayAs: day.date) } ?? false,
                        eventCount: eventStore.events(on: day.date).count
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedDate = day.date
                        showingDayDetail = true
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .sheet(isPresented: $showingDayDetail) {
            if let selected = viewModel.selectedDate {
                NavigationStack {
                    DayDetailView(date: selected)
                        .environmentObject(eventStore)
                }
            }
        }
        .padding(.top, 8)
    }

    private var header: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) { viewModel.goToPreviousMonth() }
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(viewModel.monthTitle)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)

            Spacer()

            Button {
                withAnimation(.easeInOut) { viewModel.goToNextMonth() }
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Today") {
                    withAnimation(.easeInOut) { viewModel.goToToday() }
                }
            }
        }
    }

    private var weekdayHeader: some View {
        HStack {
            ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                Text(symbol.uppercased())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
    }
}
