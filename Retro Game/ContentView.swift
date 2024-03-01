//
//  ContentView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        ZStack {
            Text("だおう")
        }
        
    }

    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
