//
//  Secrets.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 30/4/22.
//

import Foundation

struct Secrets {
    
    private static var secrets: [String: String] = {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        return dict as! [String: String]
    }()
    
    static let marvelPublicKey: String = secrets["MarvelPublicKey"]!
    static let marvelPrivateKey: String = secrets["MarvelPrivateKey"]!
}
