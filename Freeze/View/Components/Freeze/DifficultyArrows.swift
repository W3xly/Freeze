//
//  DifficultyArrows.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct DifficultyArrows: View {
    @ObservedObject var viewModel: FreezeViewModel
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    viewModel.changeDifficulty(to: .left)
                }
            } label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.trailing, 20)
                    .opacity(viewModel.difficultyIndex > 0 ? 1 : 0)
            }

            Spacer()

            Button {
                withAnimation {
                    viewModel.changeDifficulty(to: .right)
                }
            } label: {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.leading, 20)
                    .opacity(viewModel.difficultyIndex < 2 ? 1 : 0)
            }
        }
    }
}

struct ArrowsFreezeView_Previews: PreviewProvider {
    static var previews: some View {
        FreezeView()
    }
}
