//
//  UserCardView.swift
//  TymeX
//
//  Created by Vinh Tran on 24/9/24.
//

import SwiftUI
import NukeUI

struct UserCardView: View {
    let user: UserDetails
    
    var body: some View {
        HStack {
            ZStack {
                Color.gray.opacity(0.1)
                
                if let url = URL(string: user.avatarUrl ?? "") {
                    LazyImage(url: url) { state in
                        if let image = state.image {
                            image.resizable().aspectRatio(contentMode: .fill)
                        } else {
                            Color.gray
                        }
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                }
            }
            .frame(width: 92, height: 96)
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(user.login ?? "")
                    .font(.headline.bold())
                
                Divider()
                
                if let locationStr = user.location {
                    HStack {
                        Image(systemName: "location.circle.fill")
                            .font(.system(size: 12))
                        Text(locationStr)
                            .font(.footnote)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.all, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 3)
    }
}
