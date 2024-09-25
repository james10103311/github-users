//
//  GitHubToolbarItem.swift
//  TymeX
//
//  Created by Vinh Tran on 25/9/24.
//

import SwiftUI

struct GitHubToolbarItem: ToolbarContent {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("")
                }
            }
        }
    }
}

