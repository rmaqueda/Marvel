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
            limit: 100,
            offset: 100
        )
        
        XCTAssertNotNil(data)
    }
    
    func test_integration_gell_1009175() {
        let data = try? CharacterRequest(
            publicKey: Secrets.marvelPublicKey,
            privateKey: Secrets.marvelPrivateKey
        ).get(
            id: 1009175
        )
        
        XCTAssertNotNil(data)
    }

}
