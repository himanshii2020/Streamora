import Foundation

struct StreamoraContent: Identifiable, Codable {
    let id: UUID

    var creatorID: String
    var creatorUsername: String

    var title: String
    var description: String

    var category: String
    var genre: String

    var visibility: String
    var status: String

    var videoURL: URL?
    var thumbnailURL: URL?
    var thumbnailAssetName: String?

    var views: Int
    var likes: Int

    var createdAt: Date

    init(
        id: UUID = UUID(),
        creatorID: String,
        creatorUsername: String,
        title: String,
        description: String,
        category: String,
        genre: String,
        visibility: String,
        status: String = "Published",
        videoURL: URL? = nil,
        thumbnailURL: URL? = nil,
        thumbnailAssetName: String? = nil,
        views: Int = 0,
        likes: Int = 0,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.creatorID = creatorID
        self.creatorUsername = creatorUsername
        self.title = title
        self.description = description
        self.category = category
        self.genre = genre
        self.visibility = visibility
        self.status = status
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
        self.thumbnailAssetName = thumbnailAssetName
        self.views = views
        self.likes = likes
        self.createdAt = createdAt
    }
}
