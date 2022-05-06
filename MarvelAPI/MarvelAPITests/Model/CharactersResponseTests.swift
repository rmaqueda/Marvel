//
//  CharactersResponseTests.swift
//  MarvelAPITests
//
//  Created by Maqueda, Ricardo Javier on 1/5/22.
//

import XCTest
import MarvelAPI

class CharactersResponseTests: XCTestCase {

    func test_TypeEnum_empty() throws {
        let data = "[\"\"]".data(using: .utf8)!
        let result = try? JSONDecoder().decode([TypeEnum].self, from: data)
        XCTAssertEqual(result?[0], TypeEnum.empty)
    }

    func test_TypeEnum_unknown() throws {
        let data = "[\"invalid\"]".data(using: .utf8)!
        let result = try? JSONDecoder().decode([TypeEnum].self, from: data)
        XCTAssertEqual(result?[0], TypeEnum.unknown)
    }

    func test_TypeEnum_mix_unknown_invalid_and_valid() throws {
        let data = "[\"\", \"invalid\", \"cover\"]".data(using: .utf8)!
        let result = try? JSONDecoder().decode([TypeEnum].self, from: data)
        XCTAssertEqual(result?[0], TypeEnum.empty)
        XCTAssertEqual(result?[1], TypeEnum.unknown)
        XCTAssertEqual(result?[2], TypeEnum.cover)
    }

}
