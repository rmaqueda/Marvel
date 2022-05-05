// This file was generated from JSON Schema using quicktype

import Foundation

// MARK: - CharactersResponse
public struct CharactersResponse: Codable {
    public let code: Int
    public let status: String
    public let copyright: String
    public let attributionText: String
    public let attributionHTML: String
    public let eTag: String
    public let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case eTag = "etag"
        case data
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
        case offset
        case limit
        case total
        case count
        case results
    }
}

// MARK: - Result
public struct Result: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let modified: Date
    public let thumbnail: Thumbnail
    public let resourceURI: String
    public let comics: Comics
    public let series: Series
    public let stories: Stories
    public let events: Events
    public let urls: [URLElement]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case thumbnail
        case resourceURI
        case comics
        case series
        case stories
        case events
        case urls
    }
}

// MARK: - Comics
public struct Comics: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [ComicsItem]
    public let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
}

// MARK: - ComicsItem
public struct ComicsItem: Codable {
    public let resourceURI: String
    public let name: String
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

// MARK: - Events
public struct Events: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [ComicsItem]
    public let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
}

// MARK: - Series
public struct Series: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [ComicsItem]
    public let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
}

// MARK: - Stories
public struct Stories: Codable {
    public let available: Int
    public let collectionURI: String
    public let items: [StoriesItem]
    public let returned: Int
    
    enum CodingKeys: String, CodingKey {
        case available
        case collectionURI
        case items
        case returned
    }
}

// MARK: - StoriesItem
public struct StoriesItem: Codable {
    public let resourceURI: String
    public let name: String
    public let type: TypeEnum
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case type
    }
}

public enum TypeEnum: String, Codable {
    case unknown
    case empty = ""
    case cover
    case interiorStory
    
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
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public struct URLElement: Codable {
    public let type: String
    public let url: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
}
