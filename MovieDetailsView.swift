import SwiftUI
import Combine

struct MovieDetailsView: View {
    
    let movie: ExploreMovie
    
    @ObservedObject private var myList = MyListManager.shared
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isDescriptionExpanded = false
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
                
                // MARK: - Background
                
                Color.black
                    .ignoresSafeArea()
                
                
                // MARK: - Main Scroll View
                
                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {
                    
                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {
                        
                        // MARK: - Hero Poster
                        
                        heroSection(
                            width: geometry.size.width
                        )
                        
                        
                        // MARK: - Details Content
                        
                        VStack(
                            alignment: .leading,
                            spacing: 0
                        ) {
                            
                            titleSection
                            
                            metadataSection
                            
                            actionSection(
                                availableWidth:
                                    geometry.size.width - 40
                            )
                            
                            descriptionSection
                            
                            genreSection
                            
                            creatorSection
                            
                            moreLikeThisSection
                            
                            Spacer()
                                .frame(height: 40)
                        }
                        .padding(.horizontal, 20)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
                
                
                // MARK: - Top Navigation Buttons
                
                VStack {
                    
                    HStack {
                        
                        // Back Button
                        
                        Button {
                            dismiss()
                        } label: {
                            
                            Image(
                                systemName: "chevron.left"
                            )
                            .font(
                                .system(
                                    size: 17,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .frame(
                                width: 40,
                                height: 40
                            )
                            .background(
                                Color.black.opacity(0.6)
                            )
                            .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        
                        
                        Spacer()
                        
                        
                        // Share Button
                        
                        Button {
                            // Share functionality later
                        } label: {
                            
                            Image(
                                systemName:
                                    "square.and.arrow.up"
                            )
                            .font(
                                .system(
                                    size: 16,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(.white)
                            .frame(
                                width: 40,
                                height: 40
                            )
                            .background(
                                Color.black.opacity(0.6)
                            )
                            .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 12)
                    
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    // MARK: - Hero Section
    
    private func heroSection(
        width: CGFloat
    ) -> some View {
        
        ZStack(alignment: .bottom) {
            
            // Black background prevents
            // any transparent/uneven image area
            // from looking out of place.
            
            Color.black
            
            
            // MARK: Poster
            
            Image(movie.imageName)
                .resizable()
                .scaledToFit()
                .frame(
                    width: width,
                    height: width * 1.15
                )
            
            
            // MARK: Bottom Gradient
            
            LinearGradient(
                stops: [
                    .init(
                        color: .clear,
                        location: 0.30
                    ),
                    .init(
                        color: .black.opacity(0.25),
                        location: 0.55
                    ),
                    .init(
                        color: .black.opacity(0.75),
                        location: 0.78
                    ),
                    .init(
                        color: .black,
                        location: 1.0
                    )
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(
                width: width,
                height: width * 0.75
            )
        }
        .frame(
            width: width,
            height: width * 1.15
        )
        .clipped()
    }
    
    
    // MARK: - Title Section
    
    private var titleSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            Text(movie.title)
                .font(
                    .system(
                        size: 30,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            
            Text(
                "An original story on Streamora"
            )
            .font(.subheadline)
            .foregroundStyle(
                .white.opacity(0.55)
            )
            .fixedSize(
                horizontal: false,
                vertical: true
            )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 4)
    }
    
    
    // MARK: - Metadata Section
    
    private var metadataSection: some View {
        
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            
            HStack(spacing: 10) {
                
                HStack(spacing: 4) {
                    
                    Image(
                        systemName: "star.fill"
                    )
                    .font(
                        .system(size: 11)
                    )
                    .foregroundStyle(.yellow)
                    
                    Text("4.8")
                }
                
                
                dot
                
                Text("2026")
                
                
                dot
                
                Text("1h 48m")
                
                
                dot
                
                
                Text("HD")
                    .font(
                        .system(
                            size: 10,
                            weight: .bold
                        )
                    )
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 4
                        )
                        .stroke(
                            .white.opacity(0.45),
                            lineWidth: 1
                        )
                    )
            }
            .font(.subheadline)
            .foregroundStyle(
                .white.opacity(0.7)
            )
        }
        .padding(.top, 14)
    }
    
    
    // MARK: - Metadata Dot
    
    private var dot: some View {
        
        Circle()
            .fill(
                .white.opacity(0.35)
            )
            .frame(
                width: 4,
                height: 4
            )
    }
    
    
    // MARK: - Action Section
    
    private func actionSection(
        availableWidth: CGFloat
    ) -> some View {
        
        HStack(spacing: 10) {
            
            // MARK: Watch Now
            
            Button {
                // Video player later
            } label: {
                
                HStack(spacing: 8) {
                    
                    Image(
                        systemName: "play.fill"
                    )
                    
                    Text("Watch Now")
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(
                    maxWidth: .infinity
                )
                .frame(height: 52)
                .background(
                    Color.purple
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 15
                    )
                )
            }
            .buttonStyle(.plain)
            
            
            // MARK: My List
            
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
                
                HStack(spacing: 7) {
                    
                    Image(
                        systemName:
                            myList.isSaved(
                                movie.asSavedMovie()
                            )
                            ? "heart.fill"
                            : "heart"
                    )
                    
                    Text(
                        myList.isSaved(
                            movie.asSavedMovie()
                        )
                        ? "Saved"
                        : "My List"
                    )
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                }
                .font(.subheadline)
                .foregroundStyle(
                    myList.isSaved(
                        movie.asSavedMovie()
                    )
                    ? .purple
                    : .white
                )
                .frame(
                    width: min(
                        110,
                        availableWidth * 0.32
                    )
                )
                .frame(height: 52)
                .background(
                    Color.white.opacity(0.09)
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 15
                    )
                )
            }
            .buttonStyle(.plain)
        }
        .frame(
            maxWidth: .infinity
        )
        .padding(.top, 20)
    }
    
    
    // MARK: - Description Section
    
    private var descriptionSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            sectionTitle(
                "About this story"
            )
            
            
            Text(descriptionText)
                .font(.subheadline)
                .foregroundStyle(
                    .white.opacity(0.65)
                )
                .lineSpacing(4)
                .lineLimit(
                    isDescriptionExpanded
                    ? nil
                    : 3
                )
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            
            Button {
                
                withAnimation(
                    .easeInOut(
                        duration: 0.2
                    )
                ) {
                    
                    isDescriptionExpanded.toggle()
                }
                
            } label: {
                
                Text(
                    isDescriptionExpanded
                    ? "Show less"
                    : "Read more"
                )
                .font(
                    .system(
                        size: 13,
                        weight: .semibold
                    )
                )
                .foregroundStyle(
                    .purple
                )
            }
            .buttonStyle(.plain)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 28)
    }
    
    
    // MARK: - Genre Section
    
    private var genreSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            sectionTitle(
                "Genres"
            )
            
            
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                
                HStack(spacing: 8) {
                    
                    GenreTag(
                        title: movie.category
                    )
                    
                    GenreTag(
                        title: "Original"
                    )
                    
                    GenreTag(
                        title: "English"
                    )
                    
                    GenreTag(
                        title: "HD"
                    )
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 26)
    }
    
    
    // MARK: - Creator Section
    
    private var creatorSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            sectionTitle(
                "Creator"
            )
            
            
            HStack(spacing: 12) {
                
                ZStack {
                    
                    Circle()
                        .fill(
                            Color.purple.opacity(0.18)
                        )
                    
                    Image(
                        systemName: "person.fill"
                    )
                    .foregroundStyle(
                        .purple
                    )
                }
                .frame(
                    width: 45,
                    height: 45
                )
                
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    Text(
                        "Independent Creator"
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    
                    
                    Text(
                        "Original Streamora Content"
                    )
                    .font(.caption)
                    .foregroundStyle(
                        .white.opacity(0.5)
                    )
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                }
                
                
                Spacer(
                    minLength: 0
                )
            }
            .padding(13)
            .frame(
                maxWidth: .infinity
            )
            .background(
                Color.white.opacity(0.06)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 15
                )
            )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 26)
    }
    
    
    // MARK: - More Like This
    
    private var moreLikeThisSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            HStack {
                
                sectionTitle(
                    "More Like This"
                )
                
                Spacer()
                
                
                Image(
                    systemName:
                        "chevron.right"
                )
                .font(
                    .system(
                        size: 13,
                        weight: .bold
                    )
                )
                .foregroundStyle(
                    .purple
                )
            }
            
            
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                
                HStack(spacing: 12) {
                    
                    miniPoster(
                        "theUnknown"
                    )
                    
                    miniPoster(
                        "lastSummer"
                    )
                    
                    miniPoster(
                        "noSignal"
                    )
                    
                    miniPoster(
                        "beyond"
                    )
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(.top, 28)
    }
    
    
    // MARK: - Mini Poster
    
    private func miniPoster(
        _ imageName: String
    ) -> some View {
        
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(
                width: 105,
                height: 150
            )
            .clipped()
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 12
                )
            )
    }
    
    
    // MARK: - Section Title
    
    private func sectionTitle(
        _ title: String
    ) -> some View {
        
        Text(title)
            .font(
                .system(
                    size: 19,
                    weight: .bold
                )
            )
            .foregroundStyle(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
    
    
    // MARK: - Description Data
    
    private var descriptionText: String {
        
        switch movie.title {
            
        case "THE UNKNOWN":
            
            return """
            A mysterious story unfolds when an ordinary discovery leads to questions that were never meant to be answered. Follow a journey filled with uncertainty, hidden secrets and unexpected turns.
            """
            
            
        case "LAST SUMMER":
            
            return """
            A journey through memories, friendships and moments that changed everything during one unforgettable summer. Some memories stay with us long after the season ends.
            """
            
            
        case "NO SIGNAL":
            
            return """
            When every connection suddenly disappears, a group of people must uncover what is really happening around them. With no way to reach the outside world, every decision matters.
            """
            
            
        case "BEYOND":
            
            return """
            Sometimes the biggest journey begins when we decide to step beyond everything we already know. A story about courage, discovery and finding something unexpected.
            """
            
            
        case "SILENCE":
            
            return """
            In the absence of words, hidden emotions begin to speak louder than ever. Silence explores the moments when what remains unsaid becomes the most important part of the story.
            """
            
            
        case "ONE LAST CALL":
            
            return """
            One final phone call brings back memories and a decision that could change everything. A story about unfinished conversations, relationships and second chances.
            """
            
            
        default:
            
            return """
            Discover an original Streamora story created by emerging independent creators. Every story has something new to say, and every creator has a story worth discovering.
            """
        }
    }
}



// MARK: - Genre Tag

struct GenreTag: View {
    
    let title: String
    
    
    var body: some View {
        
        Text(title)
            .font(
                .system(
                    size: 12,
                    weight: .medium
                )
            )
            .foregroundStyle(
                .white.opacity(0.8)
            )
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(
                Color.white.opacity(0.08)
            )
            .clipShape(
                Capsule()
            )
    }
}



// MARK: - Preview

#Preview {
    
    MovieDetailsView(
        movie: ExploreMovie(
            title: "THE UNKNOWN",
            imageName: "theUnknown",
            category: "Movies"
        )
    )
}
