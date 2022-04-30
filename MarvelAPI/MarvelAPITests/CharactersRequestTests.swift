//
//  CharactersRequestTests.swift
//  
//
//  Created by Maqueda, Ricardo Javier on 29/4/22.
//

import XCTest
import MarvelAPI
import CryptoKit

class CharactersRequestTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.removeStub()
    }
    
    func test_limit_higher_than_100_throws() {
        XCTAssertThrowsError(
            try CharactersRequest(
                session: makeStubSession(),
                publicKey: "public",
                privateKey: "private"
            ).getAll(limit: 101)
        ) { error in
            XCTAssertEqual(error as? CharactersRequest.Error, .invalidLimit)
        }
    }
    
    func test_call_characters_with_limit_30() {
        let referenceDate = Date(timeIntervalSince1970: 0)
        let hash = ("0" + "private" + "public").MD5
        let url = URL(string: "http://gateway.marvel.com//v1/public/characters?ts=0&apikey=public&hash=" + hash + "&limit=30")!
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        let _ = try? CharactersRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(timeProvider: { referenceDate }, limit: 30)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_make_network_call_with_URL() {
        let referenceDate = Date(timeIntervalSince1970: 0)
        let hash = ("0" + "private" + "public").MD5
        let url = URL(string: "http://gateway.marvel.com//v1/public/characters?ts=0&apikey=public&hash=" + hash + "&limit=20")!
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        let _ = try? CharactersRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(timeProvider: { referenceDate })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: Helpers
    
    private func makeStubSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        
        return URLSession(configuration: configuration)
    }

}
