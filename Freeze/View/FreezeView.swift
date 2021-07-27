//
//  FreezeView.swift
//  Freeze
//
//  Created by Jan Podmolík on 04.02.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct FreezeView: View {

    @ObservedObject var viewModel = FreezeViewModel()

    var body: some View {

        ZStack(alignment: .bottom) { // Just for flame on the bottom of stack
            Color.white
            VStack {
                ZStack {
                    Image(viewModel.pickedExercise.image)
                        .resizable()
                        .scaledToFit()
                        .opacity(viewModel.up ? 1 : 0)
                        .frame(height: viewModel.up ? height / 2 : 0)

                    if viewModel.countdownIsRunning {
                        Countdown(viewModel: viewModel)
                    }
                    
                    if viewModel.difficultyIsPicked, viewModel.up {
                        CancelButton(viewModel: viewModel)
                    }
                }
                .gesture(DragGesture(minimumDistance: 20)
                                            .onEnded { value in
                                                viewModel.executeGesture(with: value, onExercise: true)
                                            })

                ZStack {
                    VStack {
                        HStack(spacing: 15) {
                            ForEach(0..<viewModel.repetitions, id: \.self) { rep in
                                Rectangle()
                                    .frame(width: 40, height: 20)
                                    .foregroundColor(viewModel.finishedRepetitions > rep ? .white : .blue4)
                            }
                        }
                        .padding(.top, 10)

                        Spacer()

                        ZStack {
                            CircleCounter(viewModel: viewModel)
                            if !viewModel.difficultyIsPicked,
                               viewModel.pickedExercise.difficulties.count > 1 {
                                DifficultyArrows(viewModel: viewModel)
                            }
                        }
                        .padding(.horizontal, 8)
                        
                    }
                    .frame(height: viewModel.up ? height / 2 : height * 0.15)
                    .opacity(viewModel.up ? 1 : 0)
                    .background (
                        Group {
                            Rectangle()
                                .foregroundColor(.blue5)
                                .frame(width: width, height: 3)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: width, height: viewModel.up ? height / 2 : height * 0.15)
                            Rectangle()
                                .foregroundColor(.blue5)
                                .frame(width: width, height: 3)
                        }
                        .background(Color.blue5)
                        
                    )
                    .onTapGesture {
                        viewModel.upWithCheck()
                    }

                    if viewModel.pickedExercise.isUnilateral {
                        SideOptions(viewModel: viewModel)
                    }
                }
                .gesture(DragGesture(minimumDistance: 20)
                                            .onEnded { value in
                                                viewModel.executeGesture(with: value, onExercise: false)
                                            })

                ListView(viewModel: viewModel.listViewModel)
                    .frame(height: viewModel.up ? 0 : height * 0.85)
                    .offset(x: 0, y: viewModel.up ? 50 : 0)
                    .gesture(DragGesture(minimumDistance: 10)
                                .onEnded({ value in
                                    if value.translation.height > 0 {
                                        withAnimation {
                                            viewModel.upWithCheck()
                                        }
                                    }
                                }))
            }
            .onReceive(viewModel.timer) { _ in
                viewModel.updateTimer()
            }
            .onAppear {
                if viewModel.block {
                    viewModel.up = false
                }
            }

            AnimatedImage(name: "fire.gif")
                .resizable()
                .scaledToFit()
                .offset(y: viewModel.showingFlame ? viewModel.flameAnimationOffset : 200)
                .opacity(viewModel.showingFlame ? 1 : 0)

            if !viewModel.onboardingDone {
                Color.blue4
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                Onboarding(viewModel: viewModel)
            }
        }
    }
}

struct FreezeView_Previews: PreviewProvider {
    static var previews: some View {
        FreezeView().preferredColorScheme(.dark)
    }
}
