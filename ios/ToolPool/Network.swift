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
    
  /*
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:80/graphql")!)
  */
  
  
  private(set) lazy var apollo: ApolloClient = {
    let client = URLSessionClient()
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)
    let provider = NetworkInterceptorProvider(client: client, store: store)
    let url = URL(string: "http://localhost:8000/graphql")!
    let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                       endpointURL: url)
    return ApolloClient(networkTransport: transport, store: store)
  }()
  
}


class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    // Find a better way to store your token this is just an example
    let token = ""
  
    
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        do {
            let token = try returnToken()
            print("In Network")
            print(token)
          
            request.addHeader(name: "authorization", value: "Bearer \(token)")

            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        } catch {
            print("Getting token failed.")
        }
    }
}
