//
//  Onboarding.swift
//  Freeze
//
//  Created by Jan Podmolík on 27.03.2021.
//

import SwiftUI


struct Onboarding: View {

    @ObservedObject var viewModel: FreezeViewModel

    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut) {
                    viewModel.nextOnboardingStep()
                }
            } label: {
                Text(onboardingDialogs[viewModel.onboardingIndex].text)
                    .multilineTextAlignment(.center)
                    .font(.custom("Teko-Regular", size: 40))
                    .foregroundColor(.blue2)
                    .frame(width: onboardingDialogs[viewModel.onboardingIndex].width)
                    .border(Color.blue5, width: 4)
                    .background(Color.blue5)
                    .cornerRadius(5)

            }
            Spacer()
        }
        .offset(onboardingDialogs[viewModel.onboardingIndex].offset)
    }
}

