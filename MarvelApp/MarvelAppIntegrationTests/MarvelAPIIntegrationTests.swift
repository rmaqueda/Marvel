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

    func test_integration() {
        let data = try? CharactersRequest(
            session: URLSession.shared,
            publicKey: Secrets.marvelPublicKey,
            privateKey: Secrets.marvelPrivateKey
        ).getAll(
            limit: 100,
            offset: 100
        )
        
        XCTAssertNotNil(data)
    }

}
