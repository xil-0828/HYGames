//
//  WhereWinner.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/07.
//

import Foundation
func WhereWinner(OthelloBoard: [[Int]]) -> Int {
    var BlackCount = 0;
    var WhiteCount = 0;
    var Answer = 0;
    for i in 0...7 {
        for j in 0...7 {
            if(OthelloBoard[i][j] == 0) {
                BlackCount += 1;
            }else if(OthelloBoard[i][j] == 1) {
                WhiteCount += 1;
            }
        }
    }
    
    if(BlackCount > WhiteCount) {
        Answer = 0;
    }else {
        Answer = 1
    }
    return Answer
}
func BoardCount(OthelloBoard: [[Int]]) -> (black:Int, white: Int) {
    var BlackCount = 0;
    var WhiteCount = 0;
    for i in 0...7 {
        for j in 0...7 {
            if(OthelloBoard[i][j] == 0) {
                BlackCount += 1;
            }else if(OthelloBoard[i][j] == 1) {
                WhiteCount += 1;
            }
        }
    }
    
    
    return (BlackCount,WhiteCount)
}
