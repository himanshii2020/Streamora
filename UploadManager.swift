import SwiftUI
import Combine

final class UploadManager: ObservableObject {

    static let shared = UploadManager()

    @Published private(set) var uploads: [StreamoraContent] = []

    private let storageKey = "streamora_uploads"

    private init() {
        loadUploads()
    }

    // MARK: - Add

    func addUpload(_ content: StreamoraContent) {
        uploads.insert(content, at: 0)
        saveUploads()
    }

    // MARK: - Delete

    func deleteUpload(_ content: StreamoraContent) {
        uploads.removeAll {
            $0.id == content.id
        }

        saveUploads()
    }

    // MARK: - Update

    func updateUpload(_ content: StreamoraContent) {

        guard let index = uploads.firstIndex(
            where: { $0.id == content.id }
        ) else {
            return
        }

        uploads[index] = content

        saveUploads()
    }

    // MARK: - Creator Uploads

    func uploads(for creatorID: String) -> [StreamoraContent] {
        uploads.filter {
            $0.creatorID == creatorID
        }
    }

    // MARK: - Save

    private func saveUploads() {

        do {

            let data = try JSONEncoder().encode(uploads)

            UserDefaults.standard.set(
                data,
                forKey: storageKey
            )

        } catch {

            print(
                "Failed to save Streamora uploads:",
                error.localizedDescription
            )
        }
    }

    // MARK: - Load

    private func loadUploads() {

        guard let data = UserDefaults.standard.data(
            forKey: storageKey
        ) else {
            return
        }

        do {

            uploads = try JSONDecoder().decode(
                [StreamoraContent].self,
                from: data
            )

        } catch {

            print(
                "Failed to load Streamora uploads:",
                error.localizedDescription
            )
        }
    }
}
