import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject private var auth = AuthManager.shared

    @State private var selectedTab = "Home"
    @State private var showNotifications = false

    var body: some View {

        Group {

            if auth.isLoggedIn {

                ZStack(alignment: .bottom) {

                    Color.black
                        .ignoresSafeArea()

                    switch selectedTab {

                    case "Home":

                        HomeScreen(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onSearch: {
                                selectedTab = "Explore"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )

                    case "Explore":

                        ExploreView(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )

                    case "Upload":

                        UploadView(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )

                    case "My List":

                        MyListView(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )

                    case "Profile":

                        ProfileView(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onMyUploadsTap: {
                                selectedTab = "My Uploads"
                            },
                            onMyListTap: {
                                selectedTab = "My List"
                            },
                            onUploadTap: {
                                selectedTab = "Upload"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )

                    default:

                        HomeScreen(
                            onProfileTap: {
                                selectedTab = "Profile"
                            },
                            onSearch: {
                                selectedTab = "Explore"
                            },
                            onNotificationTap: {
                                showNotifications = true
                            }
                        )
                    }

                    BottomNavigationBar(
                        selectedTab: $selectedTab
                    )
                }
                .sheet(isPresented: $showNotifications) {
                    NotificationsView()
                }

            } else {

                LoginView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - HOME SCREEN

struct HomeScreen: View {

    var onProfileTap: () -> Void
    var onSearch: () -> Void
    var onNotificationTap: () -> Void

    @State private var selectedCategory = "All"

    var body: some View {

        NavigationStack {

            GeometryReader { geometry in

                let topSafeArea = geometry.safeAreaInsets.top

                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {

                    VStack(
                        alignment: .leading,
                        spacing: 0
                    ) {

                        // HERO SECTION
                        ZStack(alignment: .top) {

                            FeaturedCarousel()

                            StreamoraHeader(
                                onProfileTap: {
                                    onProfileTap()
                                },
                                onSearch: {
                                    onSearch()
                                },
                                onNotificationTap: {
                                    onNotificationTap()
                                }
                            )
                            .padding(.top, topSafeArea + 4)
                        }


                        // CATEGORY BUTTONS
                        ScrollView(
                            .horizontal,
                            showsIndicators: false
                        ) {

                            HStack(spacing: 10) {

                                CategoryButton(
                                    title: "All",
                                    isSelected: selectedCategory == "All"
                                ) {
                                    selectedCategory = "All"
                                }

                                CategoryButton(
                                    title: "Movies",
                                    isSelected: selectedCategory == "Movies"
                                ) {
                                    selectedCategory = "Movies"
                                }

                                CategoryButton(
                                    title: "Series",
                                    isSelected: selectedCategory == "Series"
                                ) {
                                    selectedCategory = "Series"
                                }

                                CategoryButton(
                                    title: "Short Films",
                                    isSelected: selectedCategory == "Short Films"
                                ) {
                                    selectedCategory = "Short Films"
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 18)


                        // ALL
                        if selectedCategory == "All" {

                            VStack(
                                alignment: .leading,
                                spacing: 30
                            ) {

                                HomeSection(
                                    title: "Trending Now",
                                    movies: [
                                        ("ECHOES", "echoes"),
                                        ("THE LAST FRAME", "lastFrame"),
                                        ("AFTER DARK", "afterDark"),
                                        ("BROKEN SKY", "brokenSky")
                                    ]
                                )

                                HomeSection(
                                    title: "Short Films",
                                    movies: [
                                        ("SILENCE", "silence"),
                                        ("ONE LAST CALL", "oneLastCall"),
                                        ("THE DOOR", "theDoor"),
                                        ("MIDNIGHT", "midnight")
                                    ]
                                )

                                HomeSection(
                                    title: "Popular Web Series",
                                    movies: [
                                        ("DARK ROOM", "darkRoom"),
                                        ("THE UNKNOWN", "theUnknown"),
                                        ("LAST SUMMER", "lastSummer"),
                                        ("NO SIGNAL", "noSignal")
                                    ]
                                )

                                HomeSection(
                                    title: "Fresh Releases",
                                    movies: [
                                        ("NEW BEGINNING", "newBeginning"),
                                        ("UNTOLD", "untold"),
                                        ("BEYOND", "beyond"),
                                        ("FIRST TAKE", "firstTake")
                                    ]
                                )
                            }
                            .padding(.top, 28)
                        }


                        // MOVIES
                        if selectedCategory == "Movies" {

                            HomeSection(
                                title: "Movies",
                                movies: [
                                    ("ECHOES", "echoes"),
                                    ("THE LAST FRAME", "lastFrame"),
                                    ("AFTER DARK", "afterDark"),
                                    ("BROKEN SKY", "brokenSky"),
                                    ("NEW BEGINNING", "newBeginning"),
                                    ("FIRST TAKE", "firstTake")
                                ]
                            )
                            .padding(.top, 28)
                        }


                        // WEB SERIES
                        if selectedCategory == "Series" {

                            HomeSection(
                                title: "Web Series",
                                movies: [
                                    ("DARK ROOM", "darkRoom"),
                                    ("THE UNKNOWN", "theUnknown"),
                                    ("LAST SUMMER", "lastSummer"),
                                    ("NO SIGNAL", "noSignal"),
                                    ("UNTOLD", "untold")
                                ]
                            )
                            .padding(.top, 28)
                        }


                        // SHORT FILMS
                        if selectedCategory == "Short Films" {

                            HomeSection(
                                title: "Short Films",
                                movies: [
                                    ("SILENCE", "silence"),
                                    ("ONE LAST CALL", "oneLastCall"),
                                    ("THE DOOR", "theDoor"),
                                    ("MIDNIGHT", "midnight"),
                                    ("BEYOND", "beyond")
                                ]
                            )
                            .padding(.top, 28)
                        }


                        Spacer()
                            .frame(height: 100)
                    }
                }
                .ignoresSafeArea(edges: .top)
            }
        }
        .background(Color.black)
    }
}


// MARK: - STREAMORA HEADER

struct StreamoraHeader: View {

    var onProfileTap: () -> Void
    var onSearch: () -> Void
    var onNotificationTap: () -> Void

    var showSearch: Bool = true
    var showNotification: Bool = true

    var body: some View {

        HStack(
            alignment: .center,
            spacing: 0
        ) {

            VStack(
                alignment: .leading,
                spacing: 2
            ) {

                HStack(spacing: 2) {

                    Text("STREAM")

                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(.purple)

                    Text("RA")
                }
                .font(.title2)
                .fontWeight(.bold)
                .tracking(3)

                Text("Where new stories begin")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.purple)
            }

            Spacer()


            if showSearch {

                Button {
                    onSearch()
                } label: {

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
            }


            if showNotification {

                Button {
                    onNotificationTap()
                } label: {

                    Image(systemName: "bell")
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .padding(.leading, 17)
            }


            Button {
                onProfileTap()
            } label: {

                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 31))
                    .foregroundStyle(.gray)
            }
            .buttonStyle(.plain)
            .padding(.leading, 17)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 12)
    }
}


// MARK: - FEATURED CAROUSEL

struct FeaturedCarousel: View {

    @State private var currentPage = 0

    let featuredMovies = [

        FeaturedMovie(
            title: "THE UNSEEN",
            description: "Some stories are waiting to be discovered.",
            imageName: "theUnseen"
        ),

        FeaturedMovie(
            title: "ECHOES",
            description: "Some voices stay with you forever.",
            imageName: "echoes"
        ),

        FeaturedMovie(
            title: "THE LAST FRAME",
            description: "Every ending is a story worth remembering.",
            imageName: "lastFrame"
        ),

        FeaturedMovie(
            title: "AFTER DARK",
            description: "When the city sleeps, another story begins.",
            imageName: "afterDark"
        )
    ]

    let timer = Timer
        .publish(
            every: 3,
            on: .main,
            in: .common
        )
        .autoconnect()


    var body: some View {

        GeometryReader { geometry in

            TabView(selection: $currentPage) {

                ForEach(
                    Array(featuredMovies.enumerated()),
                    id: \.offset
                ) { index, movie in

                    ZStack(alignment: .bottomLeading) {

                        // POSTER
                        Image(movie.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height
                            )
                            .clipped()


                        // TOP GRADIENT
                        LinearGradient(
                            colors: [
                                Color.black.opacity(0.72),
                                Color.black.opacity(0.35),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .center
                        )


                        // BOTTOM GRADIENT
                        LinearGradient(
                            stops: [
                                .init(
                                    color: .clear,
                                    location: 0.25
                                ),

                                .init(
                                    color: .black.opacity(0.18),
                                    location: 0.45
                                ),

                                .init(
                                    color: .black.opacity(0.72),
                                    location: 0.72
                                ),

                                .init(
                                    color: .black,
                                    location: 1.0
                                )
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )


                        // HERO CONTENT
                        VStack(
                            alignment: .leading,
                            spacing: 11
                        ) {

                            Spacer()


                            Text(movie.title)
                                .font(
                                    .system(
                                        size: 32,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(.white)
                                .tracking(1)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )


                            Text(movie.description)
                                .font(.system(size: 15))
                                .foregroundStyle(
                                    .white.opacity(0.9)
                                )
                                .lineLimit(2)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )


                            HStack(spacing: 12) {

                                // PLAY BUTTON
                                Button {

                                    print(
                                        "Play \(movie.title)"
                                    )

                                } label: {

                                    HStack(spacing: 8) {

                                        Image(
                                            systemName: "play.fill"
                                        )

                                        Text("Play")
                                    }
                                    .font(
                                        .system(
                                            size: 16,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundStyle(.black)
                                    .padding(
                                        .horizontal,
                                        24
                                    )
                                    .padding(
                                        .vertical,
                                        12
                                    )
                                    .background(.white)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 9
                                        )
                                    )
                                }


                                // INFO BUTTON
                                NavigationLink {

                                    MovieDetailsView(
                                        movie: ExploreMovie(
                                            title: movie.title,
                                            imageName: movie.imageName,
                                            category: heroMovieCategory(
                                                movie.title
                                            )
                                        )
                                    )

                                } label: {

                                    HStack(spacing: 8) {

                                        Image(
                                            systemName:
                                                "info.circle"
                                        )

                                        Text("Info")
                                    }
                                    .font(
                                        .system(
                                            size: 16,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundStyle(.white)
                                    .padding(
                                        .horizontal,
                                        21
                                    )
                                    .padding(
                                        .vertical,
                                        12
                                    )
                                    .background(
                                        Color.white.opacity(0.18)
                                    )
                                    .overlay(
                                        RoundedRectangle(
                                            cornerRadius: 9
                                        )
                                        .stroke(
                                            Color.white.opacity(0.25),
                                            lineWidth: 1
                                        )
                                    )
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 9
                                        )
                                    )
                                }
                                .buttonStyle(.plain)
                            }


                            // PAGE INDICATORS
                            HStack(spacing: 6) {

                                ForEach(
                                    0..<featuredMovies.count,
                                    id: \.self
                                ) { dot in

                                    Capsule()
                                        .fill(
                                            dot == currentPage
                                            ? Color.white
                                            : Color.white.opacity(0.4)
                                        )
                                        .frame(
                                            width:
                                                dot == currentPage
                                                ? 22
                                                : 6,
                                            height: 6
                                        )
                                }
                            }
                            .padding(.top, 2)
                            .padding(.bottom, 24)
                        }
                        .padding(.horizontal, 24)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .bottomLeading
                        )
                    }
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(
                .page(
                    indexDisplayMode: .never
                )
            )
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .onReceive(timer) { _ in

                withAnimation(
                    .easeInOut(duration: 0.6)
                ) {

                    currentPage =
                        (currentPage + 1)
                        % featuredMovies.count
                }
            }
        }
        .frame(height: 510)
        .frame(maxWidth: .infinity)
    }


    // HERO MOVIE CATEGORY
    private func heroMovieCategory(
        _ title: String
    ) -> String {

        switch title {

        case "THE UNSEEN",
             "ECHOES",
             "THE LAST FRAME",
             "AFTER DARK":

            return "Movies"

        default:

            return "Movies"
        }
    }
}


// MARK: - FEATURED MOVIE MODEL

struct FeaturedMovie {

    let title: String
    let description: String
    let imageName: String
}


// MARK: - CATEGORY BUTTON

struct CategoryButton: View {

    let title: String
    let isSelected: Bool

    var action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(
                    isSelected
                    ? Color.black
                    : Color.white
                )
                .padding(
                    .horizontal,
                    16
                )
                .padding(
                    .vertical,
                    10
                )
                .background(
                    isSelected
                    ? Color.purple
                    : Color.white.opacity(0.12)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}


// MARK: - HOME SECTION

struct HomeSection: View {

    let title: String
    let movies: [(String, String)]

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)


            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {

                HStack(spacing: 15) {

                    ForEach(
                        Array(movies.enumerated()),
                        id: \.offset
                    ) { _, movie in

                        MovieCard(
                            title: movie.0,
                            imageName: movie.1
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}


// MARK: - MOVIE CARD

struct MovieCard: View {

    let title: String
    let imageName: String

    @ObservedObject private var myList =
        MyListManager.shared

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            ZStack(alignment: .topTrailing) {

                // POSTER
                NavigationLink {

                    MovieDetailsView(
                        movie: ExploreMovie(
                            title: title,
                            imageName: imageName,
                            category: movieCategory
                        )
                    )

                } label: {

                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 145)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 14
                            )
                        )
                }
                .buttonStyle(.plain)


                // MY LIST BUTTON
                Button {

                    withAnimation(
                        .easeInOut(duration: 0.2)
                    ) {

                        myList.toggle(
                            ExploreMovie(
                                title: title,
                                imageName: imageName,
                                category: movieCategory
                            )
                            .asSavedMovie()
                        )
                    }

                } label: {

                    Image(
                        systemName:
                            myList.isSaved(
                                ExploreMovie(
                                    title: title,
                                    imageName: imageName,
                                    category: movieCategory
                                )
                                .asSavedMovie()
                            )
                            ? "heart.fill"
                            : "heart"
                    )
                    .font(
                        .system(
                            size: 15,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        myList.isSaved(
                            ExploreMovie(
                                title: title,
                                imageName: imageName,
                                category: movieCategory
                            )
                            .asSavedMovie()
                        )
                        ? .purple
                        : .white
                    )
                    .frame(
                        width: 34,
                        height: 34
                    )
                    .background(
                        Color.black.opacity(0.75)
                    )
                    .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .padding(7)
            }
            .frame(width: 145)


            // TITLE
            NavigationLink {

                MovieDetailsView(
                    movie: ExploreMovie(
                        title: title,
                        imageName: imageName,
                        category: movieCategory
                    )
                )

            } label: {

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .frame(
                        width: 145,
                        alignment: .leading
                    )
            }
            .buttonStyle(.plain)
        }
        .frame(
            width: 145,
            alignment: .leading
        )
    }


    private var movieCategory: String {

        switch title {

        case "ECHOES",
             "THE LAST FRAME",
             "AFTER DARK",
             "BROKEN SKY",
             "NEW BEGINNING",
             "FIRST TAKE":

            return "Movies"

        case "DARK ROOM",
             "THE UNKNOWN",
             "LAST SUMMER",
             "NO SIGNAL",
             "UNTOLD":

            return "Web Series"

        case "SILENCE",
             "ONE LAST CALL",
             "THE DOOR",
             "MIDNIGHT",
             "BEYOND":

            return "Short Films"

        default:

            return "Movies"
        }
    }
}


// MARK: - BOTTOM NAVIGATION

struct BottomNavigationBar: View {

    @Binding var selectedTab: String

    var body: some View {

        HStack {

            NavItem(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == "Home"
            ) {
                selectedTab = "Home"
            }

            Spacer()

            NavItem(
                icon: "magnifyingglass",
                title: "Explore",
                isSelected: selectedTab == "Explore"
            ) {
                selectedTab = "Explore"
            }

            Spacer()

            NavItem(
                icon: "plus.circle.fill",
                title: "Upload",
                isSelected: selectedTab == "Upload"
            ) {
                selectedTab = "Upload"
            }

            Spacer()

            NavItem(
                icon: "heart",
                title: "My List",
                isSelected: selectedTab == "My List"
            ) {
                selectedTab = "My List"
            }

            Spacer()

            NavItem(
                icon: "person",
                title: "Profile",
                isSelected: selectedTab == "Profile"
            ) {
                selectedTab = "Profile"
            }
        }
        .padding(.horizontal, 22)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Color.black)
    }
}


// MARK: - NAV ITEM

struct NavItem: View {

    let icon: String
    let title: String
    let isSelected: Bool

    var action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            VStack(spacing: 4) {

                Image(systemName: icon)
                    .font(
                        .system(
                            size: 20,
                            weight: .medium
                        )
                    )

                Text(title)
                    .font(.caption2)
            }
            .foregroundStyle(
                isSelected
                ? Color.purple
                : Color.gray
            )
            .frame(minWidth: 45)
        }
        .buttonStyle(.plain)
    }
}


// MARK: - TOP HEADER

struct StreamoraTopHeader: View {

    var onProfileTap: () -> Void
    var onNotificationTap: () -> Void

    var body: some View {

        HStack(
            alignment: .center,
            spacing: 0
        ) {

            VStack(
                alignment: .leading,
                spacing: 2
            ) {

                HStack(spacing: 2) {

                    Text("STREAM")

                    Image(
                        systemName:
                            "play.circle.fill"
                    )
                    .foregroundStyle(.purple)

                    Text("RA")
                }
                .font(.title2)
                .fontWeight(.bold)
                .tracking(3)

                Text("Where new stories begin")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.purple)
            }

            Spacer()


            // NOTIFICATION
            Button {

                onNotificationTap()

            } label: {

                Image(systemName: "bell")
                    .font(.system(size: 23))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)


            // PROFILE
            Button {

                onProfileTap()

            } label: {

                Image(
                    systemName:
                        "person.crop.circle.fill"
                )
                .font(.system(size: 31))
                .foregroundStyle(.gray)
            }
            .buttonStyle(.plain)
            .padding(.leading, 17)
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}


#Preview {
    ContentView()
}
