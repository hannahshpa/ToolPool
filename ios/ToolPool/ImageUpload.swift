//
//  ImageUpload.swift
//  ToolPool
//
//  Created by Olsen on 11/27/20.
//

import SwiftUI
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

func AddImage(tool_id: Int, addImage: UIImage) throws {
  var semaphore = DispatchSemaphore (value: 0)

  //print("IMGAE STRING")
  //print(addImage.toString()!)
  let parameters = [
    [
      "key": "toolId",
      "value": String(tool_id),
      "type": "text"
    ],
    [
      "key": "imageFile",
      "src": addImage.toString()!,
      "type": "file"
    ]] as [[String : Any]]

  let boundary = "Boundary-\(UUID().uuidString)"
  var body = ""
  var error: Error? = nil
  for param in parameters {
    if param["disabled"] == nil {
      let paramName = param["key"]!
      body += "--\(boundary)\r\n"
      body += "Content-Disposition:form-data; name=\"\(paramName)\""
      let paramType = param["type"] as! String
      if paramType == "text" {
        let paramValue = param["value"] as! String
        body += "\r\n\r\n\(paramValue)\r\n"
      } else {
        let paramSrc = param["src"] as! String
        let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
        let fileContent = String(data: fileData, encoding: .utf8)!
        body += "; filename=\"\(paramSrc)\"\r\n"
          + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
      }
    }
  }
  body += "--\(boundary)--\r\n";
  let postData = body.data(using: .utf8)

  var request = URLRequest(url: URL(string: "localhost:80/uploadImage")!,timeoutInterval: Double.infinity)
  
  do {
      let token = try returnToken()

    request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()

  } catch {
      print("Getting token failed.")
  }
}

extension UIImage {
    func toString() -> String? {
      let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
