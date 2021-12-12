//
//  Card.swift
//  SetGame
//
//  Created by Yousef Zuriqi on 04/12/2021.
//

import Foundation


struct Card: Equatable, Hashable {
    let shape: Shape
    let shade: Shade
    let color: Color
    let number: Number
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.shape == rhs.shape && lhs.color == rhs.color &&
        lhs.shade == rhs.shade && lhs.number == rhs.number)
    }

    
    init(shape: Shape, shade: Shade, color: Color, number: Number) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.number = number
    }
    
    enum Shape: CaseIterable {
        case oval
        case diamond
        case squiggle
    }
    
    enum Shade: CaseIterable {
        case solid
        case open
        case striped
    }
    
    enum Color: CaseIterable {
        case orange
        case purple
        case green
    }
    
    enum Number: Int, CaseIterable {
        case one
        case two
        case three
    }
}

