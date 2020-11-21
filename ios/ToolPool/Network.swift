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
    
  //private(set) lazy var apollo = ApolloClient(
    //url: URL(string: "http://localhost:80/graphql")!)
  
  private(set) lazy var apollo: ApolloClient = {
    let client = URLSessionClient()
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let provider = NetworkInterceptorProvider(client: client, store: store)
    let url = URL(string: "http://localhost:80/graphql")!
    let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                       endpointURL: url)
    return ApolloClient(networkTransport: transport, store: store)
  }()
  
}
