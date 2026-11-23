import SwiftUI
import Combine

final class MyListManager: ObservableObject {
    
    static let shared = MyListManager()
    
    @Published var savedMovies: [SavedMovie] = []
    
    private init() {}
    
    func isSaved(_ movie: SavedMovie) -> Bool {
        savedMovies.contains { $0.title == movie.title }
    }
    
    func add(_ movie: SavedMovie) {
        if !isSaved(movie) {
            savedMovies.append(movie)
        }
    }
    
    func remove(_ movie: SavedMovie) {
        savedMovies.removeAll {
            $0.title == movie.title
        }
    }
    
    func toggle(_ movie: SavedMovie) {
        if isSaved(movie) {
            remove(movie)
        } else {
            add(movie)
        }
    }
}


// MARK: - Saved Movie

struct SavedMovie: Identifiable {
    
    let id = UUID()
    let title: String
    let imageName: String
    let category: String
}
