//
//  UnlockView.swift
//  Freeze
//
//  Created by Jan Podmolík on 07.03.2021.
//

import SwiftUI

struct UnlockView: View {

    @ObservedObject var viewModel: ListViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 0) {
                Color.black
                    .frame(width: 100, height: 100)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .offset(y: viewModel.flameOffset * 2)
                    )
                    .mask(
                        Text("🔥")
                            .font(.system(size: 100))
                    )
                    .padding()
                Image(viewModel.exerciseToUnlock.image)
                    .resizable()
                    .scaledToFit()
                if viewModel.fullFlame {
                    Button {
                        viewModel.unlock()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                            Text("Unlock")
                                .font(.custom("Teko-Regular", size: 50))
                                .foregroundColor(.blue5)
                                .frame(width: width - 40)
                                .border(Color.blue5, width: 4)
                                .cornerRadius(5)
                    }
                    .padding(.bottom, 5)
                }
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Close")
                        .font(.custom("Teko-Regular", size: 50))
                        .foregroundColor(.blue2)
                        .frame(width: width - 40)
                        .border(Color.blue5, width: 4)
                        .background(Color.blue5)
                        .cornerRadius(5)
                }
            }
            .padding(.bottom, 5)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundColor(.blue5)
                    }
                    .padding(30)
                }
                Spacer()
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct UnlockView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockView(viewModel: ListViewModel())
    }
}
