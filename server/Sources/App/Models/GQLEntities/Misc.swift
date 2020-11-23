//
//  Misc.swift
//  
//
//  Created by Robert Geil on 11/16/20.
//

import Foundation


public enum ToolCondition : String, Codable, CaseIterable {
    case poor = "poor"
    case fair = "fair"
    case good = "good"
    case great = "great"
    case new = "new"
}
public enum BorrowStatus : String, Codable, CaseIterable {
    case accepted = "accepted"
    case rejected = "rejected"
    case pending = "pending"
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
    public let condition: ToolCondition
    public let location: GeoLocationInput
    public let ownerId: Int
    public let hourlyCost: Double
    public let images: [String]
    public let tags: [String]
}
