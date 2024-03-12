//
//  ReversiDataClass.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/11.
//

import Foundation
import FirebaseFirestore
struct ReversiData: Identifiable {
    var id: String = UUID().uuidString
    var OthelloBoard:[Int]
    var TurnCount: Int
}
struct emptyRoomData: Hashable {
    var id: String = UUID().uuidString
    var isEnterRoom: Bool
    var UserName: String
}
class ViewModel: ObservableObject {
    
    @Published var reversiData = ReversiData(OthelloBoard: [0], TurnCount: 0)
    @Published var emptyroomdata = [emptyRoomData]()
    private var db = Firestore.firestore()
    
    @Published var CollectionsName = "init";
    @Published var addCount = 0;
    @Published var isFullyRoom = false
    @Published var UserName = ""
    func AddData() {
        db.collection(UserName).document("\(addCount)").setData(["OthelloBoard": reversiData.OthelloBoard,"isInRoom": addCount])
    }
    func EmptyRoomData() {
        emptyroomdata.removeAll()
        db.collection("EmptyRoom").addSnapshotListener() { snapshot, error in
            
            // エラーをチェック
            if error == nil {
                // エラーなし
                
                if let snapshot = snapshot {
                    
                    // すべてのドキュメントを取得してTodoを作成します
                    snapshot.documents.map { doc in
                        
                        if(doc["isEnterRoom"] as! Bool == false) {
                            self.emptyroomdata.append(emptyRoomData(isEnterRoom: (doc["isEnterRoom"] != nil), UserName: doc.documentID))
                            
                        }
                        
                    }
                }
                
            }
            else {
                // エラーを処理
            }
        }
       
        
    }
    func FullyRoomData() {
        db.collection("FullyRoom").addSnapshotListener() { snapshot, error in
            
            // エラーをチェック
            if error == nil {
                // エラーなし
                
                if let snapshot = snapshot {
                    
                    // すべてのドキュメントを取得してTodoを作成します
                    snapshot.documents.map { doc in
                        
                        if(doc.documentID == self.UserName) {
                            self.isFullyRoom = true;
                        }
                    }
                }
                
            }
            else {
                // エラーを処理
            }
        }
    }
    
}

