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
            Scalar(Date.self).description("Returns the number of seconds since January, 1st, 2001: 12:00 am, ie Date(timeIntervalSinceReferenceDate: )")
            Type(GeoLocation.self){
                Field("lat", at: \.lat)
                Field("lon", at: \.lon)
            }
            Type(TimeSlot.self){
                Field("start", at: \.start, as: Date.self)
                Field("end", at: \.end, as: Date.self)
            }
            Type(UserRating.self){
                Field("rating", at: \.rating)
                Field("review", at: \.review)
                Field("reviewer", at: UserRating.getReviewer, as: TypeReference<User>.self)
                Field("reviewee", at: UserRating.getReviewee, as: TypeReference<User>.self)
            }
            Type(User.self){
                Field("id", at:\.id)
                Field("name", at: \.name)
                Field("phoneNumber", at: \.phoneNumber)
                Field("email", at: \.email)
                Field("ownedTools", at: User.getOwnedTools, as: [TypeReference<Tool>].self)
                Field("borrowHistory", at: User.getBorrowHistory, as: [TypeReference<Borrow>].self)
                Field("ratings", at: User.getRatings, as: [UserRating].self)
            }
            Type(Borrow.self){
                Field("id", at: \.id)
                Field("cost", at: \.cost)
                Field("tool", at: Borrow.getTool, as: TypeReference<Tool>.self)
                Field("user", at: Borrow.getUser, as: TypeReference<User>.self)
                Field("loanPeriod", at: \.loanPeriod)
                Field("timeReturned", at: \.timeReturned)
            }
            Type(ToolRating.self){
                Field("rating", at: \.rating)
                Field("review", at: \.review)
                Field("tool", at: ToolRating.getTool, as: TypeReference<Tool>.self)
                Field("user", at: ToolRating.getUser, as: TypeReference<User>.self)
            }
            Type(Tool.self){
                Field("id", at:\.id)
                Field("condition", at: \.condition)
                Field("owner", at: Tool.getOwner)
                Field("name", at: \.name)
                Field("description", at: \.description)
                Field("location", at: \.location)
                Field("borrowHistory", at: Tool.getBorrowHistory, as: [Borrow].self)
                    .description("The history of this tool being loaned out")
                Field("images", at: Tool.getImages)
                Field("tags", at: Tool.getTags)
                Field("ratings", at: Tool.getRatings)
                Field("schedule", at: Tool.getSchedule)
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
                Field("nearby", at: Resolver.nearby){
                    Argument("center", at: \.center)
                    Argument("radius", at: \.radius)
                }
            }
            
            Mutation{
                Field("addTool", at: Resolver.addTool){
                    Argument("tool", at: \.tool)
                }
                Field("updateTool", at: Resolver.updateTool){
                    
                }
            }
        }
    }
}
