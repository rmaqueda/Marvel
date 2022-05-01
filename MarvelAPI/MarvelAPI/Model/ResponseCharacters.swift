// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responseCharacters = try? newJSONDecoder().decode(ResponseCharacters.self, from: jsonData)

import Foundation

// MARK: - ResponseCharacters
public struct Response: Codable {
    public let code: Int
    public let status: String
    public let copyright: String
    public let attributionText: String
    public let attributionHtml: String
    public let etag: String
    public let data: DataClass

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHtml = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }

    public init(code: Int, status: String, copyright: String, attributionText: String, attributionHtml: String, etag: String, data: DataClass) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHtml = attributionHtml
        self.etag = etag
        self.data = data
    }
}

// MARK: - DataClass
public struct DataClass: Codable {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let count: Int
    public let results: [Result]

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }

    public init(offset: Int, limit: Int, total: Int, count: Int, results: [Result]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

// MARK: - Result
public struct Result: Codable {
    public let id: Int
    public let name: String
    public let resultDescription: String
    public let modified: Date
    public let thumbnail: Thumbnail
    public let resourceUri: String
    public let comics: Comics
    public let series: Series
    public let stories: Stories
    public let events: Events
    public let urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case resultDescription = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
        case resourceUri = "resourceURI"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
        case urls = "urls"
    }

    public init(id: Int, name: String, resultDescription: String, modified: Date, thumbnail: Thumbnail, resourceUri: String, comics: Comics, series: Series, stories: Stories, events: Events, urls: [URLElement]) {
        self.id = id
        self.name = name
        self.resultDescription = resultDescription
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceUri = resourceUri
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
}

// MARK: - Comics
public struct Comics: Codable {
    public let available: Int
    public let collectionUri: String
    public let items: [ComicsItem]
    public let returned: Int

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionUri = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(available: Int, collectionUri: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionUri = collectionUri
        self.items = items
        self.returned = returned
    }
}

// MARK: - ComicsItem
public struct ComicsItem: Codable {
    public let resourceUri: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case resourceUri = "resourceURI"
        case name = "name"
    }

    public init(resourceUri: String, name: String) {
        self.resourceUri = resourceUri
        self.name = name
    }
}

// MARK: - Events
public struct Events: Codable {
    public let available: Int
    public let collectionUri: String
    public let items: [ComicsItem]
    public let returned: Int

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionUri = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(available: Int, collectionUri: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionUri = collectionUri
        self.items = items
        self.returned = returned
    }
}

// MARK: - Series
public struct Series: Codable {
    public let available: Int
    public let collectionUri: String
    public let items: [ComicsItem]
    public let returned: Int

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionUri = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(available: Int, collectionUri: String, items: [ComicsItem], returned: Int) {
        self.available = available
        self.collectionUri = collectionUri
        self.items = items
        self.returned = returned
    }
}

// MARK: - Stories
public struct Stories: Codable {
    public let available: Int
    public let collectionUri: String
    public let items: [StoriesItem]
    public let returned: Int

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionUri = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(available: Int, collectionUri: String, items: [StoriesItem], returned: Int) {
        self.available = available
        self.collectionUri = collectionUri
        self.items = items
        self.returned = returned
    }
}

// MARK: - StoriesItem
public struct StoriesItem: Codable {
    public let resourceUri: String
    public let name: String
    public let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case resourceUri = "resourceURI"
        case name = "name"
        case type = "type"
    }

    public init(resourceUri: String, name: String, type: TypeEnum) {
        self.resourceUri = resourceUri
        self.name = name
        self.type = type
    }
}

// TODO: Complete enum with all types in API DOCs to avoid unknown scenario.
public enum TypeEnum: String, Codable {
    case unknown
    case empty = ""
    case cover = "cover"
    case interiorStory = "interiorStory"

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        if let type = TypeEnum(rawValue: rawString) {
            self = type
        } else {
            self = .unknown
        }
    }
    
}

// MARK: - Thumbnail
public struct Thumbnail: Codable {
    public let path: String
    public let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case thumbnailExtension = "extension"
    }

    public init(path: String, thumbnailExtension: String) {
        self.path = path
        self.thumbnailExtension = thumbnailExtension
    }
}

// MARK: - URLElement
public struct URLElement: Codable {
    public let type: String
    public let url: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }

    public init(type: String, url: String) {
        self.type = type
        self.url = url
    }
}

