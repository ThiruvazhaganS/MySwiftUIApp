//
//  CodableValue.swift
//  GoogleSignInApp
//
//  Created by apple on 29/04/25.
//


import Foundation

enum CodableValue: Codable, CustomStringConvertible {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)

    var description: String {
        switch self {
        case .string(let v): return v
        case .int(let v): return "\(v)"
        case .double(let v): return "\(v)"
        case .bool(let v): return "\(v)"
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let v = try? container.decode(String.self) {
            self = .string(v)
        } else if let v = try? container.decode(Int.self) {
            self = .int(v)
        } else if let v = try? container.decode(Double.self) {
            self = .double(v)
        } else if let v = try? container.decode(Bool.self) {
            self = .bool(v)
        } else {
            throw DecodingError.typeMismatch(
                CodableValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unsupported value")
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let v): try container.encode(v)
        case .int(let v): try container.encode(v)
        case .double(let v): try container.encode(v)
        case .bool(let v): try container.encode(v)
        }
    }
}
