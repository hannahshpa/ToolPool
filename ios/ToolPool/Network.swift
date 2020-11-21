//
//  Network.swift
//  ToolPool
//
//  Created by Olsen on 11/16/20.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:8000/graphql")!)
}
