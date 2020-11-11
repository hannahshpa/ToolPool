//
//  ToolListingPage.swift
//  ToolPool
//
//  Created by Hannah Park on 11/11/20.
//

import SwiftUI

struct ToolListingPage: View {
    let listingName: String
    var body: some View {
        Text(listingName)
    }
}

struct ToolListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ToolListingPage(listingName:"Sample Tool")
    }
}
