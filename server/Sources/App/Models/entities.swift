//
//  entities.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Foundation

public enum ToolCondition : String, Codable, CaseIterable {
    case poor = "POOR"
    case fair = "FAIR"
    case good = "GOOD"
    case great = "GREAT"
    case new = "NEW"
}
public struct User : Codable {
    public let id: Int
    public let name: String
//    public let phoneNumber: String
//    public let email: String
}
public struct Tool: Codable{
    public let id: Int
    public let condition: ToolCondition
    public let owner: User
}
