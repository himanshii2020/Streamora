import SwiftUI
import UIKit

struct MyUploadsView: View {

    var onProfileTap: () -> Void = {}
    var onNotificationTap: () -> Void = {}

    @ObservedObject private var uploadManager = UploadManager.shared
    @ObservedObject private var auth = AuthManager.shared

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

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

                    // MARK: - Title

                    VStack(alignment: .leading, spacing: 6) {

                        Text("My Uploads")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)

                        Text(
                            myUploads.isEmpty
                            ? "Share your stories with the world."
                            : "\(myUploads.count) uploads"
                        )
                        .font(.subheadline)
                        .foregroundStyle(
                            .white.opacity(0.6)
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 18)
                    .padding(.bottom, 24)

                    // MARK: - Content

                    if myUploads.isEmpty {

                        EmptyUploadsView()

                    } else {

                        VStack(spacing: 18) {

                            ForEach(myUploads) { upload in

                                MyUploadCard(
                                    upload: upload
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    Spacer()
                        .frame(height: 110)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - My Uploads

    private var myUploads: [StreamoraContent] {

        uploadManager.uploads(
            for: auth.username
        )
    }
}


// MARK: - Upload Card

struct MyUploadCard: View {

    let upload: StreamoraContent

    var body: some View {

        HStack(
            alignment: .top,
            spacing: 18
        ) {

            // MARK: Thumbnail

            UploadThumbnailView(
                upload: upload
            )

            // MARK: Information

            VStack(
                alignment: .leading,
                spacing: 9
            ) {

                Text(upload.title)
                    .font(
                        .system(
                            size: 18,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
                    .lineLimit(2)

                Text(upload.category)
                    .font(
                        .system(
                            size: 13,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(
                        .white.opacity(0.55)
                    )

                Text(upload.status)
                    .font(
                        .system(
                            size: 11,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        upload.status == "Published"
                        ? .green
                        : .orange
                    )
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        (
                            upload.status == "Published"
                            ? Color.green
                            : Color.orange
                        )
                        .opacity(0.12)
                    )
                    .clipShape(Capsule())

                Spacer(minLength: 10)

                HStack(spacing: 6) {

                    Image(systemName: "eye")
                        .font(
                            .system(
                                size: 12
                            )
                        )

                    Text(
                        "\(upload.views) views"
                    )
                    .font(
                        .system(
                            size: 12
                        )
                    )
                }
                .foregroundStyle(
                    .white.opacity(0.5)
                )
            }

            Spacer(minLength: 0)

            // MARK: More Button

            Button {

                // More options will be added later

            } label: {

                Image(systemName: "ellipsis")
                    .font(
                        .system(
                            size: 16,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(
                        .white.opacity(0.7)
                    )
                    .frame(
                        width: 34,
                        height: 34
                    )
                    .background(
                        Color.white.opacity(0.08)
                    )
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 218)
        .padding(14)
        .background(
            RoundedRectangle(
                cornerRadius: 18
            )
            .fill(
                Color.white.opacity(0.06)
            )
        )
    }
}


// MARK: - Thumbnail View

struct UploadThumbnailView: View {

    let upload: StreamoraContent

    var body: some View {

        Group {

            if let thumbnailURL = upload.thumbnailURL,
               let image = UIImage(
                    contentsOfFile: thumbnailURL.path
               ) {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()

            } else if let assetName = upload.thumbnailAssetName {

                Image(assetName)
                    .resizable()
                    .scaledToFill()

            } else {

                ZStack {

                    Color.white.opacity(0.06)

                    Image(
                        systemName: "film"
                    )
                    .font(
                        .system(
                            size: 30
                        )
                    )
                    .foregroundStyle(
                        .white.opacity(0.35)
                    )
                }
            }
        }
        .frame(
            width: 145,
            height: 190
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 14
            )
        )
    }
}


// MARK: - Empty State

struct EmptyUploadsView: View {

    var body: some View {

        VStack(spacing: 16) {

            Spacer()

            Image(
                systemName: "film.stack"
            )
            .font(
                .system(
                    size: 50,
                    weight: .light
                )
            )
            .foregroundStyle(
                .white.opacity(0.4)
            )

            Text("No uploads yet")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)

            Text(
                "Upload your first story and\n" +
                "share it with the Streamora community."
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
            minHeight: 400
        )
    }
}


// MARK: - Preview

#Preview {

    MyUploadsView(
        onProfileTap: {
            print("Profile tapped")
        },
        onNotificationTap: {
            print("Notification tapped")
        }
    )
}
