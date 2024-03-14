//
//  OnlineReversiGame.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/13.
//

import SwiftUI
import FirebaseFirestore
struct OnlineReversiGame: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    @Binding var OthelloOrder: Int
    @ObservedObject var reversiBattleModel = ReversiBattleModel()
    @State var isAppear = false;
    
    var body: some View {
        let x = (reversiBattleModel.addCount - 1) % 2
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<8) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { j in
                            Button {
                                //オセロのコマをひっくり返す
                                
                                
                                if(reversiBattleModel.TurnPlace.keys.contains(XY(x: i, y: j)) && x == OthelloOrder) {
                                    //何色にひっくり返すか
                                    
                                    let turnplace = reversiBattleModel.TurnPlace[XY(x: i, y: j)]!
                                    reversiBattleModel.reversiData.OthelloBoard[i][j] = x
                                    for z in turnplace {
                                        reversiBattleModel.reversiData.OthelloBoard[z.x][z.y] = x
                                    }
                                    reversiBattleModel.AddData()
                                    
                                }
                                
                                
                            }label: {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(width: (deviceWidth - 20) / 8, height: (deviceWidth - 20) / 8)
                                    if(reversiBattleModel.reversiData.OthelloBoard.count > 7) {
                                        if(reversiBattleModel.reversiData.OthelloBoard[i][j] == 0) {
                                            Text("●")
                                        }else if(reversiBattleModel.reversiData.OthelloBoard[i][j] == 1) {
                                            Text("◯")
                                        }else if(reversiBattleModel.TurnPlace.keys.contains(XY(x: i, y: j))) {
                                            Text("x")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
            }
            if(OthelloOrder == x) {
                Text("あなたのターンです")
                    .position(x:80,y:((deviceHeight / 2) + ((deviceWidth - 20) / 2)) + 10)
            }else {
                Text("相手のターンです")
                    .position(x:80,y:((deviceHeight / 2) + ((deviceWidth - 20) / 2)) + 10)
                    
            }
        }
        .onAppear {
            
            
            
        }
       
        
    }
}

