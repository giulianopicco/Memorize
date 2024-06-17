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
    var isFaceUp: Bool = false
    var textContent: String = ""
    var body: some View {
        if isFaceUp {
            ZStack(content: {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: 2)
                Text(textContent).font(.largeTitle)
                
            })
        } else {
            ZStack(content: {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.orange)
                
            })
        }
        
    }
}




#Preview {
    ContentView()
}
