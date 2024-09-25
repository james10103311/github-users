//
//  UserPersonalView.swift
//  TymeX
//
//  Created by Vinh Tran on 24/9/24.
//

import SwiftUI

struct UserPersonalView: View {
    let user: UserDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Blog")
                .font(.headline.bold())
            if let blogStr = user.blog {
                Text(blogStr)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
