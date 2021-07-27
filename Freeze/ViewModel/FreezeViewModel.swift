//
//  FreezeViewModel.swift
//  Freeze
//
//  Created by Jan Podmolík on 12.02.2021.
//

import SwiftUI
import AVFoundation

enum Side {
    case left
    case right
}

enum Sound: String {
    case lowFlame = "smallFlame.mp3"
    case highFlame = "bigFlame.mp3"
    case matchStrike = "matchStrike.mp3"
}

class FreezeViewModel: ObservableObject {

    var listViewModel = ListViewModel()

    var pickedExercise: Exercise {
        if listViewModel.selectedExercises.isEmpty {
            return emptyExercise
        } else {
            if exerciseIndex < listViewModel.selectedExercises.count {
                return listViewModel.selectedExercises[exerciseIndex]
            } else {
                return listViewModel.selectedExercises[0]
            }
        }
    }

    var pickedDifficulty: ExerciseDifficulty {
        return pickedExercise.difficulties[difficultyIndex]
    }

    var exerciseIndex: Int = 0
    @Published var difficultyIndex: Int = 1 {
        didSet {
            defaults.set(difficultyIndex, forKey: CON_difficulty)
        }
    }

    var keepScreenOn: Bool = false {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = keepScreenOn
        }
    }

    @Published var up: Bool = true

    @Published private var actualSeconds: CGFloat = 0
    @Published private var timerIsRunning: Bool = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var trimSeconds: CGFloat = 1
    @Published var difficultyIsPicked: Bool = false

    @Published var countdownSeconds: Int = 3
    @Published var countdownIsRunning: Bool = false

    @Published var pickedSide: Side = .left
    @Published var finishedSides: [Side] = []
    @Published var finishedRepetitions: Int = 0

    @Published var showingFlame: Bool = false
    @Published var flameAnimationOffset: CGFloat = 120

    @Published var onboardingIndex: Int = 0
    @Published var onboardingDone: Bool = true

    var block: Bool {
        listViewModel.selectedExercises.isEmpty
    }

    var repetitions: Int {
        return pickedDifficulty.repetitions
    }

    var time: Int {
        return pickedDifficulty.time
    }

    var leftIsDone: Bool {
        return finishedSides.contains(.left)
    }

    var rightIsDone: Bool {
        return finishedSides.contains(.right)
    }

    var countDownText: String {
        return countdownSeconds > 0 ? "\(countdownSeconds)" : "FREEZE"
    }

    var isInactive: Bool {
        return !timerIsRunning && !countdownIsRunning
    }

    var secondsToDisplay: String {
        switch timerIsRunning {
        case true:
            return "\(Int(actualSeconds))"
        case false:
            if difficultyIsPicked {
                return "\(time)"
            } else {
                return "\(repetitions)x\(time)"
            }
        }
    }

    private var audioPlayer: AVAudioPlayer?

    // MARK: Initialization

    init() {
        getDifficulty()
        checkOnboarding()
    }

    func isPicked(side: Side) -> Bool {
        switch side {
        case .left:
            return pickedSide == .left
        case .right:
            return pickedSide == .right
        }
    }

    func pickSide(side: Side) {
        guard isInactive else { return }
        switch side {
        case .left:
            if !leftIsDone {
                pickedSide = side
            }
        case .right:
            if !rightIsDone {
                pickedSide = side
            }
        }
    }

    func pickDifficulty() {
        withAnimation {
            finishedSides = []
            finishedRepetitions = 0
            trimSeconds = 1
            difficultyIsPicked = true
        }
    }

    func correctExercise() { // Ensure to not try to display exercise that is not on list
        if !listViewModel.selectedExercises.contains(pickedExercise) || pickedExercise.id == 0 {
            changeExercise(to: .right)
        }
    }

    func changeExercise(to side: Side) {
        guard finishedSides.isEmpty, finishedRepetitions == 0 else { return }

        switch side {
        case .right:
            if exerciseIndex < listViewModel.selectedExercises.count - 1 {
                exerciseIndex += 1
            } else {
                exerciseIndex = 0
            }
        case .left:
            if exerciseIndex > 0 {
                exerciseIndex -= 1
            } else {
                exerciseIndex = listViewModel.selectedExercises.count - 1
            }
        }
        difficultyIsPicked = false
        finishedRepetitions = 0
        finishedSides = []
    }

    func changeDifficulty(to side: Side) {
        guard !difficultyIsPicked else { return }
        switch side {
        case .left:
            if difficultyIndex > 0 {
                difficultyIndex -= 1
            }
        case .right:
            if difficultyIndex < 2 {
                difficultyIndex += 1
            }
        }
    }

    func startTimer() {
        guard isInactive else { return }
        startCountdown {
            withAnimation(.easeInOut) {
                guard self.difficultyIsPicked else { return }
                self.timerIsRunning = true
                self.actualSeconds = CGFloat(self.time)
                self.keepScreenOn = true
            }
        }
    }

    func startCountdown(completion: @escaping () -> Void) {
        countdownIsRunning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3, execute: {
            withAnimation {
                self.countdownIsRunning = false
                self.countdownSeconds = 3
                completion()
            }
        })
    }
    
    func restartTimer() {
        withAnimation {
            actualSeconds = 0
            trimSeconds = 0
        }
    }

    func cancelExercise() {
        difficultyIsPicked = false
        timerIsRunning = false
        countdownIsRunning = false
        keepScreenOn = false
        actualSeconds = 0
        trimSeconds = 0
        finishedRepetitions = 0
        finishedSides = []
    }

    func finishExercise() {
        self.finishedRepetitions = 0
        listViewModel.updateFlame(with: pickedExercise.points) { flameSize in
            switch flameSize {
            case .low:
                self.flameAnimationOffset = 130
                self.playSound(.lowFlame)
            case .high:
                self.flameAnimationOffset = 20
                self.playSound(.highFlame)
            }
            withAnimation {
                self.showingFlame = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 0.4)) {
                    self.showingFlame = false
                }
            }
            self.changeExercise(to: .right)
        }
    }

    func secondsRunnedOut() {
        if timerIsRunning && actualSeconds == 0 {
            self.playSound(.matchStrike)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.trimSeconds = 1
                    if self.pickedExercise.isUnilateral { // Unilateral exercises
                        self.finishedSides.append(self.pickedSide)
                        if self.finishedSides.count == 2 {
                            self.finishedRepetitions += 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation {
                                    self.finishedSides = []
                                    if self.finishedRepetitions == self.repetitions {
                                        // Show next exercise in case of completed reps
                                        self.finishExercise()
                                    }
                                }
                            }
                        }
                        self.pickedSide = self.isPicked(side: .left) ? .right : .left
                    } else { // Single side exercises
                        self.finishedRepetitions += 1
                        if self.finishedRepetitions == self.repetitions {
                            // Show next exercise in case of completed reps
                            self.finishExercise()
                        }
                    }
                }
            }
            keepScreenOn = false
        }
    }
    
    func updateTimer() {
        guard timerIsRunning || countdownIsRunning else { return }
        
        if countdownIsRunning {
            countdownSeconds -= 1
        }

        guard actualSeconds > 0 else { timerIsRunning = false; return }
        actualSeconds -= 1
        withAnimation(.default) {
            trimSeconds = actualSeconds / CGFloat(time)
        }
        secondsRunnedOut()
    }

    func getDifficulty() {
        difficultyIndex = defaults.integer(forKey: CON_difficulty)
    }

    func checkOnboarding() {
        let done = defaults.bool(forKey: CON_onboarding)
        onboardingDone = done
    }

    func upWithCheck() {
        guard !block, !up else { return }
        correctExercise()
        withAnimation {
            up = true
        }
    }

    func playSound(_ sound: Sound) {
        guard let path = Bundle.main.path(forResource: sound.rawValue, ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.play()
        } catch {
            print("DEBUG: Failed to play sound.")
        }
    }

    func executeGesture(with value: DragGesture.Value, onExercise: Bool) {
        let x = abs(value.startLocation.x.distance(to: value.location.x))
        let y = abs(value.startLocation.y.distance(to: value.location.y))
        let isVertical = x > y

        withAnimation {
            if value.translation.width < 0, isVertical {
                if onExercise {
                    changeExercise(to: .right)
                } else {
                    changeDifficulty(to: .right)
                }
            }
            if value.translation.width > 0, isVertical {
                if onExercise {
                    changeExercise(to: .left)
                } else {
                    changeDifficulty(to: .left)
                }
            }
            if value.translation.height < 0, !isVertical {
                if isInactive {
                    up = false
                }
            }
            if value.translation.height > 0, !isVertical {
                upWithCheck()
            }
        }
    }
}

// MARK: Onboarding

extension FreezeViewModel {
    func nextOnboardingStep() {
        onboardingIndex += 1
        switch onboardingIndex {
        case 2:
            listViewModel.unlock()
            defaults.setValue(true, forKey: CON_onboarding)
        case 3:
            listViewModel.updateSelection(with: listViewModel.unlockedExercises[0])
        case 4:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 1.2)) {
                    self.listViewModel.updateFlame(with: 50) {_ in}
                }
            }
        case 7:
            up = true
        case 12:
            pickDifficulty()
        case 14:
            up = false
        case 15:
            onboardingDone = true
        default:
            break
        }
    }
}
