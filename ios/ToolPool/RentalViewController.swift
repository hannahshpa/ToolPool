//
//  RentalViewController.swift
//  ToolPool
//
//  Created by Hannah Park on 11/6/20.
//

import UIKit

class RentalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      // this is just a test
      Network.shared.apollo.fetch(query: ToolByIdQuery()) { result in
        switch result {
        case .success(let graphQLResult):
          print("Success! Result: \(graphQLResult)")
        case .failure(let error):
          print("Failure! Error: \(error)")
        }
      }

    }
    
}
