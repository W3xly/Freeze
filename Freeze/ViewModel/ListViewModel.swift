//
//  ExercisesViewModel.swift
//  Freeze
//
//  Created by Jan Podmolík on 14.02.2021.
//

import SwiftUI

enum FlameSize {
    case low
    case high
}

class ListViewModel: ObservableObject {

    @Published var exercises: [Exercise] = sourceExercises
    @Published var flameOffset: CGFloat = 50 {
        didSet {
            defaults.setValue(Int(flameOffset), forKey: CON_flame)
        }
    }
    var fullFlame: Bool {
        return flameOffset == 0
    }

    var exerciseToUnlock: Exercise = sourceExercises[0]

    var selectedExercises: [Exercise] {
        return exercises.filter({ $0.isSelected })
    }

    var unlockedExercises: [Exercise] {
        return exercises.filter({ $0.isUnlocked })
    }

    var selectedIds: [Int] = []
    var unlockedIds: [Int] = []

    let grid = [GridItem(.flexible()),
                GridItem(.flexible())]

    init() {
        getIds()
        getFlame()
        exercises.sort { $0.isUnlocked && !$1.isUnlocked }
    }

    func selectAll() {
        for (index, exercise) in exercises.enumerated() where exercise.isUnlocked {
            exercises[index].isSelected = true
        }
        saveSelectedToDefaults()
    }

    func unselectAll() {
        for (index, _) in exercises.enumerated() {
            exercises[index].isSelected = false
        }
        saveSelectedToDefaults()
    }

    func unlock() {
        for (index, exercise) in exercises.enumerated() where exercise == exerciseToUnlock {
            exercises[index].isUnlocked = true
        }
        let unlocked: [Int] = unlockedExercises.map { $0.id }
        defaults.set(unlocked, forKey: CON_unlocked)
        defaults.set(50, forKey: CON_flame)
        getFlame()
        exercises.sort { $0.isUnlocked && !$1.isUnlocked }
    }

    func updateFlame(with points: Int, completion: @escaping (FlameSize) -> Void) {
        flameOffset -= CGFloat(points)
        flameOffset = max(flameOffset, 0) // Negative set always to 0

        var flameSize: FlameSize {
            return flameOffset > 0 ? .low : .high
        }
        completion(flameSize)
    }

    func updateSelection(with exerciseToUpdate: Exercise) {
        guard exerciseToUpdate.isUnlocked else { return }
        for (index, exercise) in exercises.enumerated() where exercise == exerciseToUpdate  {
            exercises[index].isSelected.toggle()
        }
        saveSelectedToDefaults()
    }

    func saveSelectedToDefaults() {
        let selected: [Int] = selectedExercises.map { $0.id }
        defaults.set(selected, forKey: CON_selected)
    }

    func getIds() {
        if let unlockedIds: [Int] = defaults.array(forKey: CON_unlocked) as? [Int] {
            self.unlockedIds = unlockedIds
        }
        if let selectedIds: [Int] = defaults.array(forKey: CON_selected) as? [Int] {
            self.selectedIds = selectedIds
        }

        for (index, exercise) in exercises.enumerated() {
            exercises[index].isUnlocked = unlockedIds.contains(exercise.id)
            exercises[index].isSelected = selectedIds.contains(exercise.id)
        }
    }
    

    func getFlame() {
        withAnimation(.linear(duration: 2)) {
            if !unlockedExercises.isEmpty {
                self.flameOffset = CGFloat(defaults.integer(forKey: CON_flame))
            }
        }
    }
}

struct ListVM: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
