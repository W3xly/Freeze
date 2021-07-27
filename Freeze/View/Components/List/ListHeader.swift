//
//  ListHeader.swift
//  Freeze
//
//  Created by Jan Podmolík on 15.02.2021.
//

import SwiftUI

struct ListHeader: View {

    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    viewModel.selectAll()
                } label: {
                    Text("Select All")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.blue5)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .border(Color.blue5, width: 3)
                }
                Color.black
                    .frame(width: 50, height: 50)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .top, endPoint: .bottom)
                            .frame(width: 50, height: 50)
                            .offset(y: viewModel.flameOffset)
                    )
                    .mask(
                        Text("🔥")
                            .font(.system(size: 50))
                            .offset(x: -3)
                    )
                    .padding()
                Button {
                    viewModel.unselectAll()
                } label: {
                    Text("Unselect All")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.blue5)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .border(Color.blue5, width: 3)
                        .overlay(Color.blue2.opacity(0.4))
                }

            }
            .frame(maxWidth: .infinity, maxHeight: 35)
            .padding()

            Rectangle()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 3)
                .foregroundColor(.blue5)
        }
    }
}

