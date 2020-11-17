// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ToolByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ToolById {
      tool(id: 1) {
        __typename
        name
      }
    }
    """

  public let operationName: String = "ToolById"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tool", arguments: ["id": 1], type: .object(Tool.selections)),
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
