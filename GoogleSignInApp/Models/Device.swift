//
//  Device.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//

import Foundation

struct Device: Codable, Identifiable {
    let id: String
    let name: String
    let data: [String: CodableValue]?
}
