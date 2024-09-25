//
//  UserDetailView.swift
//  TymeX
//
//  Created by Vinh Tran on 24/9/24.
//

import SwiftUI

/// View that displays detailed information about a specific GitHub user.
struct UserDetailView: View {
    /// View model that manages the user detail data and operations
    @ObservedObject private var viewModel: UserDetailViewModel
    
    let username: String
    
    init(viewModel: UserDetailViewModel, username: String) {
        self.viewModel = viewModel
        self.username = username
    }
    
    var body: some View {
        if let error = viewModel.error {
            Text(error)
        } else {
            if viewModel.isLoading {
                ProgressView()
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let userDetail = viewModel.userDetail {
                        UserCardView(user: userDetail)
                        UserSocialView(user: userDetail)
                        UserPersonalView(user: userDetail)
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                GitHubToolbarItem()
            }
            .navigationBarTitle("User Details", displayMode: .inline)
            .task {
                await viewModel.loadUserDetails(username: username)
            }
        }
    }
}

