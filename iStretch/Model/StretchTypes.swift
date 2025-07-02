//
//  StretchTypesModel.swift
//  iStretch
//
//  Created by John Newman on 24/5/2025.
//

import Foundation
import SwiftUI

struct StretchTypes: Identifiable, Hashable {
    
    let id = UUID()
    let name: String
    let image: String
    let stretches: [Stretch]
    let theme: [Color]
}

struct Stretch: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let instructions: [String]
    var duration: Double = 60.0
}


//Stretch Instructions
let lyingRightHamstringStretchInstructions = [
    "Lie on your back.",
    "Lift your right leg straight up towards the ceiling",
    "Keep your leg as straight as possible."
]

let lyingLeftHamstringStretchInstructions = [
    "Lie on your back.",
    "Lift your left leg straight up towards the ceiling",
    "Keep your leg as straight as possible."
]

let headToLeftShoulderPullInstructions = [
    "Sit upright",
    "Wrap your left arm around your back",
    "Tilt your head to the right, towards your right shoulder",
    "Take your right hand and gently pull your head towards your right shoulder"
]

let headToRightShoulderPullInstructions = [
    "Sit upright",
    "Wrap your right arm around your back",
    "Tilt your head to the left, towards your left shoulder",
    "Take your left hand and gently pull your head towards your left shoulder"
]

let lyingRightKneeToChestInstructions = [
    "Lie on your back.",
    "Bend your right knee and pull it towards your chest with your hands.",
]

let lyingLeftKneeToChestInstructions = [
    "Lie on your back.",
    "Bend your left knee and pull it towards your chest with your hands.",
]

let supineTwistLeftInstructions = [
    "Lie on your back",
    "Keep your knees bent and feet flat on the bed.",
    "Let your knees fall to the left side while keeping your shoulders on the bed.",
    "Return to center at the end.",
    ]

let supineTwistRightInstructions = [
    "Lie on your back",
    "Keep your knees bent and feet flat on the bed.",
    "Let your knees fall to the right side while keeping your shoulders on the bed.",
    "Return to center at the end.",
    ]

let legsUpInstructions = [
    "Lie on your back.",
    "Raise both legs straight up towards the ceiling, (or rest them against a wall if possible)",
    ]

let quadStretchRightInstructions = [
    "Lie on your right side",
    "Grab the front of your left foot",
    "Pull your heel toward buttock",
    "Keep your knees together",
]

let quadStretchLeftInstructions = [
    "Lie on your left side", 
    "Grab the front of your right foot",
    "Pull your heel toward buttock",
    "Keep your knees together",
]

let standingCalfRightInstructions = [
    "Stand up",
    "Step right leg back",
    "Press your heel down",
    "Lean forward, keeping your heel as flat as possible"
]

let standingCalfLeftInstructions = [
    "Stand up",
    "Step left leg back",
    "Press your heel down",
    "Lean forward, keeping your heel as flat as possible"
]

//Stretch List

//Lower Body

let legsUp = Stretch(
    name: "Hamstrings/Lower Back",
    image: "legsup",
    instructions: legsUpInstructions)

let supineTwistLeft = Stretch(
    name: "Lower Back (Left)",
    image: "supinel",
    instructions: supineTwistLeftInstructions)

let supineTwistRight = Stretch(
    name: "Lower Back (Right)",
    image: "supiner",
    instructions: supineTwistRightInstructions)

let lyingRightKneeToChest = Stretch(
    name: "Glutes (Right)",
    image: "glutesr",
    instructions: lyingRightKneeToChestInstructions)

let lyingLeftKneeToChest = Stretch(
    name: "Glutes (Left)",
    image: "glutesl",
    instructions: lyingLeftKneeToChestInstructions)

let lyingRightHamstringStretch = Stretch(
    name: "Hamstrings (Right)",
    image: "lyinghamstringr",
    instructions: lyingRightHamstringStretchInstructions)

let lyingLeftHamstringStretch = Stretch(
    name: "Hamstrings (Left)",
    image: "lyinghamstringl",
    instructions: lyingLeftHamstringStretchInstructions)

let lyingQuadLeft = Stretch(
    name: "Quads (Left)",
    image: "quad",
    instructions: quadStretchLeftInstructions)

let lyingQuadRight = Stretch(
    name: "Quads (Right)",
    image: "quad",
    instructions: quadStretchRightInstructions)

let standingCalfRight = Stretch(
    name: "Standing Calf (Right)",
    image: "standingcalf",
    instructions: standingCalfRightInstructions)

let standingCalfLeft = Stretch(
    name: "Standing Calf (Left)",
    image: "standingcalf",
    instructions: standingCalfLeftInstructions)

//Upper Body
let chestStretch = Stretch(
    name: "Chest Stretch",
    image: "chest",
    instructions: [])

let shoulderStretch = Stretch(
    name: "Shoulder Stretch",
    image: "shoulder",
    instructions: [])

//Arms
let tricepStretch = Stretch(
    name: "Tricep Stretch",
    image: "tricep",
    instructions: [])

//Neck
let headToLeftShoulderPull = Stretch(
    name: "Neck Stretch (Left)",
    image: "headtoshoulderL",
    instructions: headToLeftShoulderPullInstructions)

let headToRightShoulderPull = Stretch(
    name: "Neck Stretch (Right)",
    image: "headtoshoulderR",
    instructions: headToRightShoulderPullInstructions)

//Back
let backStretch = Stretch(
    name: "Back Stretch",
    image: "back",
    instructions: [])

//potential images

// figure.pilates
// figure.yoga
// battery.100percent.bolt

//init of stretchtypes named stretch sets
let recovery: StretchTypes = StretchTypes(
    name: "Recovery",
    image: "bolt.fill",
    stretches: [
        lyingRightHamstringStretch,
        lyingLeftHamstringStretch,
        lyingQuadRight,
        lyingQuadLeft,
        standingCalfRight,
        standingCalfLeft,
        lyingRightKneeToChest,
        lyingLeftKneeToChest,
        headToRightShoulderPull,
        headToLeftShoulderPull,
    ],
    theme: [.mint, .green])


//complete sleep stretch set
let knockOut: StretchTypes = StretchTypes(
    name: "Knock Out",
    image: "moon.zzz.fill",
    stretches: [
        headToLeftShoulderPull,
        headToRightShoulderPull,
        lyingRightHamstringStretch,
        lyingLeftHamstringStretch,
        lyingRightKneeToChest,
        lyingLeftKneeToChest,
        supineTwistRight,
        supineTwistLeft,
        legsUp
    ],
    theme: [.indigo, .blue])



//init access to stretch types and named stretch sets
var stretchTypes: [StretchTypes] = [
    recovery,
    knockOut,
]
