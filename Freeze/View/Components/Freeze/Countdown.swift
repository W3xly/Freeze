//
//  Countdown.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct Countdown: View {
    @ObservedObject var viewModel: FreezeViewModel
    var body: some View {
        ZStack {
            Color.blue1.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            Text(viewModel.countDownText)
                .font(.custom("Teko-Bold", size: viewModel.countDownText.count > 2 ? 100 : 200))
                .frame(width: width)
                .foregroundColor(.blue5)
        }
    }
}
