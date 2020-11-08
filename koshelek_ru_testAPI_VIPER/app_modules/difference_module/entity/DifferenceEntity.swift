//
//  DifferenceEntity.swift
//  koshelek_ru_testAPI_VIPER
//
//  Created by maksim on 07.11.2020.
//

import Foundation

final class DifferenceResponse : Codable{
    
    let e : String? // Event type
    let E : Int?    // Event time
    let s : String? // Symbol
    let U : Int?    // First update ID in event
    let u : Int?    // Final update ID in event
    let b : [[Double]]? // Bids to be updated
    let a : [[Double]]? // Asks to be updated
    
    init(e: String, E: Int, s: String,
         U: Int, u: Int, b: [[Double]],
         a: [[Double]]) {
        self.e = e
        self.E = E
        self.s = s
        self.U = U
        self.u = u
        self.b = b
        self.a = a
    }
}

