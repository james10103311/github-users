//
//  UserRowView.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import SwiftUI
import NukeUI

struct UserRowView: View {
    let user: User
    
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
                
                if let urlStr = user.htmlUrl, let url = URL(string: urlStr) {
                    Text(urlStr)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .underline()
                        .onTapGesture {
                            UIApplication.shared.open(url)
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
