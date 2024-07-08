//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Max on 2024-06-16.
//
// This is the View
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var modelView: EmojiMemoryGame
    
    private let cardAspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack{
            cards
                .animation(.default, value: modelView.cards)
            Button("Shuffle") {
                modelView.shuffle()
            }
            Button("New Game") {
                modelView.reset()
            }
        }
        .padding()
        
    }
    
    @ViewBuilder
    private var cards: some View {
        AspectVGrid(modelView.cards, aspectRatio: cardAspectRatio) { card in
            Card(card)
                .padding(4)
                .onTapGesture {
                    modelView.choose(card)
                }
                .animation(.linear, value: modelView.cards)
        }
        .foregroundColor(modelView.theme.color)
    }
}



struct Card: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        
        ZStack {
            let baseRectangle = RoundedRectangle(cornerRadius: 25.0)
            Group {
                baseRectangle
                    .foregroundColor(.white)
                baseRectangle
                    .strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            baseRectangle.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
}




#Preview {
    EmojiMemoryGameView(modelView: EmojiMemoryGame())
}
