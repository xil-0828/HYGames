//
//  OnlineReversiRoom.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/11.
//

import SwiftUI
import FirebaseFirestore
import Neumorphic
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
            Color.black
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Text("Online")
                    .font(.custom("SofiaPro", size: 15))
                    .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                Divider()
                    .frame(width: UIScreen.main.bounds.width / 1.1 * 0.7)
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.02)
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
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                            .frame(width: UIScreen.main.bounds.width / 1.1 * 0.5,height: 40)
                        Text("Create Room")
                            .font(.custom("SofiaPro", size: 15))
                            .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                    }
                    
                    
                }
                .fullScreenCover(isPresented: $viewModel.isFullyRoom) {
                    OnlineReversiGame(OthelloOrder: $OthelloOrder)
                }
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.04)
                Text("All Room")
                    .font(.custom("SofiaPro", size: 15))
                    .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                Divider()
                    .frame(width: UIScreen.main.bounds.width / 1.1 * 0.7)
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.02)
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
                                    RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 5))
                                        .frame(width: 50, height: 50)
                                    Text(data.UserName)
                                        .font(.custom("SofiaPro", size: 12))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                }
                            }else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: 50,height: 50)
                                    Text(data.UserName)
                                        .font(.custom("SofiaPro", size: 12))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    
                                }
                            }
                            
                        }
                        .fullScreenCover(isPresented: $isShowingSheet) {
                            OnlineReversiGame(OthelloOrder: $OthelloOrder)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width / 1.1,height: UIScreen.main.bounds.width / 1.4)
            .background(Color(red: 235/255, green: 240/255, blue: 243/255))
            .cornerRadius(15)
            Button {
                isRoomView.toggle()
            }label: {
                ZStack {
                    
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 25))
                }
                
                
            }
            .offset(x: UIScreen.main.bounds.width / 1.1 / 2 * 0.9,y: (UIScreen.main.bounds.width / 1.4 / 2 * 0.9) * -1)
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

