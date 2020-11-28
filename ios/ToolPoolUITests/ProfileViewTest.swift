//
//  ProfileViewTest.swift
//  ToolPoolUITests
//
//  Created by Olsen on 11/28/20.
//

import Foundation
import XCTest
import SwiftUI
@testable import ViewInspector

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
final class LazyVGridTests: XCTestCase {
    
    func testInspect() throws {
      guard #available(iOS 14, macOS 11.0, tvOS 14.0, *) else { return }
      let view = ProfileView()
      XCTAssertNoThrow(try view.inspect())
    }
  
  func testTexts() throws {
    guard #available(iOS 14, macOS 11.0, tvOS 14.0, *) else { return }
    let view = ProfileView()
    let values = try view.inspect().map { try $0.text().string() }
    print(values)
    XCTAssertNoThrow(try view.inspect())
  }
}
