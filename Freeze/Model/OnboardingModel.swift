//
//  Onboarding.swift
//  Freeze
//
//  Created by Jan Podmolík on 13.03.2021.
//

import SwiftUI

struct OnboardingDialog {
    let text: String
    var width: CGFloat
    var offset: CGSize

    init(text: String, width: CGFloat = 0, offset: CGSize = .zero) {
        self.text = text
        self.width = width
        self.offset = offset
    }
}

let onboardingDialogs: [OnboardingDialog] = [
    /*0*/    .init(text: "❄️ Hello! ❄️\nWelcome in Freeze App!",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.5)),
    /*1*/     .init(text: "This app combines various isometric exercises, yoga poses and much more to help you stay in shape. 💪🏻",
                    width: width * 0.95, offset: .init(width: 0, height: 200)),
    /*2*/    .init(text: "I've already unlocked\n⬅️  this\n position for you.",
                   width: width * 0.5, offset: .init(width: width / 4.05, height: 120)),
    /*3*/    .init(text: "👆🏻You select or unselect a position by clicking on it.\nSelected positions\nwill appear in your list.",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.5)),
    /*4*/    .init(text: "⬆️\nBy staying in positions\nyou will fill this flame.",
                   width: width * 0.95, offset: .init(width: 0, height: 210)),
    /*5*/    .init(text: "If your flame is full\nyou can unlock 🔓\nanother position.",
                   width: width * 0.95, offset: .init(width: 0, height: 210)),
    /*6*/    .init(text: "Click here!  🥶 ",
                   width: width * 0.95, offset: .init(width: 0, height: 35)),
    /*7*/    .init(text: "Swiping here \n⬅️  Left or Right  ➡️\n will change position.",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.2)),
    /*8*/   .init(text: "Swiping here \n⬅️  Left or Right  ➡️\n will change difficulty.",
                  width: width * 0.95, offset: .init(width: 0, height: height * 0.65)),
    /*9*/    .init(text: "Position\n⬅️   Side   ➡️",
                   width: width * 0.6, offset: .init(width: 0, height: height * 0.42)),
    /*10*/   .init(text: "The number of repetitions\n⬇️",
                   width: width * 0.6, offset: .init(width: 0, height: height * 0.25)),
    /*11*/   .init(text: "Pick difficulty.\n⬇️",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.55)),
    /*12*/   .init(text: "Start timer.\n⬇️",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.55)),
    /*13*/  .init(text: "Swipe up ⬆️\n for positions list.",
                  width: width * 0.95, offset: .init(width: 0, height: height * 0.5)),
    /*14*/   .init(text: "Have FUN ❄️",
                   width: width * 0.95, offset: .init(width: 0, height: height * 0.5)),
    /*15*/   .init(text: "",
                   width: 0, offset: .init(width: 0, height: 0)),
]
