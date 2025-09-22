// MARK: - Song Type

struct Song {
    let title: String
    let artist: String
    let duration: Int // Duration in seconds
}

// MARK: - Playlist

class Playlist {
    let name: String
    private var songs: [Song] = []
    private var currentIndex: Int?
    
    init(name: String) {
        self.name = name
    }
    
    // Add a song
    func add(_ song: Song) {
        songs.append(song)
        if songs.count == 1 {
            currentIndex = 0
        }
    }
    
    // Remove song at index
    func remove(at index: Int) {
        guard songs.indices.contains(index) else { return }
        songs.remove(at: index)
        if let curr = currentIndex, curr == index {
            currentIndex = nil
        } else if let curr = currentIndex, curr > index {
            currentIndex = curr - 1
        }
    }
    
    // Clear all songs
    func clear() {
        songs.removeAll()
        currentIndex = nil
    }
    
    // Get the number of songs
    var count: Int {
        songs.count
    }
    
    // Get all songs
    func allSongs() -> [Song] {
        songs
    }
    
    // Total duration
    func totalDuration() -> Int {
        songs.reduce(0) { $0 + $1.duration }
    }
    
    // Get the current song
    func currentSong() -> Song? {
        guard let idx = currentIndex, songs.indices.contains(idx) else { return nil }
        return songs[idx]
    }
    
    // Play a specific song
    func play(at index: Int) -> Song? {
        guard songs.indices.contains(index) else { return nil }
        currentIndex = index
        return songs[index]
    }
    
    // Play next song
    func playNext() -> Song? {
        guard let curr = currentIndex, songs.indices.contains(curr + 1) else { return nil }
        currentIndex = curr + 1
        return songs[currentIndex!]
    }
    
    // Play previous song
    func playPrevious() -> Song? {
        guard let curr = currentIndex, curr > 0, songs.indices.contains(curr - 1) else { return nil }
        currentIndex = curr - 1
        return songs[currentIndex!]
    }
    
    // Shuffle playlist
    func shuffle() {
        songs.shuffle()
        currentIndex = songs.isEmpty ? nil : 0
    }
}

// MARK: - Playlist Manager

class PlaylistManager {
    private var playlists: [Playlist] = []
    
    // Add playlist
    func add(_ playlist: Playlist) {
        playlists.append(playlist)
    }
    
    // Remove playlist at index
    func removePlaylist(at index: Int) {
        guard playlists.indices.contains(index) else { return }
        playlists.remove(at: index)
    }
    
    // Get playlist at index
    func playlist(at index: Int) -> Playlist? {
        playlists.indices.contains(index) ? playlists[index] : nil
    }
    
    // Get all playlists
    func allPlaylists() -> [Playlist] {
        playlists
    }
    
    // Number of playlists
    var count: Int {
        playlists.count
    }
}

// MARK: - Example Usage

// Create some songs
let song1 = Song(title: "Stargazing", artist: "Miles Smith", duration: 200)
let song2 = Song(title: "Never Gonna Give You Up", artist: "Rick Astley", duration: 215)
let song3 = Song(title: "Bohemian Rhapsody", artist: "Queen", duration: 355)
let song4 = Song(title: "Blinding Lights", artist: "The Weeknd", duration: 200)
let song5 = Song(title: "Hotel California", artist: "Eagles", duration: 390)

// Create playlists
let chillPlaylist = Playlist(name: "Chill Vibes")
let workoutPlaylist = Playlist(name: "Workout Mix")

// Add songs to playlists
chillPlaylist.add(song1)
chillPlaylist.add(song4)
chillPlaylist.add(song3)

workoutPlaylist.add(song2)
workoutPlaylist.add(song5)
workoutPlaylist.add(song3)

// Create a playlist manager and add the playlists
let manager = PlaylistManager()
manager.add(chillPlaylist)
manager.add(workoutPlaylist)

// Print playlists and their songs
for (i, playlist) in manager.allPlaylists().enumerated() {
    print("Playlist \(i + 1): \(playlist.name)")
    for song in playlist.allSongs() {
        print("  - \(song.title) by \(song.artist) [\(song.duration) seconds]")
    }
    print("  Total duration: \(playlist.totalDuration()) seconds")
}

// Play songs in a playlist
if let myPlaylist = manager.playlist(at: 0) {
    print("\nNow playing from '\(myPlaylist.name)':")
    if let first = myPlaylist.currentSong() {
        print("Now playing: \(first.title) by \(first.artist)")
    }
    while let next = myPlaylist.playNext() {
        print("Now playing: \(next.title) by \(next.artist)")
    }
    print("End of playlist.")
}










