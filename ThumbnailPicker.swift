import SwiftUI
import PhotosUI

struct ThumbnailPicker: View {

    @Binding var selectedImage: UIImage?

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {

        PhotosPicker(
            selection: $selectedItem,
            matching: .images
        ) {

            HStack(spacing: 14) {

                Image(
                    systemName: selectedImage == nil
                    ? "photo.badge.plus"
                    : "checkmark.circle.fill"
                )
                .font(.system(size: 22))
                .foregroundStyle(
                    selectedImage == nil
                    ? .purple
                    : .green
                )

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(
                        selectedImage == nil
                        ? "Add Thumbnail"
                        : "Change Thumbnail"
                    )
                    .font(
                        .system(
                            size: 15,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(.white)

                    Text(
                        selectedImage == nil
                        ? "Choose an attractive cover image"
                        : "Tap to choose another image"
                    )
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
        .onChange(of: selectedItem) { _, newItem in

            guard let newItem else {
                return
            }

            Task {

                if let data = try? await newItem.loadTransferable(
                    type: Data.self
                ) {

                    if let image = UIImage(data: data) {

                        await MainActor.run {
                            selectedImage = image
                        }
                    }
                }
            }
        }
    }
}
