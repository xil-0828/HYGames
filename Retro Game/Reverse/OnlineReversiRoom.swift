//
//  OnlineReversiRoom.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/11.
//

import SwiftUI
import FirebaseFirestore
struct OnlineReversiRoom: View {
    @ObservedObject private var viewModel = ViewModel()
    
    @Binding var isRoomView: Bool
    @State var db = Firestore.firestore()
    @State var isRoomButton = false
    @ObservedObject var UserName = NameChangeAppstorage()
    @State var isShowingSheet = false;
    @State var RoomName = "";
    var body: some View {
        ZStack {
            VStack {
                
                Text("オンライン対戦")
                    .font(.largeTitle)
                
                Button {
                    db.collection("EmptyRoom").document(UserName.UserName).setData(["isEnterRoom": false])
                    RoomName = UserName.UserName
                }label: {
                    Text("部屋を作る")
                }
                .fullScreenCover(isPresented: $viewModel.isFullyRoom) {
                    OnlineReversiGame()
                }
                Text("部屋に入る")
                HStack {
                    
                    ForEach(viewModel.emptyroomdata, id: \.self) { data in
                        Button {
                            db.collection("EmptyRoom").document(data.UserName).delete()
                            db.collection("FullyRoom").document(data.UserName).setData(["BlackUser": data.UserName,"WhiteUser":UserName.UserName])
                            RoomName = data.UserName
                            viewModel.UserName = data.UserName
                            viewModel.AddData()
                            isShowingSheet = true;
                        }label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .frame(width: 50,height: 50)
                                Text(data.UserName)
                                    .foregroundColor(.black)
                                
                            }
                        }
                        .fullScreenCover(isPresented: $isShowingSheet) {
                            OnlineReversiGame()
                        }
                        
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.EmptyRoomData()
            viewModel.FullyRoomData()
            print(viewModel.emptyroomdata)
            viewModel.UserName = UserName.UserName
        }
    }
}

