//
//  UserSocialView.swift
//  TymeX
//
//  Created by Vinh Tran on 24/9/24.
//

import SwiftUI

struct UserSocialView: View {
    let user: UserDetails
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            VStack {
                Image(systemName: "person.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                
                if let followers = user.followers {
                    Text("\(followers)+")
                        .font(.footnote.bold())
                        .multilineTextAlignment(.center)
                }
                
                Text("Follower")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            VStack {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                
                if let following = user.following {
                    Text("\(following)+")
                        .font(.footnote.bold())
                        .multilineTextAlignment(.center)
                }
                
                Text("Following")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}


