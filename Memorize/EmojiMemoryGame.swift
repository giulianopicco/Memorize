//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Max on 2024-06-18.
//
// This is the View Model
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
//    private static let emojis = ["😀", "🎃", "👻", "🕷️", "😈", "👺","😀", "🎃", "👻", "🕷️", "😈", "👺"]
    
    @Published private var model: MemoryGame<String>
    var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.noOfPairs!) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func reset() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
