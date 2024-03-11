//
//  ContentView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/01.
//

import SwiftUI
import SwiftData
import FirebaseFirestore

struct ContentView: View {
    @State var uidText = "ここにIDが表示"
    @State var testInputText = ""
    @State var fetchText = ""
    @State var text = "";
    @State var isNameChange = false;
    @State var isRoomView = false;
    @ObservedObject private var viewModel = ViewModel()
    @AppStorage("UserName") var UserName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text(UserName)
                    .font(.largeTitle)
                NavigationLink {
                    ReverseGame()
                }label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 200,height: 50)
                            .foregroundColor(.blue)
                        Text("一人対戦")
                            .foregroundColor(.black)
                    }
                }
                Button {
                    isRoomView = true;
                }label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 200,height: 50)
                            .foregroundColor(.blue)
                        Text("オンライン対戦")
                            .foregroundColor(.black)
                    }
                }
                .sheet(isPresented: $isRoomView) {
                    OnlineReversiRoom(isRoomView: $isRoomView)
                    .presentationDetents([.medium])
                }
            }
        }.onAppear {
            if(UserName == "") {
                isNameChange = true;
            }
           
            
        }
        .sheet(isPresented: $isNameChange) {
            NameChange(isNameChange: $isNameChange)
            .presentationDetents([.medium])
        }
//        VStack {
//            //ID表示
//            VStack {
//              Text(text)
//            }
//            //Save
//            VStack {
//
//                Button {
//                    Firestore.firestore().collection("users").getDocuments { snapshot, error in
//
//                        // エラーをチェック
//                        if error == nil {
//                            // エラーなし
//
//                            if let snapshot = snapshot {
//
//                                var _: [()] = snapshot.documents.map { doc in
//
//                                                // 返されたドキュメントごとにTodoアイテムを作成します
//
//                                    text = doc.documentID
//                                            }
//                            }
//
//                        }
//                        else {
//                            // エラーを処理
//                        }
//                        Firestore.firestore().collection("users").document(uidText).setData(["testText": testInputText])
//
//
//                }
//                } label: {
//                    Text("オンライン対戦")
//                }
//            }
//        }

    }

    
}

#Preview {
    ContentView()
        
}
