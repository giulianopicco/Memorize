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
    
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
            
            Text(modelView.theme.name)
                .font(.headline)
                .foregroundColor(modelView.theme.color)
            Text("Score: \(modelView.score)")
            ScrollView {
                cards
                    .animation(.default, value: modelView.cards)
            }
            Button("Shuffle") {
                modelView.shuffle()
            }
            Button("New Game") {
                modelView.reset()
            }
        }
        
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(modelView.cards) { card in
                Card(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        modelView.choose(card)
                    }
                    .animation(.linear, value: modelView.cards)
            }
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
