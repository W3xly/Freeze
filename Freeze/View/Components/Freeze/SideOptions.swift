//
//  SideOptions.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct SideOptions: View {
    @ObservedObject var viewModel: FreezeViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.pickSide(side: .left)
                } label: {
                    Text("L")
                        .foregroundColor(viewModel.leftIsDone ? .white : .blue4)
                        .padding(.leading, 20)
                        .padding(.trailing, 50)
                        .opacity(viewModel.up ? 1 : 0)
                        .shadow(color: viewModel.isPicked(side: .left) ? .blue1 : .clear, radius: 4)
                }
                Spacer()
                Button {
                    viewModel.pickSide(side: .right)
                } label: {
                    Text("R")
                        .foregroundColor(viewModel.rightIsDone ? .white : .blue4)
                        .padding(.trailing, 20)
                        .padding(.leading, 50)
                        .opacity(viewModel.up ? 1 : 0)
                        .shadow(color: viewModel.isPicked(side: .right) ? .blue1 : .clear, radius: 4)
                }
            }
            .font(.custom("Teko-Bold", size: 80))
            Spacer()
        }
        .allowsHitTesting(viewModel.up ? true : false)
        .offset(y: -15)
    }
}
