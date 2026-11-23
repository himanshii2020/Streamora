import SwiftUI

struct ExploreView: View {
    
    // MARK: - Profile Navigation
    
    var onProfileTap: () -> Void
    var onNotificationTap: () -> Void
    
    
    // MARK: - Search & Category State
    
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    
    // MARK: - Movie Data
    
    let movies = [
        
        ExploreMovie(
            title: "THE UNKNOWN",
            imageName: "theUnknown",
            category: "Movies"
        ),
        
        ExploreMovie(
            title: "LAST SUMMER",
            imageName: "lastSummer",
            category: "Movies"
        ),
        
        ExploreMovie(
            title: "NO SIGNAL",
            imageName: "noSignal",
            category: "Web Series"
        ),
        
        ExploreMovie(
            title: "BEYOND",
            imageName: "beyond",
            category: "Short Films"
        ),
        
        ExploreMovie(
            title: "SILENCE",
            imageName: "silence",
            category: "Short Films"
        ),
        
        ExploreMovie(
            title: "ONE LAST CALL",
            imageName: "oneLastCall",
            category: "Short Films"
        )
    ]
    
    
    // MARK: - Filtered Movies
    
    var filteredMovies: [ExploreMovie] {
        
        movies.filter { movie in
            
            let matchesSearch =
                searchText.isEmpty ||
                movie.title.localizedCaseInsensitiveContains(
                    searchText
                )
            
            let matchesCategory =
                selectedCategory == "All" ||
                movie.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
    
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                
                ScrollView(
                    showsIndicators: false
                ) {
                    
                    VStack(
                        alignment: .leading,
                        spacing: 25
                    ) {
                        
                        // MARK: - Streamora Header
                        
                        // Header is NOT inside the
                        // horizontal 18-point padding.
                        
                        StreamoraTopHeader(
                            onProfileTap: {
                                onProfileTap()
                            },
                            onNotificationTap: {
                                onNotificationTap()
                            }
                        )
                        
                        
                        // MARK: - Explore Content
                        
                        VStack(
                            alignment: .leading,
                            spacing: 25
                        ) {
                            
                            // MARK: - Search Bar
                            
                            HStack(spacing: 12) {
                                
                                Image(
                                    systemName:
                                        "magnifyingglass"
                                )
                                .font(.title3)
                                .foregroundStyle(.gray)
                                
                                
                                TextField(
                                    "Search movies, series, short films...",
                                    text: $searchText
                                )
                                .foregroundStyle(.white)
                                .tint(.purple)
                                
                                
                                if !searchText.isEmpty {
                                    
                                    Button {
                                        searchText = ""
                                    } label: {
                                        
                                        Image(
                                            systemName:
                                                "xmark.circle.fill"
                                        )
                                        .foregroundStyle(.gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 54)
                            .background(
                                Color.white.opacity(0.10)
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                            )
                            
                            
                            // MARK: - Categories
                            
                            VStack(
                                alignment: .leading,
                                spacing: 14
                            ) {
                                
                                Text("Browse Categories")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                
                                ScrollView(
                                    .horizontal,
                                    showsIndicators: false
                                ) {
                                    
                                    HStack(spacing: 10) {
                                        
                                        CategoryChip(
                                            title: "All",
                                            selectedCategory:
                                                $selectedCategory
                                        )
                                        
                                        CategoryChip(
                                            title: "Movies",
                                            selectedCategory:
                                                $selectedCategory
                                        )
                                        
                                        CategoryChip(
                                            title: "Web Series",
                                            selectedCategory:
                                                $selectedCategory
                                        )
                                        
                                        CategoryChip(
                                            title: "Short Films",
                                            selectedCategory:
                                                $selectedCategory
                                        )
                                    }
                                }
                            }
                            
                            
                            // MARK: - Discover
                            
                            HStack {
                                
                                Text(
                                    searchText.isEmpty
                                    ? "Discover Something New"
                                    : "Search Results"
                                )
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                
                                
                                Spacer()
                                
                                
                                if searchText.isEmpty {
                                    
                                    Image(
                                        systemName:
                                            "chevron.right"
                                    )
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.purple)
                                }
                            }
                            
                            
                            // MARK: - Movie Grid
                            
                            if filteredMovies.isEmpty {
                                
                                EmptySearchView()
                                
                            } else {
                                
                                LazyVGrid(
                                    columns: [
                                        
                                        GridItem(
                                            .flexible(),
                                            spacing: 16
                                        ),
                                        
                                        GridItem(
                                            .flexible(),
                                            spacing: 16
                                        )
                                    ],
                                    spacing: 24
                                ) {
                                    
                                    ForEach(
                                        filteredMovies
                                    ) { movie in
                                        
                                        ExploreMovieCard(
                                            movie: movie
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 18)
                    }
                    .padding(.bottom, 100)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}



// MARK: - Movie Model

struct ExploreMovie: Identifiable {
    
    let id = UUID()
    
    let title: String
    let imageName: String
    let category: String
    
    
    func asSavedMovie() -> SavedMovie {
        
        SavedMovie(
            title: title,
            imageName: imageName,
            category: category
        )
    }
}



// MARK: - Category Chip

struct CategoryChip: View {
    
    let title: String
    
    @Binding var selectedCategory: String
    
    
    var body: some View {
        
        Button {
            
            selectedCategory = title
            
        } label: {
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(
                    selectedCategory == title
                    ? .black
                    : .white
                )
                .padding(.horizontal, 17)
                .padding(.vertical, 10)
                .background(
                    selectedCategory == title
                    ? Color.purple
                    : Color.white.opacity(0.10)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}



// MARK: - Movie Card

struct ExploreMovieCard: View {
    
    let movie: ExploreMovie
    
    @ObservedObject private var myList =
        MyListManager.shared
    
    
    var body: some View {
        
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            // MARK: - Poster + My List
            
            ZStack(
                alignment: .topTrailing
            ) {
                
                // MARK: Movie Details Navigation
                
                NavigationLink {
                    
                    MovieDetailsView(
                        movie: movie
                    )
                    
                } label: {
                    
                    Image(movie.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity
                        )
                        .aspectRatio(
                            1.55,
                            contentMode: .fit
                        )
                        .clipped()
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 14
                            )
                        )
                }
                .buttonStyle(.plain)
                
                
                // MARK: - My List Button
                
                Button {
                    
                    withAnimation(
                        .easeInOut(
                            duration: 0.2
                        )
                    ) {
                        
                        myList.toggle(
                            movie.asSavedMovie()
                        )
                    }
                    
                } label: {
                    
                    Image(
                        systemName:
                            myList.isSaved(
                                movie.asSavedMovie()
                            )
                            ? "heart.fill"
                            : "heart"
                    )
                    .font(
                        .system(
                            size: 16,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        myList.isSaved(
                            movie.asSavedMovie()
                        )
                        ? .purple
                        : .white
                    )
                    .frame(
                        width: 36,
                        height: 36
                    )
                    .background(
                        Color.black.opacity(0.70)
                    )
                    .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(8)
            }
            
            
            // MARK: - Movie Title
            
            NavigationLink {
                
                MovieDetailsView(
                    movie: movie
                )
                
            } label: {
                
                Text(movie.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            .buttonStyle(.plain)
            
            
            // MARK: - Category
            
            Text(movie.category)
                .font(.caption)
                .foregroundStyle(
                    .white.opacity(0.8)
                )
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Color.white.opacity(0.10)
                )
                .clipShape(Capsule())
        }
    }
}



// MARK: - Empty Search View

struct EmptySearchView: View {
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Image(
                systemName: "film.stack"
            )
            .font(
                .system(size: 45)
            )
            .foregroundStyle(.gray)
            
            
            Text("No stories found")
                .font(.headline)
                .foregroundStyle(.white)
            
            
            Text(
                "Try searching for another title."
            )
            .font(.subheadline)
            .foregroundStyle(.gray)
        }
        .frame(
            maxWidth: .infinity
        )
        .padding(.vertical, 60)
    }
}



// MARK: - Preview

#Preview {
    
    ExploreView(
        onProfileTap: {
            print("Profile tapped")
        },
        onNotificationTap: {
            print("Notification tapped")
        }
    )
}
