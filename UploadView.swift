import SwiftUI
import PhotosUI

struct UploadView: View {
    
    var onProfileTap: () -> Void = {}
    var onNotificationTap : () -> Void
    
    @State private var title = ""
    @State private var description = ""
    @State private var selectedCategory = "Movies"
    @State private var selectedGenre = "Drama"
    @State private var selectedVisibility = "Public"
    
    @State private var selectedVideoURL: URL?
    @State private var showVideoPicker = false
    
    @State private var selectedThumbnail: UIImage?
    
    let categories = [
        "Movies",
        "Web Series",
        "Short Films"
    ]
    
    let genres = [
        "Drama",
        "Comedy",
        "Thriller",
        "Romance",
        "Horror",
        "Action",
        "Documentary"
    ]
    
    let visibilityOptions = [
        "Public",
        "Private"
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - Header
                    StreamoraTopHeader(
                        onProfileTap:{
                            onProfileTap()
                        },
                        onNotificationTap:{
                            onNotificationTap()
                        }
                    )
                    
                    VStack(alignment: .leading, spacing: 8) {
                                                
                        Text("Upload Content")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text("Share your story with the Streamora community")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 25)
                    
                    // MARK: - Video Upload
                    
                    Text("Video")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                    
                    Button {

                        showVideoPicker = true

                    } label: {

                        VStack(spacing: 14) {

                            Image(
                                systemName: selectedVideoURL == nil
                                ? "video.badge.plus"
                                : "checkmark.circle.fill"
                            )
                            .font(.system(size: 42))
                            .foregroundStyle(
                                selectedVideoURL == nil
                                ? .purple
                                : .green
                            )

                            if let videoURL = selectedVideoURL {

                                Text(videoURL.lastPathComponent)
                                    .font(
                                        .system(
                                            size: 16,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundStyle(.white)
                                    .lineLimit(1)

                                Text("Video selected • Tap to change")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)

                            } else {

                                Text("Select Video")
                                    .font(
                                        .system(
                                            size: 17,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundStyle(.white)

                                Text("MP4, MOV up to 2GB")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 190)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    Color.white.opacity(0.05)
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    selectedVideoURL == nil
                                    ? Color.purple.opacity(0.4)
                                    : Color.green.opacity(0.5),
                                    style: StrokeStyle(
                                        lineWidth: 1,
                                        dash: [7]
                                    )
                                )
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // MARK: - Thumbnail
                    
                    Text("Thumbnail")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.top, 28)
                    
                    if let selectedThumbnail {

                        Button {

                            // ThumbnailPicker below will handle
                            // choosing a new image.

                        } label: {

                            ZStack(alignment: .bottomLeading) {

                                Image(uiImage: selectedThumbnail)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 190)
                                    .clipShape(
                                        RoundedRectangle(
                                            cornerRadius: 18
                                        )
                                    )

                                LinearGradient(
                                    colors: [
                                        .clear,
                                        Color.black.opacity(0.8)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 18
                                    )
                                )

                                HStack {

                                    Image(systemName: "photo")
                                        .font(.system(size: 14))

                                    Text("Thumbnail selected")
                                        .font(
                                            .system(
                                                size: 14,
                                                weight: .semibold
                                            )
                                        )

                                    Spacer()

                                    Text("Change")
                                        .font(
                                            .system(
                                                size: 13,
                                                weight: .medium
                                            )
                                        )
                                }
                                .foregroundStyle(.white)
                                .padding(16)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)

                    } else {

                        PhotosPicker(
                            selection: Binding<PhotosPickerItem?>(
                                get: { nil },
                                set: { item in

                                    guard let item else {
                                        return
                                    }

                                    Task {

                                        if let data = try? await item.loadTransferable(
                                            type: Data.self
                                        ) {

                                            if let image = UIImage(data: data) {

                                                await MainActor.run {
                                                    selectedThumbnail = image
                                                }
                                            }
                                        }
                                    }
                                }
                            ),
                            matching: .images
                        ) {

                            HStack(spacing: 14) {

                                Image(systemName: "photo.badge.plus")
                                    .font(.system(size: 22))
                                    .foregroundStyle(.purple)

                                VStack(
                                    alignment: .leading,
                                    spacing: 4
                                ) {

                                    Text("Add Thumbnail")
                                        .font(
                                            .system(
                                                size: 15,
                                                weight: .semibold
                                            )
                                        )
                                        .foregroundStyle(.white)

                                    Text("Choose an attractive cover image")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.gray)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(
                                        .system(
                                            size: 12,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundStyle(.gray)
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        Color.white.opacity(0.06)
                                    )
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                    }
                    
                    // MARK: - Title
                    
                    FormField(
                        title: "Title",
                        placeholder: "Enter your content title",
                        text: $title
                    )
                    
                    // MARK: - Description
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        
                        ZStack(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Tell viewers about your content...")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 14)
                            }
                            
                            TextEditor(text: $description)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .padding(8)
                        }
                        .frame(height: 120)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.06))
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                    
                    // MARK: - Category
                    
                    FormPicker(
                        title: "Category",
                        selection: $selectedCategory,
                        options: categories
                    )
                    
                    // MARK: - Genre
                    
                    FormPicker(
                        title: "Genre",
                        selection: $selectedGenre,
                        options: genres
                    )
                    
                    // MARK: - Visibility
                    
                    Text("Visibility")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.top, 22)
                    
                    HStack(spacing: 12) {
                        ForEach(visibilityOptions, id: \.self) { option in
                            Button {
                                selectedVisibility = option
                            } label: {
                                HStack(spacing: 8) {
                                    Image(
                                        systemName:
                                            selectedVisibility == option
                                            ? "checkmark.circle.fill"
                                            : "circle"
                                    )
                                    
                                    Text(option)
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .foregroundStyle(
                                    selectedVisibility == option
                                    ? .purple
                                    : .gray
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(
                                            selectedVisibility == option
                                            ? Color.purple.opacity(0.12)
                                            : Color.white.opacity(0.05)
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            selectedVisibility == option
                                            ? Color.purple.opacity(0.5)
                                            : Color.clear,
                                            lineWidth: 1
                                        )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // MARK: - Publish Button
                    
                    Button {
                        // Publish functionality will be added later
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "arrow.up.circle.fill")
                            
                            Text("Publish Content")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.purple,
                                    Color.purple.opacity(0.75)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    // Space for shared bottom navigation
                    Spacer()
                        .frame(height: 100)
                }
            }
        }
        .sheet(isPresented: $showVideoPicker){
            VideoPicker(
                selectedVideoURL : $selectedVideoURL
            )
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Form Field

struct FormField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white.opacity(0.06))
                )
        }
        .padding(.horizontal, 20)
        .padding(.top, 22)
    }
}

// MARK: - Form Picker

struct FormPicker: View {
    let title: String
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button {
                        selection = option
                    } label: {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selection)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 14)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white.opacity(0.06))
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 22)
    }
}

// MARK: - Preview

#Preview {
    UploadView(
        onProfileTap: {
            print("Profile tapped")
        },
        onNotificationTap: {
            print("Notification tapped")
        }
    )
}
