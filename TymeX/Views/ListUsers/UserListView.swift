//
//  UserListView.swift
//  TymeX
//
//  Created by Vinh Tran on 23/9/24.
//

import SwiftUI

/// View that displays a list of GitHub users and supports infinite scrolling.
struct UserListView: View {
    /// View model that manages the user list data and operations
    @StateObject private var viewModel = UserListViewModel(GitHubService())
    
    var body: some View {
        NavigationView {
            if let error = viewModel.error {
                Text(error)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(GitHubService()), username: user.login ?? "")) {
                                UserRowView(user: user)
                            }
                        }
                        
                        // Loading indicator or trigger for next page
                        if !viewModel.isLastPage {
                            BottomLoadingView()
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreUsers()
                                    }
                                }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("GitHub Users")
                .onAppear {
                    if viewModel.users.isEmpty {
                        Task {
                            await viewModel.loadMoreUsers()
                        }
                    }
                }
                .refreshable {
                    await viewModel.refreshUsers()
                }
                
            }
        }
        .accentColor(.black)
    }
}


