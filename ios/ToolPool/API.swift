// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ToolByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ToolById($id: Int) {
      tool(id: $id) {
        __typename
        name
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
