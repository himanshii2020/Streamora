import SwiftUI

// MARK: - My List View

struct MyListView: View {
    
    // Shared My List data
    @ObservedObject private var myList = MyListManager.shared
    
    // Header actions
    var onProfileTap: () -> Void = {}
    var onNotificationTap: () -> Void = {}
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Background
            
            Color.black
                .ignoresSafeArea()
            
            
            // MARK: - Main Content
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - Header
                    
                    StreamoraTopHeader(
                        onProfileTap: {
                            onProfileTap()
                        },
                        onNotificationTap: {
                            onNotificationTap()
                        }
                    )
                    
                    
                    // MARK: - Page Content
                    
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - Title
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("My List")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Text(
                                myList.savedMovies.isEmpty
                                ? "Save your favourite stories here."
                                : "\(myList.savedMovies.count) stories saved"
                            )
                            .font(.subheadline)
                            .foregroundStyle(
                                .white.opacity(0.6)
                            )
                        }
                        
                        
                        // MARK: - Saved Content
                        
                        if myList.savedMovies.isEmpty {
                            
                            EmptyMyListView()
                            
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
                                    myList.savedMovies
                                ) { movie in
                                    
                                    SavedMovieCard(
                                        movie: movie
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 15)
                    .padding(.bottom, 110)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - Saved Movie Card

struct SavedMovieCard: View {
    
    let movie: SavedMovie
    
    @ObservedObject private var myList = MyListManager.shared
    
    var body: some View {
        
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            // MARK: Poster
            
            ZStack(alignment: .topTrailing) {
                
                Image(movie.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
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
                
                
                // MARK: Remove From My List
                
                Button {
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        myList.remove(movie)
                    }
                    
                } label: {
                    
                    Image(systemName: "heart.fill")
                        .font(
                            .system(
                                size: 16,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(.purple)
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
            
            
            // MARK: Title
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            
            // MARK: Category
            
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


// MARK: - Empty My List

struct EmptyMyListView: View {
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Spacer()
            
            // Heart icon
            
            Image(systemName: "heart")
                .font(
                    .system(
                        size: 48,
                        weight: .light
                    )
                )
                .foregroundStyle(
                    .white.opacity(0.45)
                )
            
            
            // Title
            
            Text("Your list is empty")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            
            // Description
            
            Text(
                "Save movies, web series and short films\n"
                + "to watch them later."
            )
            .font(.subheadline)
            .foregroundStyle(
                .white.opacity(0.55)
            )
            .multilineTextAlignment(.center)
            .lineSpacing(3)
            
            
            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            minHeight: 380
        )
    }
}


// MARK: - Preview

#Preview {
    
    MyListView(
        onProfileTap: {
            print("Profile tapped")
        },
        onNotificationTap: {
            print("Notification tapped")
        }
    )
}
