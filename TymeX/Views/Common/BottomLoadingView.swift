//
//  BottomLoadingView.swift
//  TymeX
//
//  Created by Vinh Tran on 25/9/24.
//

import SwiftUI

struct BottomLoadingView: View {
    var body: some View {
        Group {
            HStack {
                Spacer()
                ProgressView()
                    .frame(height: 50)
                Spacer()
            }
        }
        .listRowSeparator(.hidden)
    }
}


