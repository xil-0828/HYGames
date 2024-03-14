//
//  OnlineReversiRoom.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/11.
//

import SwiftUI
import FirebaseFirestore
struct OnlineReversiRoom: View {
    @StateObject private var viewModel = ViewModel()
    @Binding var isRoomView: Bool
    @State var db = Firestore.firestore()
    @State var isRoomButton = false
    @ObservedObject var UserName = NameChangeAppstorage()
    @State var isShowingSheet = false;
    @State var OthelloOrder = 0
    @State var isFullyRoom = false
    var body: some View {
        ZStack {
            
            VStack {
                if(viewModel.isFullyRoom) {
                    Text("反応したよー")
                }
                Text("オンライン対戦")
                    .font(.largeTitle)
                Button {
                    viewModel.AddData()
                    RoomName = UserName.UserName
                    let arr = [-1, -1, -1, -1, -1, -1, -1, -1,
                               -1, -1, -1, -1, -1, -1, -1, -1,
                               -1, -1, -1, -1, -1, -1, -1, -1,
                               -1, -1, -1,  1,  0, -1, -1, -1,
                               -1, -1, -1,  0,  1, -1, -1, -1,
                               -1, -1, -1, -1, -1, -1, -1, -1,
                               -1, -1, -1, -1, -1, -1, -1, -1,
                               -1, -1, -1, -1, -1, -1, -1, -1];
                    db.collection(RoomName).document("\(0)").setData(["OthelloBoard": arr,"addCount": 0])
                }label: {
                    Text("部屋を作る")
                }
                .fullScreenCover(isPresented: $viewModel.isFullyRoom) {
                    
                    OnlineReversiGame(OthelloOrder: $OthelloOrder)
                        
                }
                Text("部屋に入る")
                HStack {
                    
                    ForEach(viewModel.emptyroomdata, id: \.self) { data in
                        Button {
                            if(data.UserName != UserName.UserName) {
                                db.collection("EmptyRoom").document(data.UserName).delete()
                                
                                db.collection("FullyRoom").document(data.UserName).setData(["BlackUser": data.UserName,"WhiteUser":UserName.UserName])
                                RoomName = data.UserName
                                OthelloOrder = 1
                                isShowingSheet = true;
                            }
                            
                        }label: {
                            if(data.UserName == UserName.UserName) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .frame(width: 50,height: 50)
                                    Text(data.UserName)
                                        .foregroundColor(.white)
                                    
                                }
                            }else {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.blue)
                                        .frame(width: 50,height: 50)
                                    Text(data.UserName)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            
                        }
                        .fullScreenCover(isPresented: $isShowingSheet) {
                            OnlineReversiGame(OthelloOrder: $OthelloOrder)
                        }
                        
                        
                    }
                }
            }
        }
        .onAppear {
            
            
            viewModel.UserName = UserName.UserName
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if(viewModel.isFullyRoom) {
                    isFullyRoom = viewModel.isFullyRoom
                    
                }
            }
        }
    }
}

