//
//  Exercise.swift
//  Hold_It WatchKit Extension
//
//  Created by Jan Podmolík on 03.02.2021.
//

import Foundation

enum Difficulty: Int, CaseIterable {
    case easy
    case normal
    case hard
}

struct Exercise: Identifiable, Hashable {
    let id: Int
    let name: String
    let image: String
    let points: Int
    var isUnilateral: Bool
    var isUnlocked: Bool = false
    var isSelected: Bool = false
    let difficulties: [ExerciseDifficulty]
}

struct ExerciseDifficulty: Identifiable, Hashable {
    let id: Int
    let time: Int
    let repetitions: Int
}

let sourceExercises: [Exercise] = [
    .init(id: 1, name: "Bird Dog", image: "bird_dog", points: 8, isUnilateral: true,
          difficulties: [.init(id: 0, time: 10, repetitions: 3),
                         .init(id: 1, time: 20, repetitions: 2),
                         .init(id: 2, time: 40, repetitions: 2)]),
    .init(id: 2, name: "Push Up - Up", image: "pushup_up", points: 8, isUnilateral: false,
          difficulties: [.init(id: 0, time: 10, repetitions: 3),
                         .init(id: 1, time: 20, repetitions: 3),
                         .init(id: 2, time: 40, repetitions: 2)]),
    .init(id: 3, name: "Push Up - Down", image: "pushup_down", points: 12, isUnilateral: false,
          difficulties: [.init(id: 0, time: 5, repetitions: 3),
                         .init(id: 1, time: 15, repetitions: 2),
                         .init(id: 2, time: 30, repetitions: 2)]),
    .init(id: 4, name: "Bridge", image: "bridge", points: 10, isUnilateral: false,
          difficulties: [.init(id: 0, time: 15, repetitions: 3),
                         .init(id: 1, time: 30, repetitions: 2),
                         .init(id: 2, time: 60, repetitions: 2)]),
    .init(id: 5, name: "Downward facing dog", image: "downward_dog", points: 8, isUnilateral: false,
          difficulties: [.init(id: 0, time: 15, repetitions: 1),
                         .init(id: 1, time: 30, repetitions: 1),
                         .init(id: 2, time: 60, repetitions: 1)]),
    .init(id: 6, name: "Frog Stand", image: "frog_stand", points: 14, isUnilateral: false,
          difficulties: [.init(id: 0, time: 6, repetitions: 3),
                         .init(id: 1, time: 12, repetitions: 3),
                         .init(id: 2, time: 24, repetitions: 2)]),
    .init(id: 7, name: "Hollow Hold", image: "hollow_hold", points: 10, isUnilateral: false,
          difficulties: [.init(id: 0, time: 10, repetitions: 3),
                         .init(id: 1, time: 20, repetitions: 3),
                         .init(id: 2, time: 40, repetitions: 2)]),
    .init(id: 8, name: "High Side Plank ", image: "high_side_plank", points: 10, isUnilateral: true,
          difficulties: [.init(id: 0, time: 12, repetitions: 2),
                         .init(id: 1, time: 30, repetitions: 1),
                         .init(id: 2, time: 60, repetitions: 1)]),
]

let emptyExercise: Exercise = .init(id: 0, name: "", image: "empty",
                                    points: 0, isUnilateral: false,
                                    difficulties: [.init(id: 0, time: 0, repetitions: 1),
                                                   .init(id: 0, time: 0, repetitions: 1),
                                                   .init(id: 0, time: 0, repetitions: 1)])
