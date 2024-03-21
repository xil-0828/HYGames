//
//  ContentView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/01.
//

import SwiftUI
import SwiftData
import FirebaseFirestore
import Neumorphic
struct ReversiMainView: View {
    @State var uidText = "ここにIDが表示"
    @State var testInputText = ""
    @State var fetchText = ""
    @State var text = "";
    @State var isNameChange = false;
    @State var isRoomView = false;
    @ObservedObject private var viewModel = ViewModel()
    @ObservedObject var UserName = NameChangeAppstorage()
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
           // 使用デバイスがiPhoneの場合
            
            NavigationStack {
                ZStack {
                    Color.Neumorphic.main.ignoresSafeArea()
                    
                    VStack {
                        //                Text(UserName.UserName)
                        //                    .font(.largeTitle)
                        
                        NavigationLink {
                            ReverseGame()
                        }label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: 200,height: 50)
                                    .foregroundColor(.blue)
                                HStack {
                                    Spacer().frame(width: 20)
                                    Text("Game Start")
                                        .font(.custom("SofiaPro", size: 15))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer()
                                    Text("→")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                
                            }
                            .frame(width: 200)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Text("HYReversi")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                        .font(.custom("SofiaPro", size: 40))
                                    Divider()
                                        .frame(width: 200)
                                }
                            }
                        }
                        
                    }
    //                Button {
    //                    isRoomView = true;
    //                }label: {
    //                    ZStack {
    //                        Rectangle()
    //                            .frame(width: 200,height: 50)
    //                            .foregroundColor(.blue)
    //                        Text("オンライン対戦")
    //                            .foregroundColor(.black)
    //                    }
    //                }
    //                .sheet(isPresented: $isRoomView) {
    //                    OnlineReversiRoom(isRoomView: $isRoomView)
    //                    .presentationDetents([.medium])
    //                }
                    
                }
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
           // 使用デバイスがiPadの場合
            Text("")
            NavigationStack {
                ZStack {
                    Color.Neumorphic.main.ignoresSafeArea()
                    
                    VStack {
                        //                Text(UserName.UserName)
                        //                    .font(.largeTitle)
                        
                        NavigationLink {
                            ReverseGame()
                        }label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: 200,height: 50)
                                    .foregroundColor(.blue)
                                HStack {
                                    Spacer().frame(width: 20)
                                    Text("Game Start")
                                        .font(.custom("SofiaPro", size: 15))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer()
                                    Text("→")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                
                            }
                            .frame(width: 200)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    Text("HYReversi")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                        .font(.custom("SofiaPro", size: 40))
                                    Divider()
                                        .frame(width: 200)
                                }
                            }
                        }
                        
                    }
    //                Button {
    //                    isRoomView = true;
    //                }label: {
    //                    ZStack {
    //                        Rectangle()
    //                            .frame(width: 200,height: 50)
    //                            .foregroundColor(.blue)
    //                        Text("オンライン対戦")
    //                            .foregroundColor(.black)
    //                    }
    //                }
    //                .sheet(isPresented: $isRoomView) {
    //                    OnlineReversiRoom(isRoomView: $isRoomView)
    //                    .presentationDetents([.medium])
    //                }
                }
            }
        }
        
        
        
        /*.onAppear {*/
//            if(UserName.UserName == "") {
//                isNameChange = true;
//            }
//           
//            
//        }
        
//        .sheet(isPresented: $isNameChange) {
//            NameChange(isNameChange: $isNameChange)
//            .presentationDetents([.medium])
//        }
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

