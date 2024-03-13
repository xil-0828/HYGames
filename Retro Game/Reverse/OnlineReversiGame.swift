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
    @EnvironmentObject var RoomName: RoomNameClass
    @ObservedObject var reversiBattleModel = ReversiBattleModel()
    
    @State var isAppear = false;
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<8) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { j in
                            Button {
                                //オセロのコマをひっくり返す
                                if(reversiBattleModel.TurnPlace.keys.contains(XY(x: i, y: j))) {
                                    //何色にひっくり返すか
                                    let x = (reversiBattleModel.addCount - 1) % 2
                                    let turnplace = reversiBattleModel.TurnPlace[XY(x: i, y: j)]!
                                    reversiBattleModel.reversiData.OthelloBoard[i][j] = x
                                    for z in turnplace {
                                        reversiBattleModel.reversiData.OthelloBoard[z.x][z.y] = x
                                    }
                                }
                                reversiBattleModel.AddData()
                                
                            }label: {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(width: (deviceWidth - 20) / 8, height: (deviceWidth - 20) / 8)
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
        .onAppear {
            
            
            
        }
       
        
    }
}

