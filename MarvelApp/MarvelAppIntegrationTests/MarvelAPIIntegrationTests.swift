//
//  MarvelAPIIntegrationTests.swift
//  MarvelAppIntegrationTests
//
//  Created by Maqueda, Ricardo Javier on 30/4/22.
//

import XCTest
import MarvelAPI
@testable import MarvelApp

class MarvelAPIIntegrationTests: XCTestCase {

    func test_integration_gellAll() {
        let data = try? CharacterRequest(
            publicKey: Secrets.marvelPublicKey,
            privateKey: Secrets.marvelPrivateKey
        ).getAll(
            limit: 10,
            offset: 11
        )
        
        XCTAssertNotNil(data)
        
        guard let data = data else {
            XCTFail("Expected data not nil")
            return
        }
        
        let result = decode(data: data)
        XCTAssertEqual(result?.data.count, 10)
        XCTAssertEqual(result?.data.results.count, 10)
        XCTAssertEqual(result?.data.offset, 11)
    }
    
    func test_integration_gell_1009175() {
        let data = try? CharacterRequest(
            publicKey: Secrets.marvelPublicKey,
            privateKey: Secrets.marvelPrivateKey
        ).get(
            id: 1009175
        )
        
        XCTAssertNotNil(data)
        
        guard let data = data else {
            XCTFail("Expected data not nil")
            return
        }
        
        let result = decode(data: data)
        XCTAssertEqual(result?.data.count, 1)
        XCTAssertEqual(result?.data.results[0].id, 1009175)
    }
    
    // MARK: Helpers

    private func decode(
        data: Data,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CharactersResponse? {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(CharactersResponse.self, from: data)
            XCTAssertNotNil(response)
            return response
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
            XCTFail()
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            XCTFail()
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            XCTFail()
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            XCTFail()
        } catch {
            print("error: ", error)
            XCTFail()
        }
        return nil
    }

}
