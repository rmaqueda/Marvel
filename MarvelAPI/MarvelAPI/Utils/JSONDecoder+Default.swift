//
//  JSONDecoder+Default.swift
//  MarvelAPI
//
//  Created by Maqueda, Ricardo Javier on 6/5/22.
//

import Foundation

// swiftlint:disable identifier_name
// It's a global variable
var DefaultDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}()
