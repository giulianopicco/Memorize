//
//  ContentView.swift
//  Memorize
//
//  Created by Max on 2024-06-16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Card(isFaceUp: true, textContent: "😀")
            Card()
            Card()
            Card()
        }
        .foregroundColor(Color.orange)
        .padding()
        
    }
}

struct Card: View {
    @State var isFaceUp = false
    var textContent: String = ""
    let baseRectangle = RoundedRectangle(cornerRadius: 25.0)
    var body: some View {
        
            ZStack {
                if isFaceUp {
                    baseRectangle
                        .foregroundColor(.white)
                    baseRectangle
                        .strokeBorder(lineWidth: 2)
                    Text(textContent).font(.largeTitle)
                } else {
                    baseRectangle
                        .foregroundColor(.orange)
                }
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        
        
    }
}




#Preview {
    ContentView()
}
