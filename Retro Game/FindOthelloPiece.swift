//
//  File.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/04.
//

import Foundation
import SwiftUI
func FindOthelloPiece(OthelloBoard: [[Int]],OthelloOrder: Int) -> [XY: [XY]] {
    var OthelloPlace = [XY:[XY]]()
    let z = (OthelloOrder + 1) % 2
    for i in 0...7 {
        for j in 0...7 {
            if(OthelloBoard[i][j] == -1) {
                
                //何個ひっくり返せるマスがあるか配列で持っておく
                var A = [XY]()
                var count = 0;
                //上方向に探索
                var a = i;
                while(true) {
                    a -= 1
                    if(a < 0) {
                        break
                    }
                    if(OthelloBoard[a][j] == -1 || OthelloBoard[a][j] == OthelloOrder) {
                        break;
                    }
                    if(z == OthelloBoard[a][j]) {
                        A.append(XY(x: a,y:j))
                        count += 1
                    }
                }
                // 下に全探索
                var b = i;
                while(true) {
                    b += 1
                    if(b > 7 ) {
                        break
                    }
                    if(OthelloBoard[b][j] == -1 || OthelloBoard[b][j] == OthelloOrder) {
                        break;
                    }
                    if(z == OthelloBoard[b][j]) {
                        A.append(XY(x: b,y:j))
                        count += 1
                    }
                }
                // 左に全探索
                var c = j;
                while(true) {
                    c -= 1
                    if(c < 0) {
                        break
                    }
                    if(OthelloBoard[i][c] == -1 || OthelloBoard[i][c] == OthelloOrder) {
                        break;
                    }
                    if(z == OthelloBoard[i][c]) {
                        A.append(XY(x: i,y:c))
                        count += 1
                    }
                }
                // 右に全探索
                var d = j;
                while(true) {
                    d += 1
                    if(d > 7) {
                        break
                    }
                    if(OthelloBoard[i][d] == -1 || OthelloBoard[i][d] == OthelloOrder) {
                        break;
                    }
                    if(z == OthelloBoard[i][d]) {
                        A.append(XY(x: i,y:d))
                        count += 1
                    }
                }
               
                if(count >= 1) {
                    OthelloPlace[XY(x: i,y:j)] = A
                }
                
            }
            
        }
    }
    return OthelloPlace
}
