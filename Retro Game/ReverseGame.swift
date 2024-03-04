//
//  SwiftUIView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/03.
//

import SwiftUI

struct XY: Hashable {
    var x: Int
    var y: Int

    init(x: Int = 1, y: Int = 1) {
        self.x = x
        self.y = y
    }
}


struct ReverseGame: View {
    let deviceWidth = UIScreen.main.bounds.width
    @State var OthelloBoard =
        [[-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1,  1,  0, -1, -1, -1],
         [-1, -1, -1,  0,  1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1]];
    //オセロの順番
    @State var OthelloOrder = 0
    @State var OthelloPlace = [XY: [XY]]()
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<8) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { j in
                            Button {
                                print(i,j)
                                if(OthelloPlace.keys.contains(XY(x: i, y: j))) {
                                    let ar = OthelloPlace[XY(x: i, y: j)]!
                                    for z in ar {
                                        OthelloBoard[i][j] = (OthelloOrder + 1) % 2
                                        OthelloBoard[z.x][z.y] = (OthelloOrder + 1) % 2
                                    }
                                    OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                    OthelloOrder = (OthelloOrder + 1) % 2;
                                }
                                
                            }label: {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(width: (deviceWidth - 20) / 8, height: (deviceWidth - 20) / 8)
                                    if(OthelloBoard[i][j] == 1) {
                                        Text("◯")
                                            .foregroundColor(Color.black)
                                    }else if(OthelloBoard[i][j] == 0 ) {
                                        Text("●")
                                            .foregroundColor(Color.black)
                                    }else if(OthelloPlace.keys.contains(XY(x: i, y: j))) {
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
            OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
            OthelloOrder += 1;
        }
    }
    //次のコマが置けるところを探す関数
    
}

#Preview {
    ReverseGame()
}
