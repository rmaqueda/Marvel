//
//  String+MD5Tests.swift
//  
//
//  Created by Maqueda, Ricardo Javier on 29/4/22.
//

import XCTest
import MarvelAPI

class String_MD5Tests: XCTestCase {

    func test_MD5_empty_string() throws {
        let md5 = "".MD5
        XCTAssertEqual(md5, "d41d8cd98f00b204e9800998ecf8427e")
    }
    
    func test_MD5_abc_string() throws {
        let md5 = "abc".MD5
        XCTAssertEqual(md5, "900150983cd24fb0d6963f7d28e17f72")
    }
    
    func test_MD5_ABC_string() throws {
        let md5 = "ABC".MD5
        XCTAssertEqual(md5, "902fbdd2b1df0c4f70b4a5d23525e932")
    }
    
}
