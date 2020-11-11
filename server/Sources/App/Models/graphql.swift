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
                Field("borrowHistory", at: \.borrowHistory, as: Optional<[TypeReference<Borrow>]>.self).description("The history of this tool being loaned out")
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
            Input(NewToolInput.self) {
                InputField("name", at: \.name)
                InputField("description", at: \.description)
            }
            Input(GeoLocationInput.self){
                InputField("lat", at: \.lat)
                InputField("lon", at: \.lon)
            }
            Query {
                Field("self", at: Resolver.`self`)
                Field("tool", at: Resolver.tool){
                    Argument("id", at: \.id)
                }
                Field("borrow", at: Resolver.borrow){
                    Argument("id", at: \.id)
                }
                Field("nearby", at: Resolver.nearby){
                    Argument("center", at: \.center)
                    Argument("radius", at: \.radius)
                }
            }
            
            Mutation{
                Field("addTool", at: Resolver.addTool){
                    Argument("tool", at: \.tool)
                }
            }
        }
    }
}
