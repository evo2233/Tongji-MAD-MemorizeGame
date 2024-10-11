//
//  View_EmojiMemoryGameView.swift
//  Memorize
//
//  Created by admin on 2024/10/11.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel = EmojiMemoryGame()   // without ObservableObject change can't be print
    
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0) {
            // 1st spacing is line 2nd is column
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body:some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
