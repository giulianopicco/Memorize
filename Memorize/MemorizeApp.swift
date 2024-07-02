//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Max on 2024-06-16.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(modelView: game)
        }
    }
}
