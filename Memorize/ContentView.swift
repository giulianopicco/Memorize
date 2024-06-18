//
//  ContentView.swift
//  Memorize
//
//  Created by Max on 2024-06-16.
//

import SwiftUI

struct ContentView: View {
//    let emojis: [String] = ["😀", "🎃", "👻", "🕷️"] // Another way to define the array
    let emojis: Array<String> = ["😀", "🎃", "👻", "🕷️", "😈", "👺","😀", "🎃", "👻", "🕷️", "😈", "👺"]
    
    @State var cardCount: Int = 4
    
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]

    var body: some View {
        VStack{
            ScrollView {
                cards
            }
                Spacer()
                cardAjusters
        }
        
        .padding()
        
    }
    
    var cardAjusters: some View {
        HStack {
            removeButton
            Spacer()
            addButton
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self) { index in
                Card(isFaceUp: true, textContent: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(Color.orange)
    }
    
    func cardAjuster(by offset: Int, symbol: String, isEnable: Bool) -> some View {
        Button(action: {
            cardCount += offset
        },
        label: {
            Image(systemName: symbol)
        })
        .font(.largeTitle)
        .disabled(isEnable)
    }
    
    var addButton: some View {
        cardAjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill", isEnable: cardCount >= emojis.count)
    }
    
    var removeButton: some View {
        cardAjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill", isEnable: cardCount < 2)
    }
}

struct Card: View {
    @State var isFaceUp = false
    var textContent: String = ""
    let baseRectangle = RoundedRectangle(cornerRadius: 25.0)
    var body: some View {
        
            ZStack {
                Group {
                    baseRectangle
                        .foregroundColor(.white)
                    baseRectangle
                        .strokeBorder(lineWidth: 2)
                    Text(textContent).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                baseRectangle.fill().opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        
        
    }
}




#Preview {
    ContentView()
}
