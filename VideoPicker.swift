import SwiftUI
import UniformTypeIdentifiers

struct VideoPicker: UIViewControllerRepresentable {

    @Binding var selectedVideoURL: URL?

    func makeUIViewController(
        context: Context
    ) -> UIDocumentPickerViewController {

        let picker = UIDocumentPickerViewController(
            forOpeningContentTypes: [
                .movie,
                .video
            ],
            asCopy: true
        )

        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false

        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIDocumentPickerViewController,
        context: Context
    ) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIDocumentPickerDelegate {

        let parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {

            guard let url = urls.first else {
                return
            }

            parent.selectedVideoURL = url
        }
    }
}

