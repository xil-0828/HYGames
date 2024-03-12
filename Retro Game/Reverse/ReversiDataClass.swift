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
    var OthelloOrder: Int
    var OthelloBoard:[Int]
    var isInRoom: Bool
}
struct emptyRoomData: Hashable {
    var id: String = UUID().uuidString
    var isEnterRoom: Bool
    var UserName: String
}
class ViewModel: ObservableObject {
    
    @Published var reversiData = ReversiData(OthelloOrder: 0, OthelloBoard: [0], isInRoom: false)
    @Published var emptyroomdata = [emptyRoomData]()
    private var db = Firestore.firestore()
    
    @Published var CollectionsName = "init";
    @Published var addCount = 0;
    func fetchData() {
        
        db.collection("EmptyRoom").document("Ffff")
          .addSnapshotListener { documentSnapshot, error in
              print("333333333333")
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
              
              
          }

    }
    func AddData() {
        
        db.collection(CollectionsName).document("\(addCount)").setData(["OthelloOrder": reversiData.OthelloOrder,"OthelloBoard": reversiData.OthelloBoard,"isInRoom": reversiData.isInRoom])
    }
    func EmptyRoomData() {
        db.collection("EmptyRoom").addSnapshotListener() { snapshot, error in
            
            // エラーをチェック
            if error == nil {
                // エラーなし
                
                if let snapshot = snapshot {
                    
                    // すべてのドキュメントを取得してTodoを作成します
                    snapshot.documents.map { doc in
                        
                        self.emptyroomdata.append(emptyRoomData(isEnterRoom: (doc["isEnterRoom"] != nil), UserName: doc.documentID))
                    }
                }
                
            }
            else {
                // エラーを処理
            }
        }
    }
    
}

