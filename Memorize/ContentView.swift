//
//  ContentView.swift
//  Memorize
//
//  Created by Max on 2024-06-16.
//

import SwiftUI

struct ContentView: View {
//    let emojis: [String] = ["😀", "🎃", "👻", "🕷️"] // Another way to define the array
    let emojis = [
        "halloween":["😀", "🎃", "👻", "🕷️", "😈", "👺","😀", "🎃", "👻", "🕷️", "😈", "👺"],
        "vehicles":["🚗", "🚀", "🚁", "⛴️", "🛩️", "🚂"]
    ]
    
    @State var theme: String = "halloween"
    
    
    @State var cardCount: Int = 4
    
    let rows = [GridItem(.fixed(30)), GridItem(.fixed(30))]

    var body: some View {
        VStack{
            Text("Memorize")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            ScrollView {
                cards
            }
                Spacer()
                themeChooser
        }
        
        .padding()
        
    }
    
    var themeChooser: some View {
        HStack {
            ThemeVehicles
            ThemeHalloween
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self) { index in
                Card(isFaceUp: false, textContent: emojis[theme]![index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(Color.red)
    }
    
    func themeChoose(_theme: String, symbol: String) -> some View {
        Button(action: {
            theme = _theme
        },
        label: {
            Image(systemName: symbol)
        })
        .font(.largeTitle)
        
    }
    
    var ThemeVehicles: some View {
        themeChoose(_theme: "vehicles", symbol: "car.side")
    }
    
    var ThemeHalloween: some View {
        themeChoose(_theme: "halloween", symbol: "ladybug")
    }

}

struct Card: View {
    @State var isFaceUp = true
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
