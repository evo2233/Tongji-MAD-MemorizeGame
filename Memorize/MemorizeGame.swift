//
//  Model_MemorizeGame.swift
//  Memorize
//
//  Created by admin on 2024/10/11.
//

import Foundation

struct MemoryGame<CardContentType> {
    private(set) var cards: Array<Card> // read only
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContentType) {    // 2nd is a func receive Int & return CardContentType
        cards = []  // empty array
        // add pairs of cards(x2)
        for pairIndex in 0..<max(2, numberOfPairsOfCards) { // safety
            let content: CardContentType = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {   // mutating means copy on write
        cards.shuffle()
    }
    
    func choose(_ card: Card) {  // _ means parameter has no external name
        
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContentType
    }
}
