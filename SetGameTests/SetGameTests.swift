//
//  SetGameTests.swift
//  SetGameTests
//
//  Created by Yousef Zuriqi on 04/12/2021.
//

import XCTest
@testable import SetGameGraphical

class SetGameTests: XCTestCase {
    var sut: SetModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SetModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsMatchingMethodWorks() {
        // given
        let card1 = Card(shape: .oval, shade: .open, color: .purple, number: .one)
        let card2 = Card(shape: .diamond, shade: .solid, color: .orange, number: .two)
        let card3 = Card(shape: .squiggle, shade: .striped, color: .green, number: .three)
        
        let card4 = Card(shape: .oval, shade: .striped, color: .green, number: .three)
        let card5 = Card(shape: .oval, shade: .solid, color: .purple, number: .two)
        let card6 = Card(shape: .diamond, shade: .open, color: .green, number: .one)
        
        let card7 = Card(shape: .diamond, shade: .open, color: .green, number: .one)
        let card8 = Card(shape: .oval, shade: .open, color: .orange, number: .two)
        let card9 = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        
        let card10 = Card(shape: .diamond, shade: .open, color: .green, number: .one)
        let card11 = Card(shape: .oval, shade: .open, color: .orange, number: .two)
        let card12 = Card(shape: .squiggle, shade: .open, color: .purple, number: .two)
    
        // when
        let result = sut.isMatched(card1: card1, card2: card2, card3: card3)
        let result2 = sut.isMatched(card1: card4, card2: card5, card3: card6)
        let result3 = sut.isMatched(card1: card7, card2: card8, card3: card9)
        let result4 = sut.isMatched(card1: card10, card2: card11, card3: card12)

        // then
        XCTAssertEqual(result, true, "is Matching is not working properly")
        XCTAssertEqual(result2, false, "is Matching is not working properly")
        XCTAssertEqual(result3, true, "is Matching is not working properly")
        XCTAssertEqual(result4, false, "is Matching is not working properly")
    }
    
    func testNumberOfCardsWhenInitiateTheGame() {
        // given
        // Start the game init()
        
        // then
        XCTAssertEqual(sut.cards.count, (81 - 12), "Cards number when creating is not equalt to 81")
        XCTAssertEqual(sut.cardsOnBoard.count, 12, "Cards on Board are not 12 cards when game start")
    }
    
    func testChoosingfirstCards() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        
        // when
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 1, "Choosing first card failed")
    }
    
    func testChoosingSecondCard() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        
        // when
        sut.choose(card1)
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 2, "Choosing Second card is not working")
    }
    
    func testChoosingSecondCardWhenTappingSelectedCard() {
        // given
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        
        // when
        sut.choose(card1)
        sut.choose(card1)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 0, "Choosing Second card while tapping the selected card is not working")
    }
    
    func testChoosingThirdCardNotMatching() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .striped, color: .purple, number: .two)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 3, "Choosing third card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 3)
        
    }
    
    func testChoosingThirdCardMatching() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .purple, number: .one)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 3, "Choosing third card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing third Card matching is filling the notMatchdCards array")
        XCTAssertEqual(sut.alreadyMatchedCards.count, 3, "Choosing third Card matching not appending to alreadyMatchCards array correctly")
    }
    
    func testChoosingThirdCardMatchingSecondTrial() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .solid, color: .purple, number: .three)
        let card1 = Card(shape: .oval, shade: .solid, color: .orange, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .green, number: .one)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 3, "Choosing third card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing third Card matching is filling the notMatchdCards array")
        XCTAssertEqual(sut.alreadyMatchedCards.count, 3, "Choosing third Card matching not appending to alreadyMatchCards array correctly")
    }
    
    
    func testChoosingThirdCardOnTappingSelectedCard() {
        // given
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .purple, number: .one)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(card2)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 1, "Choosing third card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing third Card matching is filling the notMatchdCards array")
        XCTAssertEqual(sut.alreadyMatchedCards.count, 0, "Choosing third Card matching not appending to alreadyMatchCards array correctly")
    }
    
    func testChoosingForthCard() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .purple, number: .one)
        let card3 = Card(shape: .diamond, shade: .solid, color: .green, number: .one)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(card3)
        sut.choose(chosenCard)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 1, "Choosing Forth card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing Forth Card matching is filling the notMatchdCards array")
        XCTAssertEqual(sut.alreadyMatchedCards.count, 0, "Choosing Forth Card is filling the already matched card array in wrong way")
    }
    
    func testChoosingForthCardByTappingSelectedCardWhileThereIsMisMatch() {
        // given
        let card1 = Card(shape: .oval, shade: .striped, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .purple, number: .one)
        let card3 = Card(shape: .diamond, shade: .solid, color: .green, number: .one)
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(card3)
        sut.choose(card3)
        
        // then
        XCTAssertEqual(sut.selectedCards.count, 1, "Choosing Forth card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing Forth Card matching is filling the notMatchdCards array")
//        XCTAssertEqual(sut.alreadyMatchedCards.count, 0, "Choosing Forth Card is filling the already matched card array in wrong way")
    }
    
    func testChoosingForthCardWhileThereIsMatchingAndCardsCountEqualZero() {
        // given
        let chosenCard = Card(shape: .squiggle, shade: .open, color: .purple, number: .three)
        let card1 = sut.cardsOnBoard.randomElement()!
        let card2 = sut.cardsOnBoard.randomElement()!
        let card3 = sut.cardsOnBoard.randomElement()!
        sut.cards.removeAll()

        // When
        sut.selectedCards.append(card1)
        sut.selectedCards.append(card1)
        sut.selectedCards.append(card1)

        sut.alreadyMatchedCards.append(card1)
        sut.alreadyMatchedCards.append(card2)
        sut.alreadyMatchedCards.append(card3)

        sut.choose(chosenCard)
        
        // then
        print("Count of Already matched cards: \(sut.alreadyMatchedCards.count)")
        print("Count of cards array: \(sut.cards.count)")

        XCTAssertEqual(sut.selectedCards.count, 1, "Choosing Forth card is not working")
        XCTAssertEqual(sut.notMatchedCards.count, 0, "Choosing Forth Card matching is filling the notMatchdCards array")
        XCTAssertEqual(sut.alreadyMatchedCards.count, 0, "Choosing Forth Card is filling the already matched card array in wrong way")
        XCTAssertEqual(sut.cardsOnBoard.count, 9, "test Choosing Forth Card While There Is Matching And Cards Count Equal Zero: Cards are not removed from cardOnBoard after matching ")

    }
    
    func testDealCardsWhenThereIsNoMatchedCardAlready() {
        // given
        // when
        sut.dealCards()
        
        // then
        XCTAssertEqual(sut.cardsOnBoard.count, 15, "Dealing card in adding cards")
    }
    
    func testDealCardsWhenthereisAmatching() {
        // given
        let card1 = Card(shape: .oval, shade: .solid, color: .purple, number: .two)
        let card2 = Card(shape: .diamond, shade: .solid, color: .purple, number: .one)
        let card3 = Card(shape: .squiggle, shade: .solid, color: .purple, number: .three)
        
        
        // when
        sut.choose(card1)
        sut.choose(card2)
        sut.choose(card3)
        sut.dealCards()
       
        
        // then
        XCTAssertEqual(sut.cardsOnBoard.count, 12, "Dealing card when cardsOnBoard are full is not working correct")
    }
    
    func testDealCaradsWhencardsIsEmpty() {

        // when
        sut.cards.removeAll()
        sut.dealCards()
        
        // then
        XCTAssertEqual(sut.cardsOnBoard.count, 12, "error in DealCards when cards set is empty")
    }
    
    func testNewGame() {
        //when
        sut.newGame()
        
        //then
        XCTAssertEqual(sut.cards.count, 69, "New Game problem")
        XCTAssertEqual(sut.cardsOnBoard.count, 12, "testNewGame: cardOnBoardCount is not correct")
    }
    
    func testCardsAreBeingShuffled() {
        // given
        let card1 = sut.cardsOnBoard.randomElement()!
        let index = sut.cardsOnBoard.firstIndex(of: card1)!
        
        // when
        sut.shuffleCards()
        
        // then
        XCTAssertFalse(sut.cardsOnBoard.firstIndex(of: card1 ) == index)
    }
    
//    func testCheckIfMatchedPerfomance() {
//        // given
//        let card1 = Card(shape: .circle, shade: .empty, color: .green, number: .one)
//        let card2 = Card(shape: .square, shade: .fill, color: .green, number: .two)
//        let card3 = Card(shape: .traiangle, shade: .shaded, color: .green, number: .three)
//
//        // then
//      measure(
//        metrics: [
//          XCTClockMetric(),
//          XCTCPUMetric(),
//          XCTStorageMetric(),
//          XCTMemoryMetric()
//        ]
//      ) {
//          sut.checkIfMatched(card1: card1, card2: card2, card3: card3)
//      }
//    }
}
