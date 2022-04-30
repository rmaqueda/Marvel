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
    let referenceDate = Date(timeIntervalSince1970: 0)
    let expectedHash = ("0" + "private" + "public").MD5

    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.removeStub()
    }
    
    func test_limit_higher_than_100_throws() {
        XCTAssertThrowsError(
            try CharacterRequest(
                session: makeStubSession(),
                publicKey: "public",
                privateKey: "private"
            ).getAll(limit: 101)
        ) { error in
            XCTAssertEqual(error as? CharacterRequest.Error, .invalidLimit)
        }
    }
    
    func test_call_characters_with_limit_30() {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=0&apikey=public&hash=89488815f2a8c26b9e62bafa8f3f0a3b&limit=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: url, exp: exp)
        
        let _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(timeProvider: { referenceDate }, limit: 30)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_make_network_call_with_URL() {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=0&apikey=public&hash=89488815f2a8c26b9e62bafa8f3f0a3b&limit=20")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: url, exp: exp)
        
        let _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(timeProvider: { referenceDate })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_with_offset_make_network_call_with_offset() {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=0&apikey=public&hash=89488815f2a8c26b9e62bafa8f3f0a3b&limit=20&offset=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: url, exp: exp)
        
        let _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(
            timeProvider: { referenceDate },
            offset: 30
        )
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_with_limit_make_network_call_with_limit() {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=0&apikey=public&hash=89488815f2a8c26b9e62bafa8f3f0a3b&limit=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: url, exp: exp)
        
        let _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(
            timeProvider: { referenceDate },
            limit: 30
        )
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_character_with_id_make_network_call_with_id() {
        let url = URL(string: "https://gateway.marvel.com/v1/public/characters/1?ts=0&apikey=public&hash=89488815f2a8c26b9e62bafa8f3f0a3b")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: url, exp: exp)
        
        let _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).get(
            timeProvider: { referenceDate },
            id: 1
        )
    
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: Helpers
    
    private func checkRequest(
        expectedURL: URL,
        exp: XCTestExpectation,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, expectedURL, file: file, line: line)
            exp.fulfill()
        }
    }
    
    private func makeStubSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        
        return URLSession(configuration: configuration)
    }

}
