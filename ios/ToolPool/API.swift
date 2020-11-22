// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum ToolCondition: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case poor
  case fair
  case new
  case good
  case great
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "poor": self = .poor
      case "fair": self = .fair
      case "new": self = .new
      case "good": self = .good
      case "great": self = .great
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .poor: return "poor"
      case .fair: return "fair"
      case .new: return "new"
      case .good: return "good"
      case .great: return "great"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ToolCondition, rhs: ToolCondition) -> Bool {
    switch (lhs, rhs) {
      case (.poor, .poor): return true
      case (.fair, .fair): return true
      case (.new, .new): return true
      case (.good, .good): return true
      case (.great, .great): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ToolCondition] {
    return [
      .poor,
      .fair,
      .new,
      .good,
      .great,
    ]
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
        condition
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
          GraphQLField("condition", type: .nonNull(.scalar(ToolCondition.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, description: String, condition: ToolCondition) {
        self.init(unsafeResultMap: ["__typename": "Tool", "name": name, "description": description, "condition": condition])
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

      public var condition: ToolCondition {
        get {
          return resultMap["condition"]! as! ToolCondition
        }
        set {
          resultMap.updateValue(newValue, forKey: "condition")
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
          loanPeriod {
            __typename
            start
          }
          tool {
            __typename
            name
          }
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
            GraphQLField("loanPeriod", type: .nonNull(.object(LoanPeriod.selections))),
            GraphQLField("tool", type: .nonNull(.object(Tool.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(loanPeriod: LoanPeriod, tool: Tool) {
          self.init(unsafeResultMap: ["__typename": "Borrow", "loanPeriod": loanPeriod.resultMap, "tool": tool.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public struct LoanPeriod: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TimeSlot"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("start", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(start: String) {
            self.init(unsafeResultMap: ["__typename": "TimeSlot", "start": start])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var start: String {
            get {
              return resultMap["start"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "start")
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
          id
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
            GraphQLField("start", type: .nonNull(.scalar(String.self))),
            GraphQLField("end", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(start: String, end: String) {
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

        public var start: String {
          get {
            return resultMap["start"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "start")
          }
        }

        public var end: String {
          get {
            return resultMap["end"]! as! String
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
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String) {
          self.init(unsafeResultMap: ["__typename": "Tool", "id": id, "name": name])
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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, email: String) {
        self.init(unsafeResultMap: ["__typename": "User", "name": name, "email": email])
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
    }
  }
}
