//
//  ViewModel_EmojiMemoryGame.swift
//  Memorize
//
//  Created by admin on 2024/10/11.
//

import SwiftUI
/* we change this func into a closure
func createCardContent(forPairAtIndex index: Int) -> String {
    return ["😆","🥹","😅","🥲","😇","😉","🥰","😋"][index] // like array[index] return a emoji
}*/

class EmojiMemoryGame: ObservableObject {   // without ObservableObject change can't be print
    private static let emojis = ["😆","🥹","😅","🥲","😇","😉","🥰","😋"]
    // we can use EmojiMemoryGame.emojis anywhere without declare emojis global
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 8){pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "error: out of bounds"   // safety
            }
        }
    }
    // cardContentFactory: {(forPairAtIndex index: Int) -> String in    --> external name is not allowed in closure
    // cardContentFactory: {(index: Int) -> String in    --> because of type inference we can abondon Int & String
    // numberOfPairsOfCards: 4, cardContentFactory: {index in...})    --> we konw this func have only 2 parameters only mark 1 is OK
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send() // without it change can't be print
    }
    
    func choose(_ card: MemoryGame<String>.Card) {  // _ means parameter has no external name
        model.choose(card)  // due to _ in Model no (card: card) here
    }
}
