//
//  ReversiBattleDataClass.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/14.
//

import SwiftUI
import FirebaseFirestore
//泣く泣くグローバル変数
var RoomName = "";

class ReversiBattleModel: ObservableObject {
    private var db = Firestore.firestore()
    @Published var addCount = 0;
    @Published var reversiData = ReversiData(OthelloBoard: [[0]], TurnCount: 0)
    @Published var TurnPlace = [XY: [XY]]()
    @Published var isBoardData = false;
    @Published var Winner = 0;
    @Published var GameFinish = false
    func AddData() {
        var arr = [Int]();
        
        for i in 0..<reversiData.OthelloBoard.count {
            
            for j in 0..<reversiData.OthelloBoard[i].count {
                arr.append(reversiData.OthelloBoard[i][j])
            }
            
        }
        print("arr:\(arr)")
        db.collection(RoomName).document("\(addCount)").setData(["OthelloBoard": arr,"addCount": addCount])
    }
    func DeleteData() {
        Firestore.firestore().collection(RoomName).getDocuments { (snapshot, error) in
            if let error = error{
                print("エラー",error)
                return
            }
            
            for document in snapshot!.documents{
                document.reference.delete()
            }
            
        }
        Firestore.firestore().collection("FullyRoom").document(RoomName).delete()
    }
    init() {
        
        
        db.collection(RoomName).addSnapshotListener() { snapshot, error in
            // エラーをチェック
            if error == nil {
                // エラーなし
                
                if let snapshot = snapshot {
                    
                    // すべてのドキュメントを取得してTodoを作成します
                    snapshot.documents.map { doc in
                        if(String(self.addCount) == doc.documentID) {
                            var count = 0;
                            var arr = [[Int]]();
                            let X = doc["OthelloBoard"] as! [Int]
                            for _ in 0..<8 {
                                var a = [Int]();
                                for _ in 0..<8 {
                                    a.append(X[count])
                                    count += 1;
                                }
                                arr.append(a)
                            }
                            print(arr)
                            self.reversiData = ReversiData(OthelloBoard: arr, TurnCount: doc["addCount"]as! Int)
                            self.isBoardData = true;
                        }
                        
                    }
                }
                
            }
            else {
                // エラーを処理
            }
            
            if(self.isBoardData) {
                self.TurnPlace = FindOthelloPiece(OthelloBoard: self.reversiData.OthelloBoard, OthelloOrder: (self.addCount) % 2)
                self.addCount += 1
                if(self.TurnPlace.count == 0) {
                    self.TurnPlace = FindOthelloPiece(OthelloBoard: self.reversiData.OthelloBoard, OthelloOrder: (self.addCount) % 2)
                    self.addCount += 1
                    if(self.TurnPlace.count == 0) {
                        self.Winner = WhereWinner(OthelloBoard: self.reversiData.OthelloBoard)
                        self.GameFinish = true
                    }
                }
                self.isBoardData = false
            }
            
        }
        
    }
}
