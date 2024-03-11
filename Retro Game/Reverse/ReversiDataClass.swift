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
class ViewModel: ObservableObject {
    
    @Published var reversiData = ReversiData(OthelloOrder: 0, OthelloBoard: [0], isInRoom: false)
    
    private var db = Firestore.firestore()
    @Published var text = "";
    @Published var CollectionsName = "init";
    @Published var addCount = 0;
    func fetchData() {
        
        db.collection(CollectionsName).document("SF")
          .addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
              self.text = data["name"] as! String
              print(self.text)
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
                        print(doc.documentID)
                        
                    }
                }
                
            }
            else {
                // エラーを処理
            }
        }
    }
    
}

