//
//  FileTokenAddingInterceptor.swift
//  ToolPool
//
//  Created by Olsen on 11/20/20.
//

import Foundation
import Apollo

class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
      //let keychain = KeychainSwift()
      do {
          let token = try returnToken()
          request.addHeader(name: "Authorization", value: "Bearer " + token)
      } catch {
          print("Getting token failed.")
      }

      chain.proceedAsync(request: request,
                         response: response,
                         completion: completion)
    }
}
