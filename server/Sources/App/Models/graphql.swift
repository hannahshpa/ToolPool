//
//  graphql.swift
//  
//
//  Created by Robert Geil on 10/24/20.
//

import Graphiti
import Foundation
struct GQLAPI : API {
    let resolver: Resolver
    let schema: Schema<Resolver, Context>
    
    init(resolver: Resolver) throws {
        self.resolver = resolver
        self.schema = try Schema<Resolver, Context> {
            Enum(ToolCondition.self){
                Value(.poor)
                Value(.fair)
                Value(.good)
                Value(.great)
                Value(.new)
            }
            Scalar(Date.self)
            Type(GeoLocation.self){
                Field("lat", at: \.lat)
                Field("lon", at: \.lon)
            }
            Type(TimeSlot.self){
                Field("start", at: \.start, as: Date.self)
                Field("end", at: \.end, as: Date.self)
            }
//            DateScalar(as: "Date", formatter: ISO8601DateFormatter())
//            DateScalar(formatter: ISO8601DateFormatter())
            
            Type(User.self){
                Field("id", at:\.id)
                Field("name", at: \.name)
                Field("phoneNumber", at: \.phoneNumber)
                Field("email", at: \.email)
                Field("ownedTools", at: \.ownedTools, as: Optional<[TypeReference<Tool>]>.self)
                Field("borrowHistory", at: \.borrowHistory, as: Optional<[TypeReference<Borrow>]>.self)
            }
            Type(Tool.self){
                Field("id", at:\.id)
                Field("condition", at: \.condition)
                Field("owner", at: \.owner)
                Field("name", at: \.name)
                Field("description", at: \.description)
                Field("location", at: \.location)
                Field("owner", at: \.owner)
                Field("borrowHistory", at: \.borrowHistory, as: Optional<[TypeReference<Borrow>]>.self)
                Field("images", at: \.images)
                Field("tags", at: \.tags)
            }
            Type(Borrow.self){
                Field("id", at: \.id)
                Field("cost", at: \.cost)
                Field("tool", at: \.tool)
                Field("user", at: \.user)
                Field("loanPeriod", at: \.loanPeriod)
            }
            Query {
                Field("self", at: Resolver.`self`)
                Field("tool", at: Resolver.tool){
                    Argument("id", at: \.id)
                }
                Field("borrow", at: Resolver.borrow){
                    Argument("id", at: \.id)
                }
            }
            
            Input(NewToolInput.self) {
                InputField("name", at: \.name)
                InputField("description", at: \.description)
            }
            
            Mutation{
                Field("addTool", at: Resolver.addTool){
                    Argument("tool", at: \.tool)
                }
            }
        }
    }
}
