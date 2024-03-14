//
//  File.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/04.
//

import Foundation
import SwiftUI
func FindOthelloPiece(OthelloBoard: [[Int]],OthelloOrder: Int) -> [XY: [XY]] {
    let dx = 
    [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1],
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
    ]
    var OthelloPlace = [XY:[XY]]()
    let z = (OthelloOrder + 1) % 2
    for i in 0...7 {
        for j in 0...7 {
            if(OthelloBoard[i][j] == -1) {
                var TurnPlace = [XY]()
                for l in 0...7 {
                    var x = i;
                    var y = j;
                    var A = [XY]()
                    while(true) {
                        x += dx[l][0];
                        y += dx[l][1];
                        if(x < 0 || y < 0 || x > 7 || y > 7) {
                            break;
                        }
                        if(OthelloBoard[x][y] == -1 || OthelloBoard[x][y] == OthelloOrder) {
                            if(A.count >= 1 && OthelloBoard[x][y] == OthelloOrder) {
                                TurnPlace += A
                            }
                            break;
                        }
                        if(OthelloBoard[x][y] == z) {
                            A.append(XY(x: x,y: y))
                        }
                    }
                }
                
                if(TurnPlace.count >= 1) {
                    print(i,j,TurnPlace)
                    OthelloPlace[XY(x: i,y: j)] = TurnPlace
                }
                
            }
            
        }
    }
    return OthelloPlace
}
