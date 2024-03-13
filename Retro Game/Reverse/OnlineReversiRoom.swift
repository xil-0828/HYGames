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
   
    var body: some View {
        ZStack {
            VStack {
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
                    let _ = print(viewModel.isFullyRoom)
                    OnlineReversiGame()
                        
                }
                Text("部屋に入る")
                HStack {
                    
                    ForEach(viewModel.emptyroomdata, id: \.self) { data in
                        Button {
                            db.collection("EmptyRoom").document(data.UserName).delete()
                            db.collection("FullyRoom").document(data.UserName).setData(["BlackUser": data.UserName,"WhiteUser":UserName.UserName])
                            RoomName = data.UserName
                            
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
            
            print("isFullyRoom:\(viewModel.isFullyRoom)")
            viewModel.UserName = UserName.UserName
        }
    }
}

