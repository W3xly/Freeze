//
//  ExercisesView.swift
//  Freeze
//
//  Created by Jan Podmolík on 04.02.2021.
//

import SwiftUI

struct ListView: View {

    @ObservedObject var viewModel: ListViewModel
    @State private var showingUnlockScreen = false

    var body: some View {
        VStack(spacing: 0) {
            ListHeader(viewModel: viewModel)
                .padding(.top, 10)

            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: viewModel.grid) {
                    
                    ForEach(viewModel.exercises, id: \.self) { exercise in
                        ZStack {
                            Image(exercise.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .border(Color.blue5, width: 4)
                                .cornerRadius(5)
                                .overlay(
                                    Color.blue2.opacity(exercise.isSelected ? 0.1 : 0.6))

                             if exercise.isUnlocked == false {
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue5)
                                    .frame(width: 40)
                            }
                        }
                        .onTapGesture {
                            if exercise.isUnlocked {
                                viewModel.updateSelection(with: exercise)
                            } else {
                                viewModel.exerciseToUnlock = exercise
                                showingUnlockScreen.toggle()
                            }
                        }
                        .onLongPressGesture {
                            viewModel.exerciseToUnlock = exercise
                            viewModel.unlock()
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.bottom, 15)
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .sheet(isPresented: $showingUnlockScreen) {
            UnlockView(viewModel: viewModel)
        }
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel()).preferredColorScheme(.dark)

    }
}
