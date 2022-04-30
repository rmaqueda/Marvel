//
//  File.swift
//  
//
//  Created by Maqueda, Ricardo Javier on 29/4/22.
//

import Foundation
import CryptoKit

public extension String {
 
    var MD5: String {
       Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
    
}
