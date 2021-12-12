//
//  Set.swift
//  SetGame
//
//  Created by Yousef Zuriqi on 04/12/2021.
//

import Foundation

// Game will have 81 unique Cards saved in "cards" Set.
// Game will start with new 12 random cards removed from "cards" Set, and added to
// "cardsOnBoard" array.
// Choose card will add it to "selectedCards" Array
// Choose up to three cards. if there is a match cards will be added to matched array
// If there is misMatch selected cards will be added to notMatched array
// Choosing the forth cards will ether:
// Thre......

struct SetModel {
    
     var cards = Set<Card>()
     var cardsOnBoard = [Card]()
     var selectedCards = [Card]()
     var alreadyMatchedCards = [Card]()
     var notMatchedCards = [Card]()
     var scoreCounter = 0
    
// MARK: - PUBLIC APIs
    
    mutating func newGame() {
        cards = []
        cardsOnBoard = []
        selectedCards =  []
        alreadyMatchedCards = []
        notMatchedCards = []
        createCards()
        scoreCounter = 0
    }
    
    init() {
        createCards()
    }
    
// MARK: - Cards Selection
    
    // Card selection values depends on how many cards ALREADY selected.
    private var cardSelection: CardSelection {
        switch selectedCards.count {
        case 0: return .none
        case 1: return .one
        case 2: return .two
        case 3: return .three
        default: return .none
        }
    }
    
    private enum CardSelection {
        case none, one, two, three
    }
    
    // MARK: -  Game Creation
    
    private mutating func createCards() {
        // Creating 81 cards in cards set.
        while cards.count < 81 {
            let card = Card(
                shape: Card.Shape.allCases.randomElement()!,
                shade: Card.Shade.allCases.randomElement()!,
                color: Card.Color.allCases.randomElement()!,
                number: Card.Number.allCases.randomElement()!
            )
            if !cards.contains(card) {
                cards.insert(card)
            }
        }
        //Take a card from cards to CardsOnBoard 12 times
        repeat {
            cardsOnBoard.append(cards.removeFirst())
        } while cardsOnBoard.count < 12
    }
  
    // MARK: - Choose Function (Public)
    
    mutating func choose(_ card: Card) {
        // Switch on how many cards are already selected before you tap on a card.
        // Selected cards are saved on the selectedCards array
        switch cardSelection {
            
        case .none:
            guard selectedCards.isEmpty else {
                selectedCards.removeAll()
                return
            }
            selectedCards.append(card)
            
        case .one:
            guard !selectedCards.contains(card) else {
                selectedCards.removeAll()
                scoreCounter -= 1
                return
            }
            selectedCards.append(card)
            
        case .two:
            guard !selectedCards.contains(card) else {
                selectedCards.remove(at: selectedCards.firstIndex(of: card)!)
                scoreCounter -= 1
                return
            }
            selectedCards.append(card)
            let card1 = selectedCards[0]
            let card2 = selectedCards[1]
            checkIfMatched(card1: card1, card2: card2, card3: card)
              
        case .three:
            guard !selectedCards.contains(card) else {
                
                // If you tap on one of the not matched cards, start new trial.
                if notMatchedCards.contains(card) {
                    selectedCards.removeAll()
                    notMatchedCards.removeAll()
                    selectedCards.append(card)
                    return
                    
                // If you tap on one of the matched card, Dont do anything
                } else { return }
            }
            
            // Replace the matched cards
            if !alreadyMatchedCards.isEmpty && cards.count != 0 {
                replaceMatchedCards()
            }
            
            // If still cards on cards array don't count the matching cards.
            // empty the already matched array
            if cards.count != 0 {
                alreadyMatchedCards.removeAll()
            } else {
                
                // If there are cards matched and Cards array is empty
                // We have to keep track on matched cards.
                // then Cards have to be removed from CardsOnBoard.
                // So the UI can be updated and cell being removed.
                removeMatchedCardWhenCardsArrayIsEmpty()
               
            }
            
            // Case Three If you hit a not selected Card.
            selectedCards.removeAll()
            notMatchedCards.removeAll()
            selectedCards.append(card)
        }
    }
    
    mutating private func removeMatchedCardWhenCardsArrayIsEmpty() {
        for card in alreadyMatchedCards {
            if let index = cardsOnBoard.firstIndex(of: card) {
                cardsOnBoard.remove(at: index)
            }
        }
        alreadyMatchedCards.removeAll()
    }
    
    
    // MARK: - Matching logic

    mutating func checkIfMatched(card1: Card, card2: Card, card3: Card) {
        if isMatched(card1: card1, card2: card2, card3: card3) {
            alreadyMatchedCards.append(card1)
            alreadyMatchedCards.append(card2)
            alreadyMatchedCards.append(card3)
            scoreCounter += 5
        } else {
            notMatchedCards.append(card1)
            notMatchedCards.append(card2)
            notMatchedCards.append(card3)
            scoreCounter -= 3
        }
    }
    
    func isMatched(card1: Card, card2: Card, card3: Card) -> Bool {
        // Make sure all the attributes of the card are even all same or all different at once to consider the cards are  matched.
        if (((card1.shape == card2.shape && card2.shape == card3.shape &&
              card1.shape == card3.shape) ||
            (card1.shape != card2.shape && card2.shape != card3.shape &&
             card1.shape != card3.shape)) &&
            
            ((card1.color == card2.color && card2.color == card3.color &&
              card1.color == card3.color) ||
            (card1.color != card2.color && card2.color != card3.color &&
             card1.color != card3.color)) &&
            
            ((card1.shade == card2.shade && card2.shade == card3.shade &&
              card1.shade == card3.shade) ||
            (card1.shade != card2.shade && card2.shade != card3.shade &&
             card1.shade != card3.shade)) &&
            
            ((card1.number == card2.number && card2.number == card3.number &&
              card1.number == card3.number) ||
             (card1.number != card2.number && card2.number != card3.number &&
              card1.number != card3.number))) {
            return true
            
        } else {
            return false
        }
    }
    // MARK: - Dealing Cards
    
    mutating func dealCards() {
        // Make sure still cards in Cards Array
        if cards.count != 0 {
            
            // If there is no matching. Means 3 cards will be added not replace old ones.
            if alreadyMatchedCards.isEmpty {
                for _ in 0..<3 { cardsOnBoard.append(cards.removeFirst()) }
            } else {
            // If there is matching replace matched cards. and empty matched card array.
                replaceMatchedCards()
                alreadyMatchedCards.removeAll()
            }
        }
    }
    
    mutating func replaceMatchedCards() {
        for card in cardsOnBoard {
            if alreadyMatchedCards.contains(card) {
                if let index = cardsOnBoard.firstIndex(of: card) {
                    cardsOnBoard[index] = cards.removeFirst()
                }
            }
        }
    }
    
    mutating func shuffleCards() {
        cardsOnBoard.shuffle()
    }
}
