//
//  ExercisesViewModel.swift
//  Freeze
//
//  Created by Jan Podmolík on 14.02.2021.
//

import SwiftUI

class ListViewModel: ObservableObject {

    @Published var exercises: [Exercise] = sourceExercises
    @Published var selectedExercises: [Exercise] = []
    @Published var flameOffset: CGFloat = 0

    let grid = [GridItem(.flexible()),
                GridItem(.flexible())]

    init() {
        unlockExercises()
        selectExercises()
        getFlame()
    }

    func selectAll() {
        var selected: [Int] = []
        for (index, exercise) in exercises.enumerated() {
            if exercise.isUnlocked {
                exercises[index].isSelected = true
                selected.append(exercise.id)
            }
        }
        defaults.set(selected, forKey: CON_selected)
        selectExercises()
    }

    func unselectAll() {
        defaults.set([], forKey: CON_selected)
        selectExercises()
    }

    func getFlame() {
        self.flameOffset = CGFloat(defaults.integer(forKey: CON_flame))
    }

    func selectExercises() {
        guard let selectedIds: [Int] = defaults.array(forKey: CON_selected) as? [Int] else { return }
        for (index, exercise) in exercises.enumerated() {
            if selectedIds.contains(exercise.id) {
                exercises[index].isSelected = true
                selectedExercises.append(exercise)
            } else {
                exercises[index].isSelected = false
                if selectedExercises.contains(exercise) {
                    selectedExercises.remove(exercise)
                }
            }
        }
    }

    func unlockExercises() {
        guard let unlockedIds: [Int] = defaults.array(forKey: CON_unlocked) as? [Int] else { return }
        for (index, exercise) in exercises.enumerated() where unlockedIds.contains(exercise.id) {
            exercises[index].isUnlocked = true
        }
    }

    func updateSelection(with exercise: Exercise) {
        guard let unlockedIds: [Int] = defaults.array(forKey: CON_unlocked) as? [Int],
              unlockedIds.contains(exercise.id),
              var selectedIds: [Int] = defaults.array(forKey: CON_selected) as? [Int] else { return }

        if selectedIds.contains(exercise.id) {
            selectedIds.remove(exercise.id)
        } else {
            selectedIds.append(exercise.id)
        }

        defaults.set(selectedIds, forKey: CON_selected)
        selectExercises()
    }
}
