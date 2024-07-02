//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Max on 2024-06-18.
//
//  Tis is the Model
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            cards[chosenIndex].hasBeenSeen += 1
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else if cards[chosenIndex].hasBeenSeen > 1 {
                        score -= 1
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        print(cards)
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var description: String {
            return "Card - \(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched") \(hasBeenSeen > 0 ? "seen" : "unseen")"
        }
        
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = 0
        let content: CardContent
        var id = UUID()

    }
    
    
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
