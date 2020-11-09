//
//  entities.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation

public enum ToolCondition : String, Codable, CaseIterable {
    case poor = "poor"
    case fair = "fair"
    case good = "good"
    case great = "great"
    case new = "new"
}
public struct User : Codable {
    public let id: Int
    public let name: String
    public let phoneNumber: String
    public let email: String
    public let ownedTools: [Tool]?
    public let borrowHistory: [Borrow]?
}

public struct Tool: Codable{
    public let id: Int
    public let description: String
    public let name: String
    public let condition: ToolCondition
    public let location: GeoLocation
    public let owner: User?
    public var borrowHistory: [Borrow]?
    public let images: [String]
    public let tags: [String]
}

public struct Borrow: Codable{
    public let id: Int
    public let tool: Tool
    public let user: User
    public let cost: Double
    public let loanPeriod: TimeSlot
    public let timeReturned: Date?
}

public struct GeoLocation: Codable{
    public let lat: Double
    public let lon: Double
}

public struct GeoLocationInput: Codable{
    public let lat: Double
    public let lon: Double
}

public struct TimeSlot: Codable{
    public let start: Date
    public let end: Date
}

public struct NewToolInput: Codable{
    public let name: String
    public let description: String
}
