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
    let baseURL = "https://gateway.marvel.com/v1/public/characters"
    let expectedHash = ("0" + "private" + "public").MD5
    lazy var commonQuery = "?ts=0&apikey=public&hash=" + expectedHash
    let referenceDate = Date(timeIntervalSince1970: 0)
    
    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.removeStub()
    }
    
    func test_limit_higher_than_100_throws_invalidLimit() {
        XCTAssertThrowsError(
            try makeSUT().getAll(limit: 101)
        ) { error in
            XCTAssertEqual(error as? CharacterRequest.Error, .invalidLimit)
        }
    }
    
    func test_response_400_throws_networkError() {
        let response = makeResponse(statusCode: 400)
        URLProtocolStub.stub(data: nil, response: response, error: nil)

        XCTAssertThrowsError(
            try makeSUT().getAll()
        ) { error in
            XCTAssertEqual(error as? CharacterRequest.Error, .networkError)
        }
    }
    
    func test_response_200_with_emptyData() {
        let response = makeResponse(statusCode: 200)
        URLProtocolStub.stub(data: nil, response: response, error: nil)

        XCTAssertThrowsError(
            try makeSUT().getAll()
        ) { error in
            XCTAssertEqual(error as? CharacterRequest.Error, .emptyData)
        }
    }
    
    func test_response_200_return_data() {
        let response = makeResponse(statusCode: 200)
        let data = "anyData".data(using: .utf8)
        
        URLProtocolStub.stub(data: data, response: response, error: nil)

        XCTAssertEqual(data, try makeSUT().getAll())
    }
    
    func test_call_with_URL() {
        let expectedURL = URL(string: baseURL + commonQuery)!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: expectedURL, exp: exp)
        
        _ = try? makeSUT().getAll(timeProvider: { referenceDate })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_with_limit_30() {
        let expectedURL = URL(string: baseURL + commonQuery + "&limit=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: expectedURL, exp: exp)
        
        _ = try? CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        ).getAll(timeProvider: { referenceDate }, limit: 30)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_with_offset_make_network_call_with_offset() {
        let expectedURL = URL(string: baseURL + commonQuery + "&offset=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: expectedURL, exp: exp)
        
        _ = try? makeSUT().getAll(
            timeProvider: { referenceDate },
            offset: 30
        )
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_characters_with_limit_make_network_call_with_limit() {
        let expectedURL = URL(string: baseURL + commonQuery + "&limit=30")!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: expectedURL, exp: exp)
        
        _ = try? makeSUT().getAll(
            timeProvider: { referenceDate },
            limit: 30
        )
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_call_character_with_id_make_network_call_with_id() {
        let expectedURL =  URL(string: baseURL + "/1" + commonQuery)!
        let exp = expectation(description: "Wait for request")
        
        checkRequest(expectedURL: expectedURL, exp: exp)
        
        _ = try? makeSUT().get(
            timeProvider: { referenceDate },
            id: 1
        )
    
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: Helpers
    
    @discardableResult
    private func makeSUT() -> CharacterRequest {
        CharacterRequest(
            session: makeStubSession(),
            publicKey: "public",
            privateKey: "private"
        )
    }
    
    private func makeResponse(statusCode: Int) -> URLResponse {
        HTTPURLResponse(
            url: URL(string: "http://anyURL")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
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
