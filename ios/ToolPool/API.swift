// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum ToolCondition: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case poor
  case great
  case fair
  case new
  case good
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "poor": self = .poor
      case "great": self = .great
      case "fair": self = .fair
      case "new": self = .new
      case "good": self = .good
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .poor: return "poor"
      case .great: return "great"
      case .fair: return "fair"
      case .new: return "new"
      case .good: return "good"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ToolCondition, rhs: ToolCondition) -> Bool {
    switch (lhs, rhs) {
      case (.poor, .poor): return true
      case (.great, .great): return true
      case (.fair, .fair): return true
      case (.new, .new): return true
      case (.good, .good): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ToolCondition] {
    return [
      .poor,
      .great,
      .fair,
      .new,
      .good,
    ]
  }
}

public enum BorrowStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case accepted
  case rejected
  case pending
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "accepted": self = .accepted
      case "rejected": self = .rejected
      case "pending": self = .pending
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accepted: return "accepted"
      case .rejected: return "rejected"
      case .pending: return "pending"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: BorrowStatus, rhs: BorrowStatus) -> Bool {
    switch (lhs, rhs) {
      case (.accepted, .accepted): return true
      case (.rejected, .rejected): return true
      case (.pending, .pending): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [BorrowStatus] {
    return [
      .accepted,
      .rejected,
      .pending,
    ]
  }
}

public struct GeoLocationInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - lat
  ///   - lon
  public init(lat: Double, lon: Double) {
    graphQLMap = ["lat": lat, "lon": lon]
  }

  public var lat: Double {
    get {
      return graphQLMap["lat"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lat")
    }
  }

  public var lon: Double {
    get {
      return graphQLMap["lon"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lon")
    }
  }
}

public struct NewToolInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - condition
  ///   - description
  ///   - hourlyCost
  ///   - location
  ///   - name
  ///   - ownerId
  ///   - tags: Tags (ie handtool, powertool, etc). Must have at least 1
  public init(condition: ToolCondition, description: String, hourlyCost: Double, location: GeoLocationInput, name: String, ownerId: Int, tags: [String]) {
    graphQLMap = ["condition": condition, "description": description, "hourlyCost": hourlyCost, "location": location, "name": name, "ownerId": ownerId, "tags": tags]
  }

  public var condition: ToolCondition {
    get {
      return graphQLMap["condition"] as! ToolCondition
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "condition")
    }
  }

  public var description: String {
    get {
      return graphQLMap["description"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var hourlyCost: Double {
    get {
      return graphQLMap["hourlyCost"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hourlyCost")
    }
  }

  public var location: GeoLocationInput {
    get {
      return graphQLMap["location"] as! GeoLocationInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "location")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var ownerId: Int {
    get {
      return graphQLMap["ownerId"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerId")
    }
  }

  /// Tags (ie handtool, powertool, etc). Must have at least 1
  public var tags: [String] {
    get {
      return graphQLMap["tags"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "tags")
    }
  }
}

public final class ToolByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ToolById($id: Int) {
      tool(id: $id) {
        __typename
        name
        description
        location {
          __typename
          lat
          lon
        }
        condition
        hourly_cost
        tags
        images
        averageRating
        owner {
          __typename
          name
        }
      }
    }
    """

  public let operationName: String = "ToolById"

  public var id: Int?

  public init(id: Int? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tool", arguments: ["id": GraphQLVariable("id")], type: .object(Tool.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tool: Tool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "tool": tool.flatMap { (value: Tool) -> ResultMap in value.resultMap }])
    }

    /// Get a tool by id
    public var tool: Tool? {
      get {
        return (resultMap["tool"] as? ResultMap).flatMap { Tool(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "tool")
      }
    }

    public struct Tool: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Tool"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("location", type: .nonNull(.object(Location.selections))),
          GraphQLField("condition", type: .nonNull(.scalar(ToolCondition.self))),
          GraphQLField("hourly_cost", type: .nonNull(.scalar(Double.self))),
          GraphQLField("tags", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("images", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("averageRating", type: .nonNull(.scalar(Double.self))),
          GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, description: String, location: Location, condition: ToolCondition, hourlyCost: Double, tags: [String], images: [String], averageRating: Double, owner: Owner) {
        self.init(unsafeResultMap: ["__typename": "Tool", "name": name, "description": description, "location": location.resultMap, "condition": condition, "hourly_cost": hourlyCost, "tags": tags, "images": images, "averageRating": averageRating, "owner": owner.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var location: Location {
        get {
          return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "location")
        }
      }

      public var condition: ToolCondition {
        get {
          return resultMap["condition"]! as! ToolCondition
        }
        set {
          resultMap.updateValue(newValue, forKey: "condition")
        }
      }

      public var hourlyCost: Double {
        get {
          return resultMap["hourly_cost"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "hourly_cost")
        }
      }

      public var tags: [String] {
        get {
          return resultMap["tags"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }

      public var images: [String] {
        get {
          return resultMap["images"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "images")
        }
      }

      public var averageRating: Double {
        get {
          return resultMap["averageRating"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "averageRating")
        }
      }

      public var owner: Owner {
        get {
          return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "owner")
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["GeoLocation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
            GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(lat: Double, lon: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoLocation", "lat": lat, "lon": lon])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var lat: Double {
          get {
            return resultMap["lat"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lon: Double {
          get {
            return resultMap["lon"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lon")
          }
        }
      }

      public struct Owner: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "User", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class GetBorrowsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetBorrows {
      self {
        __typename
        borrowHistory {
          __typename
          cost
          id
          loanPeriod {
            __typename
            start
            end
          }
          returnAccepted
          timeReturned
          tool {
            __typename
            id
            name
            owner {
              __typename
              id
              name
              phoneNumber
              email
            }
          }
          status
        }
      }
    }
    """

  public let operationName: String = "GetBorrows"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("self", type: .object(`Self`.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(`self` _self: `Self`? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "self": _self.flatMap { (value: `Self`) -> ResultMap in value.resultMap }])
    }

    public var `self`: `Self`? {
      get {
        return (resultMap["self"] as? ResultMap).flatMap { `Self`(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "self")
      }
    }

    public struct `Self`: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("borrowHistory", type: .nonNull(.list(.nonNull(.object(BorrowHistory.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(borrowHistory: [BorrowHistory]) {
        self.init(unsafeResultMap: ["__typename": "User", "borrowHistory": borrowHistory.map { (value: BorrowHistory) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var borrowHistory: [BorrowHistory] {
        get {
          return (resultMap["borrowHistory"] as! [ResultMap]).map { (value: ResultMap) -> BorrowHistory in BorrowHistory(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: BorrowHistory) -> ResultMap in value.resultMap }, forKey: "borrowHistory")
        }
      }

      public struct BorrowHistory: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Borrow"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("cost", type: .nonNull(.scalar(Double.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("loanPeriod", type: .nonNull(.object(LoanPeriod.selections))),
            GraphQLField("returnAccepted", type: .scalar(Bool.self)),
            GraphQLField("timeReturned", type: .scalar(Double.self)),
            GraphQLField("tool", type: .nonNull(.object(Tool.selections))),
            GraphQLField("status", type: .nonNull(.scalar(BorrowStatus.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(cost: Double, id: Int, loanPeriod: LoanPeriod, returnAccepted: Bool? = nil, timeReturned: Double? = nil, tool: Tool, status: BorrowStatus) {
          self.init(unsafeResultMap: ["__typename": "Borrow", "cost": cost, "id": id, "loanPeriod": loanPeriod.resultMap, "returnAccepted": returnAccepted, "timeReturned": timeReturned, "tool": tool.resultMap, "status": status])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var cost: Double {
          get {
            return resultMap["cost"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cost")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var loanPeriod: LoanPeriod {
          get {
            return LoanPeriod(unsafeResultMap: resultMap["loanPeriod"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "loanPeriod")
          }
        }

        /// Whether or not the return was accepted by the tool owner
        public var returnAccepted: Bool? {
          get {
            return resultMap["returnAccepted"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "returnAccepted")
          }
        }

        /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
        public var timeReturned: Double? {
          get {
            return resultMap["timeReturned"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "timeReturned")
          }
        }

        public var tool: Tool {
          get {
            return Tool(unsafeResultMap: resultMap["tool"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "tool")
          }
        }

        public var status: BorrowStatus {
          get {
            return resultMap["status"]! as! BorrowStatus
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public struct LoanPeriod: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TimeSlot"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("start", type: .nonNull(.scalar(Double.self))),
              GraphQLField("end", type: .nonNull(.scalar(Double.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(start: Double, end: Double) {
            self.init(unsafeResultMap: ["__typename": "TimeSlot", "start": start, "end": end])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
          public var start: Double {
            get {
              return resultMap["start"]! as! Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "start")
            }
          }

          /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
          public var end: Double {
            get {
              return resultMap["end"]! as! Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "end")
            }
          }
        }

        public struct Tool: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Tool"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, owner: Owner) {
            self.init(unsafeResultMap: ["__typename": "Tool", "id": id, "name": name, "owner": owner.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var owner: Owner {
            get {
              return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "owner")
            }
          }

          public struct Owner: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["User"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
                GraphQLField("email", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, name: String, phoneNumber: String, email: String) {
              self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "phoneNumber": phoneNumber, "email": email])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var phoneNumber: String {
              get {
                return resultMap["phoneNumber"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phoneNumber")
              }
            }

            public var email: String {
              get {
                return resultMap["email"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetOtherBorrowsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetOtherBorrows {
      self {
        __typename
        ownedTools {
          __typename
          borrowHistory {
            __typename
            cost
            id
            tool {
              __typename
              id
              name
              owner {
                __typename
                id
              }
            }
            loanPeriod {
              __typename
              start
              end
            }
            returnAccepted
            timeReturned
            status
            user {
              __typename
              id
              name
              phoneNumber
              email
            }
          }
        }
      }
    }
    """

  public let operationName: String = "GetOtherBorrows"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("self", type: .object(`Self`.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(`self` _self: `Self`? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "self": _self.flatMap { (value: `Self`) -> ResultMap in value.resultMap }])
    }

    public var `self`: `Self`? {
      get {
        return (resultMap["self"] as? ResultMap).flatMap { `Self`(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "self")
      }
    }

    public struct `Self`: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ownedTools", type: .nonNull(.list(.nonNull(.object(OwnedTool.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ownedTools: [OwnedTool]) {
        self.init(unsafeResultMap: ["__typename": "User", "ownedTools": ownedTools.map { (value: OwnedTool) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ownedTools: [OwnedTool] {
        get {
          return (resultMap["ownedTools"] as! [ResultMap]).map { (value: ResultMap) -> OwnedTool in OwnedTool(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: OwnedTool) -> ResultMap in value.resultMap }, forKey: "ownedTools")
        }
      }

      public struct OwnedTool: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tool"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("borrowHistory", type: .nonNull(.list(.nonNull(.object(BorrowHistory.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(borrowHistory: [BorrowHistory]) {
          self.init(unsafeResultMap: ["__typename": "Tool", "borrowHistory": borrowHistory.map { (value: BorrowHistory) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The history of this tool being loaned out
        public var borrowHistory: [BorrowHistory] {
          get {
            return (resultMap["borrowHistory"] as! [ResultMap]).map { (value: ResultMap) -> BorrowHistory in BorrowHistory(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: BorrowHistory) -> ResultMap in value.resultMap }, forKey: "borrowHistory")
          }
        }

        public struct BorrowHistory: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Borrow"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("cost", type: .nonNull(.scalar(Double.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("tool", type: .nonNull(.object(Tool.selections))),
              GraphQLField("loanPeriod", type: .nonNull(.object(LoanPeriod.selections))),
              GraphQLField("returnAccepted", type: .scalar(Bool.self)),
              GraphQLField("timeReturned", type: .scalar(Double.self)),
              GraphQLField("status", type: .nonNull(.scalar(BorrowStatus.self))),
              GraphQLField("user", type: .nonNull(.object(User.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(cost: Double, id: Int, tool: Tool, loanPeriod: LoanPeriod, returnAccepted: Bool? = nil, timeReturned: Double? = nil, status: BorrowStatus, user: User) {
            self.init(unsafeResultMap: ["__typename": "Borrow", "cost": cost, "id": id, "tool": tool.resultMap, "loanPeriod": loanPeriod.resultMap, "returnAccepted": returnAccepted, "timeReturned": timeReturned, "status": status, "user": user.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var cost: Double {
            get {
              return resultMap["cost"]! as! Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "cost")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var tool: Tool {
            get {
              return Tool(unsafeResultMap: resultMap["tool"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "tool")
            }
          }

          public var loanPeriod: LoanPeriod {
            get {
              return LoanPeriod(unsafeResultMap: resultMap["loanPeriod"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "loanPeriod")
            }
          }

          /// Whether or not the return was accepted by the tool owner
          public var returnAccepted: Bool? {
            get {
              return resultMap["returnAccepted"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "returnAccepted")
            }
          }

          /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
          public var timeReturned: Double? {
            get {
              return resultMap["timeReturned"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "timeReturned")
            }
          }

          public var status: BorrowStatus {
            get {
              return resultMap["status"]! as! BorrowStatus
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }

          public var user: User {
            get {
              return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "user")
            }
          }

          public struct Tool: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Tool"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, name: String, owner: Owner) {
              self.init(unsafeResultMap: ["__typename": "Tool", "id": id, "name": name, "owner": owner.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var owner: Owner {
              get {
                return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "owner")
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["User"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int) {
                self.init(unsafeResultMap: ["__typename": "User", "id": id])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int {
                get {
                  return resultMap["id"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }
            }
          }

          public struct LoanPeriod: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["TimeSlot"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("start", type: .nonNull(.scalar(Double.self))),
                GraphQLField("end", type: .nonNull(.scalar(Double.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(start: Double, end: Double) {
              self.init(unsafeResultMap: ["__typename": "TimeSlot", "start": start, "end": end])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
            public var start: Double {
              get {
                return resultMap["start"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "start")
              }
            }

            /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
            public var end: Double {
              get {
                return resultMap["end"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "end")
              }
            }
          }

          public struct User: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["User"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
                GraphQLField("email", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, name: String, phoneNumber: String, email: String) {
              self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "phoneNumber": phoneNumber, "email": email])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var phoneNumber: String {
              get {
                return resultMap["phoneNumber"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "phoneNumber")
              }
            }

            public var email: String {
              get {
                return resultMap["email"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }
          }
        }
      }
    }
  }
}

public final class BorrowByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query BorrowById($id: Int) {
      borrow(id: $id) {
        __typename
        cost
        id
        loanPeriod {
          __typename
          start
          end
        }
        tool {
          __typename
          name
        }
        user {
          __typename
          id
          name
          phoneNumber
          email
        }
      }
    }
    """

  public let operationName: String = "BorrowById"

  public var id: Int?

  public init(id: Int? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("borrow", arguments: ["id": GraphQLVariable("id")], type: .object(Borrow.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(borrow: Borrow? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "borrow": borrow.flatMap { (value: Borrow) -> ResultMap in value.resultMap }])
    }

    /// Get a given borrow by id
    public var borrow: Borrow? {
      get {
        return (resultMap["borrow"] as? ResultMap).flatMap { Borrow(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "borrow")
      }
    }

    public struct Borrow: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Borrow"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("cost", type: .nonNull(.scalar(Double.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("loanPeriod", type: .nonNull(.object(LoanPeriod.selections))),
          GraphQLField("tool", type: .nonNull(.object(Tool.selections))),
          GraphQLField("user", type: .nonNull(.object(User.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(cost: Double, id: Int, loanPeriod: LoanPeriod, tool: Tool, user: User) {
        self.init(unsafeResultMap: ["__typename": "Borrow", "cost": cost, "id": id, "loanPeriod": loanPeriod.resultMap, "tool": tool.resultMap, "user": user.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var cost: Double {
        get {
          return resultMap["cost"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "cost")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var loanPeriod: LoanPeriod {
        get {
          return LoanPeriod(unsafeResultMap: resultMap["loanPeriod"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "loanPeriod")
        }
      }

      public var tool: Tool {
        get {
          return Tool(unsafeResultMap: resultMap["tool"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "tool")
        }
      }

      public var user: User {
        get {
          return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "user")
        }
      }

      public struct LoanPeriod: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["TimeSlot"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("start", type: .nonNull(.scalar(Double.self))),
            GraphQLField("end", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(start: Double, end: Double) {
          self.init(unsafeResultMap: ["__typename": "TimeSlot", "start": start, "end": end])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
        public var start: Double {
          get {
            return resultMap["start"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        /// Number of seconds since Jan 01, 2001. I.e. timeIntervalSinceReferenceDate
        public var end: Double {
          get {
            return resultMap["end"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "end")
          }
        }
      }

      public struct Tool: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tool"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "Tool", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("phoneNumber", type: .nonNull(.scalar(String.self))),
            GraphQLField("email", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String, phoneNumber: String, email: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "phoneNumber": phoneNumber, "email": email])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var phoneNumber: String {
          get {
            return resultMap["phoneNumber"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phoneNumber")
          }
        }

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }
      }
    }
  }
}

public final class BorrowDummyQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query BorrowDummy($id: Int) {
      borrow(id: $id) {
        __typename
        id
        tool {
          __typename
          name
        }
      }
    }
    """

  public let operationName: String = "BorrowDummy"

  public var id: Int?

  public init(id: Int? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("borrow", arguments: ["id": GraphQLVariable("id")], type: .object(Borrow.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(borrow: Borrow? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "borrow": borrow.flatMap { (value: Borrow) -> ResultMap in value.resultMap }])
    }

    /// Get a given borrow by id
    public var borrow: Borrow? {
      get {
        return (resultMap["borrow"] as? ResultMap).flatMap { Borrow(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "borrow")
      }
    }

    public struct Borrow: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Borrow"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("tool", type: .nonNull(.object(Tool.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, tool: Tool) {
        self.init(unsafeResultMap: ["__typename": "Borrow", "id": id, "tool": tool.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var tool: Tool {
        get {
          return Tool(unsafeResultMap: resultMap["tool"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "tool")
        }
      }

      public struct Tool: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tool"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "Tool", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class GetMyToolsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMyTools {
      self {
        __typename
        ownedTools {
          __typename
          name
        }
      }
    }
    """

  public let operationName: String = "GetMyTools"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("self", type: .object(`Self`.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(`self` _self: `Self`? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "self": _self.flatMap { (value: `Self`) -> ResultMap in value.resultMap }])
    }

    public var `self`: `Self`? {
      get {
        return (resultMap["self"] as? ResultMap).flatMap { `Self`(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "self")
      }
    }

    public struct `Self`: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ownedTools", type: .nonNull(.list(.nonNull(.object(OwnedTool.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ownedTools: [OwnedTool]) {
        self.init(unsafeResultMap: ["__typename": "User", "ownedTools": ownedTools.map { (value: OwnedTool) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ownedTools: [OwnedTool] {
        get {
          return (resultMap["ownedTools"] as! [ResultMap]).map { (value: ResultMap) -> OwnedTool in OwnedTool(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: OwnedTool) -> ResultMap in value.resultMap }, forKey: "ownedTools")
        }
      }

      public struct OwnedTool: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tool"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "Tool", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class GetSelfQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetSelf {
      self {
        __typename
        name
        email
        id
        ownedTools {
          __typename
          name
          id
        }
      }
    }
    """

  public let operationName: String = "GetSelf"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("self", type: .object(`Self`.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(`self` _self: `Self`? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "self": _self.flatMap { (value: `Self`) -> ResultMap in value.resultMap }])
    }

    public var `self`: `Self`? {
      get {
        return (resultMap["self"] as? ResultMap).flatMap { `Self`(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "self")
      }
    }

    public struct `Self`: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("ownedTools", type: .nonNull(.list(.nonNull(.object(OwnedTool.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, email: String, id: Int, ownedTools: [OwnedTool]) {
        self.init(unsafeResultMap: ["__typename": "User", "name": name, "email": email, "id": id, "ownedTools": ownedTools.map { (value: OwnedTool) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var ownedTools: [OwnedTool] {
        get {
          return (resultMap["ownedTools"] as! [ResultMap]).map { (value: ResultMap) -> OwnedTool in OwnedTool(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: OwnedTool) -> ResultMap in value.resultMap }, forKey: "ownedTools")
        }
      }

      public struct OwnedTool: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tool"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, id: Int) {
          self.init(unsafeResultMap: ["__typename": "Tool", "name": name, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class GetNearbyQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetNearby($center: GeoLocationInput!, $radius: Float!) {
      nearby(center: $center, radius: $radius) {
        __typename
        id
        name
        description
        location {
          __typename
          lat
          lon
        }
        condition
        hourly_cost
        tags
        images
        averageRating
      }
    }
    """

  public let operationName: String = "GetNearby"

  public var center: GeoLocationInput
  public var radius: Double

  public init(center: GeoLocationInput, radius: Double) {
    self.center = center
    self.radius = radius
  }

  public var variables: GraphQLMap? {
    return ["center": center, "radius": radius]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("nearby", arguments: ["center": GraphQLVariable("center"), "radius": GraphQLVariable("radius")], type: .nonNull(.list(.nonNull(.object(Nearby.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(nearby: [Nearby]) {
      self.init(unsafeResultMap: ["__typename": "Query", "nearby": nearby.map { (value: Nearby) -> ResultMap in value.resultMap }])
    }

    /// Find all tools within a given radius, centered at a point
    public var nearby: [Nearby] {
      get {
        return (resultMap["nearby"] as! [ResultMap]).map { (value: ResultMap) -> Nearby in Nearby(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Nearby) -> ResultMap in value.resultMap }, forKey: "nearby")
      }
    }

    public struct Nearby: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Tool"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("location", type: .nonNull(.object(Location.selections))),
          GraphQLField("condition", type: .nonNull(.scalar(ToolCondition.self))),
          GraphQLField("hourly_cost", type: .nonNull(.scalar(Double.self))),
          GraphQLField("tags", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("images", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("averageRating", type: .nonNull(.scalar(Double.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String, description: String, location: Location, condition: ToolCondition, hourlyCost: Double, tags: [String], images: [String], averageRating: Double) {
        self.init(unsafeResultMap: ["__typename": "Tool", "id": id, "name": name, "description": description, "location": location.resultMap, "condition": condition, "hourly_cost": hourlyCost, "tags": tags, "images": images, "averageRating": averageRating])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var location: Location {
        get {
          return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "location")
        }
      }

      public var condition: ToolCondition {
        get {
          return resultMap["condition"]! as! ToolCondition
        }
        set {
          resultMap.updateValue(newValue, forKey: "condition")
        }
      }

      public var hourlyCost: Double {
        get {
          return resultMap["hourly_cost"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "hourly_cost")
        }
      }

      public var tags: [String] {
        get {
          return resultMap["tags"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "tags")
        }
      }

      public var images: [String] {
        get {
          return resultMap["images"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "images")
        }
      }

      public var averageRating: Double {
        get {
          return resultMap["averageRating"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "averageRating")
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["GeoLocation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
            GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(lat: Double, lon: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoLocation", "lat": lat, "lon": lon])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var lat: Double {
          get {
            return resultMap["lat"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lon: Double {
          get {
            return resultMap["lon"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lon")
          }
        }
      }
    }
  }
}

public final class AddToolMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddTool($tool: NewToolInput!) {
      addTool(tool: $tool) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "AddTool"

  public var tool: NewToolInput

  public init(tool: NewToolInput) {
    self.tool = tool
  }

  public var variables: GraphQLMap? {
    return ["tool": tool]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addTool", arguments: ["tool": GraphQLVariable("tool")], type: .nonNull(.object(AddTool.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addTool: AddTool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addTool": addTool.resultMap])
    }

    /// Adds a new tool with the given properties, and returns the created Tool object
    public var addTool: AddTool {
      get {
        return AddTool(unsafeResultMap: resultMap["addTool"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addTool")
      }
    }

    public struct AddTool: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Tool"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "Tool", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class RequestBorrowMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RequestBorrow($userId: Int!, $startTime: Float!, $endTime: Float!, $toolId: Int!) {
      requestBorrow(userId: $userId, startTime: $startTime, endTime: $endTime, toolId: $toolId)
    }
    """

  public let operationName: String = "RequestBorrow"

  public var userId: Int
  public var startTime: Double
  public var endTime: Double
  public var toolId: Int

  public init(userId: Int, startTime: Double, endTime: Double, toolId: Int) {
    self.userId = userId
    self.startTime = startTime
    self.endTime = endTime
    self.toolId = toolId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "startTime": startTime, "endTime": endTime, "toolId": toolId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("requestBorrow", arguments: ["userId": GraphQLVariable("userId"), "startTime": GraphQLVariable("startTime"), "endTime": GraphQLVariable("endTime"), "toolId": GraphQLVariable("toolId")], type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(requestBorrow: Int) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "requestBorrow": requestBorrow])
    }

    public var requestBorrow: Int {
      get {
        return resultMap["requestBorrow"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "requestBorrow")
      }
    }
  }
}

public final class DenyBorrowMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DenyBorrow($id: Int) {
      denyBorrow(id: $id)
    }
    """

  public let operationName: String = "DenyBorrow"

  public var id: Int?

  public init(id: Int? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("denyBorrow", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.scalar(Bool.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(denyBorrow: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "denyBorrow": denyBorrow])
    }

    public var denyBorrow: Bool {
      get {
        return resultMap["denyBorrow"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "denyBorrow")
      }
    }
  }
}

public final class ApproveBorrowMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ApproveBorrow($id: Int) {
      approveBorrow(id: $id)
    }
    """

  public let operationName: String = "ApproveBorrow"

  public var id: Int?

  public init(id: Int? = nil) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("approveBorrow", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.scalar(Bool.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(approveBorrow: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "approveBorrow": approveBorrow])
    }

    public var approveBorrow: Bool {
      get {
        return resultMap["approveBorrow"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "approveBorrow")
      }
    }
  }
}

public final class AcceptReturnMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AcceptReturn($borrowId: Int!, $accept: Boolean!) {
      acceptReturn(borrowId: $borrowId, accept: $accept) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "AcceptReturn"

  public var borrowId: Int
  public var accept: Bool

  public init(borrowId: Int, accept: Bool) {
    self.borrowId = borrowId
    self.accept = accept
  }

  public var variables: GraphQLMap? {
    return ["borrowId": borrowId, "accept": accept]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("acceptReturn", arguments: ["borrowId": GraphQLVariable("borrowId"), "accept": GraphQLVariable("accept")], type: .object(AcceptReturn.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(acceptReturn: AcceptReturn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "acceptReturn": acceptReturn.flatMap { (value: AcceptReturn) -> ResultMap in value.resultMap }])
    }

    public var acceptReturn: AcceptReturn? {
      get {
        return (resultMap["acceptReturn"] as? ResultMap).flatMap { AcceptReturn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "acceptReturn")
      }
    }

    public struct AcceptReturn: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Borrow"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "Borrow", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class ReturnToolMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ReturnTool($borrowId: Int!) {
      returnTool(borrowId: $borrowId) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "ReturnTool"

  public var borrowId: Int

  public init(borrowId: Int) {
    self.borrowId = borrowId
  }

  public var variables: GraphQLMap? {
    return ["borrowId": borrowId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("returnTool", arguments: ["borrowId": GraphQLVariable("borrowId")], type: .object(ReturnTool.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(returnTool: ReturnTool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "returnTool": returnTool.flatMap { (value: ReturnTool) -> ResultMap in value.resultMap }])
    }

    public var returnTool: ReturnTool? {
      get {
        return (resultMap["returnTool"] as? ResultMap).flatMap { ReturnTool(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "returnTool")
      }
    }

    public struct ReturnTool: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Borrow"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "Borrow", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class CreateToolRatingMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateToolRating($revieweeId: Int!, $review: String, $reviewerId: Int!, $rating: Int!) {
      createToolRating(revieweeId: $revieweeId, review: $review, reviewerId: $reviewerId, rating: $rating) {
        __typename
        rating
      }
    }
    """

  public let operationName: String = "CreateToolRating"

  public var revieweeId: Int
  public var review: String?
  public var reviewerId: Int
  public var rating: Int

  public init(revieweeId: Int, review: String? = nil, reviewerId: Int, rating: Int) {
    self.revieweeId = revieweeId
    self.review = review
    self.reviewerId = reviewerId
    self.rating = rating
  }

  public var variables: GraphQLMap? {
    return ["revieweeId": revieweeId, "review": review, "reviewerId": reviewerId, "rating": rating]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createToolRating", arguments: ["revieweeId": GraphQLVariable("revieweeId"), "review": GraphQLVariable("review"), "reviewerId": GraphQLVariable("reviewerId"), "rating": GraphQLVariable("rating")], type: .nonNull(.object(CreateToolRating.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createToolRating: CreateToolRating) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createToolRating": createToolRating.resultMap])
    }

    public var createToolRating: CreateToolRating {
      get {
        return CreateToolRating(unsafeResultMap: resultMap["createToolRating"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createToolRating")
      }
    }

    public struct CreateToolRating: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ToolRating"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("rating", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(rating: Int) {
        self.init(unsafeResultMap: ["__typename": "ToolRating", "rating": rating])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var rating: Int {
        get {
          return resultMap["rating"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }
    }
  }
}

public final class CreateUserRatingMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateUserRating($revieweeId: Int!, $review: String, $reviewerId: Int!, $rating: Int!) {
      createUserRating(revieweeId: $revieweeId, review: $review, reviewerId: $reviewerId, rating: $rating) {
        __typename
        rating
      }
    }
    """

  public let operationName: String = "CreateUserRating"

  public var revieweeId: Int
  public var review: String?
  public var reviewerId: Int
  public var rating: Int

  public init(revieweeId: Int, review: String? = nil, reviewerId: Int, rating: Int) {
    self.revieweeId = revieweeId
    self.review = review
    self.reviewerId = reviewerId
    self.rating = rating
  }

  public var variables: GraphQLMap? {
    return ["revieweeId": revieweeId, "review": review, "reviewerId": reviewerId, "rating": rating]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createUserRating", arguments: ["revieweeId": GraphQLVariable("revieweeId"), "review": GraphQLVariable("review"), "reviewerId": GraphQLVariable("reviewerId"), "rating": GraphQLVariable("rating")], type: .nonNull(.object(CreateUserRating.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUserRating: CreateUserRating) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUserRating": createUserRating.resultMap])
    }

    public var createUserRating: CreateUserRating {
      get {
        return CreateUserRating(unsafeResultMap: resultMap["createUserRating"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createUserRating")
      }
    }

    public struct CreateUserRating: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserRating"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("rating", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(rating: Int) {
        self.init(unsafeResultMap: ["__typename": "UserRating", "rating": rating])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var rating: Int {
        get {
          return resultMap["rating"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "rating")
        }
      }
    }
  }
}
