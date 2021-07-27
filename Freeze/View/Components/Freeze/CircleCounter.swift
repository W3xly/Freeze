//
//  CircleCounter.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct CircleCounter: View {
    @ObservedObject var viewModel: FreezeViewModel
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 30)
                .frame(width: width * 0.6)
            Circle()
                .trim(from: 0, to: CGFloat(viewModel.trimSeconds))
                .stroke(Color.blue4, lineWidth: 30)
                .frame(width: viewModel.difficultyIsPicked ? width * 0.6 : 0)
                .rotationEffect(.init(degrees: -90), anchor: .center)
            Circle()
                .frame(width: viewModel.difficultyIsPicked ? 0 : width * 0.6)
                .foregroundColor(.white)
        }
        Button {
            if viewModel.difficultyIsPicked {
                viewModel.startTimer()
            } else {
                viewModel.pickDifficulty()
            }
        } label: {
            Text("\(viewModel.secondsToDisplay)")
                .font(.custom("Teko-SemiBold", size: 75))
                .foregroundColor(viewModel.difficultyIsPicked ? .white : .blue5)
                .offset(y: 5)
                .padding(.horizontal)
        }
    }
}
