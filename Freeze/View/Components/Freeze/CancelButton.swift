//
//  CancelButton.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct CancelButton: View {
    @ObservedObject var viewModel: FreezeViewModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        viewModel.cancelExercise()
                    }
                } label: {
                    Image(systemName: "xmark.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .foregroundColor(.blue5)
                        .padding(.top, 50)
                        .padding(.trailing, 30)
                }
            }
            Spacer()
        }
    }
}
