import Foundation

extension APIClient {
    
    /// Fetch today’s calendar entries for a cohort
    public func calendarToday(cohort: String) async throws -> [CalendarEntryResponseDTO] {
        let url = "calendar/today?cohort=\(cohort)"
        let result: [CalendarEntryResponseDTO] = try await request(url, method: "GET")
        return result
    }
    
    /// Fetch all calendar entries for a cohort
    public func calendarAll(cohort: String) async throws -> [CalendarEntryResponseDTO] {
        let url = "calendar?cohort=\(cohort)"
        let result: [CalendarEntryResponseDTO] = try await request(url, method: "GET")
        return result
    }
}
