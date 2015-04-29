//
//  FlagCodde.swift
//  CountryIDPhotosTableView2
//
//  Created by Audrey Li on 4/23/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation
enum FlagCode:String {
    case A = "\u{1F1E6}"
    case B = "\u{1F1E7}"
    case C = "\u{1F1E8}"
    case D = "\u{1F1E9}"
    case E = "\u{1F1EA}"
    case F = "\u{1F1EB}"
    case G = "\u{1F1EC}"
    case H = "\u{1F1ED}"
    case I = "\u{1F1EE}"
    case J = "\u{1F1EF}"
    case K = "\u{1F1F0}"
    case L = "\u{1F1F1}"
    case M = "\u{1F1F2}"
    case N = "\u{1F1F3}"
    case O = "\u{1F1F4}"
    case P = "\u{1F1F5}"
    case Q = "\u{1F1F6}"
    case R = "\u{1F1F7}"
    case S = "\u{1F1F8}"
    case T = "\u{1F1F9}"
    case U = "\u{1F1FA}"
    case V = "\u{1F1FB}"
    case W = "\u{1F1FC}"
    case X = "\u{1F1FD}"
    case Y = "\u{1F1FE}"
    case Z = "\u{1F1FF}"
    case Other = "Not a Flag Code"
    init(char: Character){
        switch char{
        case "A": self = .A
        case "B": self = .B
        case "C": self = .C
        case "D": self = .D
        case "E": self = .E
        case "F": self = .F
        case "G": self = .G
        case "H": self = .H
        case "I": self = .I
        case "J": self = .J
        case "K": self = .K
        case "L": self = .L
        case "M": self = .M
        case "N": self = .N
        case "O": self = .O
        case "P": self = .P
        case "Q": self = .Q
        case "R": self = .R
        case "S": self = .S
        case "T": self = .T
        case "U": self = .U
        case "V": self = .V
        case "W": self = .W
        case "X": self = .X
        case "Y": self = .Y
        case "Z": self = .Z
        default: self = .Other
            
        }
    }
}