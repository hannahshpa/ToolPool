//
//  RateRental.swift
//  ToolPool
//
//  Created by Alissa McNerney on 11/13/20.
//

import SwiftUI

struct RateRental: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let toolName: String
    //let geometry: GeometryProxy
    var body: some View {
        VStack {
            Text("Rate Your Rental").font(.largeTitle)
            Divider()
            HStack { // position views horizontally
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)}
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)}
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)}
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)}
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                    //self.mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)}
            }
        }
    }
}
