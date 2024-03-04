//
//  ContentView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                NavigationLink {
                    ReverseGame()
                }label: {
                    Text("二人で遊ぶ")
                    
                }
                
            }
        }
    }

    
}

#Preview {
    ContentView()
        
}
