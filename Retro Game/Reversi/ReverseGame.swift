//
//  SwiftUIView.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/03.
//

import SwiftUI
import Neumorphic

struct XY: Hashable {
    var x: Int
    var y: Int

    init(x: Int = 1, y: Int = 1) {
        self.x = x
        self.y = y
    }
}



struct ReverseGame: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    // 0:黒 1:白
    @State var OthelloBoard =
        [[-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1,  1,  0, -1, -1, -1],
         [-1, -1, -1,  0,  1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1],
         [-1, -1, -1, -1, -1, -1, -1, -1]];
    //オセロの順番
    @State var OthelloOrder = 0
    @State var OthelloPlace = [XY: [XY]]()
    @State var GameFinish = false;
    @State var Winner = 0;
    @Environment(\.presentationMode) var presentation
    @State private var gameResetToken = UUID()
    @ObservedObject var UserName = NameChangeAppstorage()
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            VStack(spacing: 0) {
                if(OthelloOrder == 0) {
                    HStack {
                        Spacer().frame(width: 5)
                        ZStack(alignment: .leading
                        ) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                .frame(width: deviceWidth * 0.4, height: 50)
                            
                            HStack {
                                Spacer().frame(width: 10)
                                Circle()
                                    .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    .modifier(NeumorphismModifier())
                                Spacer()
                                Text("2")
                                Spacer().frame(width: 10)
                                
                            }
                            .frame(width: deviceWidth * 0.4)
                        }
                        Spacer()
                    }
                
                }else {
                    HStack {
                        Spacer().frame(width: 5)
                        ZStack(alignment: .leading
                        ) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                .frame(width: deviceWidth * 0.4, height: 50)
                            
                            HStack {
                                Spacer().frame(width: 10)
                                Circle()
                                    .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    .modifier(NeumorphismModifier())
                                Spacer()
                                Text("2")
                                Spacer().frame(width: 10)
                                
                            }
                            .frame(width: deviceWidth * 0.4)
                        }
                        Spacer()
                    }
                }
                Spacer().frame(height: 40)
                ForEach(0..<8) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { j in
                            Button {
                                print(i,j)
                                if(OthelloPlace.keys.contains(XY(x: i, y: j))) {
                                    let ar = OthelloPlace[XY(x: i, y: j)]!
                                    for z in ar {
                                        OthelloBoard[i][j] = (OthelloOrder + 1) % 2
                                        OthelloBoard[z.x][z.y] = (OthelloOrder + 1) % 2
                                    }
                                    OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                    OthelloOrder = (OthelloOrder + 1) % 2;
                                    if(OthelloPlace.count == 0) {
                                        OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                        OthelloOrder = (OthelloOrder + 1) % 2;
                                        if(OthelloPlace.count == 0) {
                                            Winner = WhereWinner(OthelloBoard: OthelloBoard)
                                            GameFinish = true
                                        }
                                    }
                                }
                                
                            }label: {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color(red: 197/255, green: 200/255, blue: 209/255), lineWidth: 0.5)
                                        .frame(width: (deviceWidth - 10) / 8, height: (deviceWidth - 10) / 8)
                                    if(OthelloBoard[i][j] == 1) {
                                        Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    }else if(OthelloBoard[i][j] == 0 ) {
                                        Circle()
                                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                            .modifier(NeumorphismModifier())
//                                        Circle()
//                                            .fill(Color(red: 87/255, green: 95/255, blue: 107/255))
//                                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
//                                            .shadow(color: Color(red: 87/255, green: 95/255, blue: 107/255), radius: 16, x: -8, y: -8)
                                        
                                        
                                    }else if(OthelloPlace.keys.contains(XY(x: i, y: j))) {
                                        Circle().fill(Color.Neumorphic.main).softInnerShadow(Circle())
                                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                Spacer().frame(height: 40)
                if(OthelloOrder == 0) {
                    HStack {
                        Spacer()
                        ZStack(alignment: .leading
                        ) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                .frame(width: deviceWidth * 0.4, height: 50)
                            
                            
                            HStack {
                                Spacer().frame(width: 10)
                                Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                Spacer()
                                Text("2")
                                Spacer().frame(width: 10)
                            }
                            .frame(width: deviceWidth * 0.4)
                        }
                        Spacer().frame(width: 5)
                    }
                                    
                }else {
                    HStack {
                        
                        Spacer()
                        ZStack(alignment: .leading
                        ) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                .frame(width: deviceWidth * 0.4, height: 50)
                            
                            
                            HStack {
                                Spacer().frame(width: 10)
                                Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                Spacer()
                                Text("2")
                                Spacer().frame(width: 10)
                            }
                            .frame(width: deviceWidth * 0.4)
                        }
                        Spacer().frame(width: 5)
                    }
                }
            }
            .alert("GameSet", isPresented: $GameFinish) {
                Button("スタートに戻る") {
                    self.presentation.wrappedValue.dismiss()
                }
            } message: {
                        // アラートのメッセージ...
                if(Winner == 0) {
                    Text("黒の勝ちです")
                }else {
                    Text("白の勝ちです")
                }
                        
            }
            if(OthelloOrder == 0) {
                
                

            }else {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
//                        .frame(width: deviceWidth * 0.6, height: 50)
//                        
//                    HStack {
//                        Circle()
//                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
//                            .modifier(NeumorphismModifier())
//                        Text(UserName.UserName)
//                        Text("2")
//                    }
//                }
//                
//                
//                ZStack {
//                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
//                        .frame(width: deviceWidth * 0.6, height: 50)
//                        
//                    HStack {
//                        Circle().fill(Color.Neumorphic.main).softOuterShadow()
//                            .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
//                        Text(UserName.UserName)
//                        Text("2")
//                    }
//                }
                
                    
            }
            
        }
        .onAppear {
            OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
            OthelloOrder += 1;
        }
    }
    //次のコマが置けるところを探す関数
    
}

#Preview {
    ReverseGame()
}
import SwiftUI



struct NeumorphismModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color.ForegroundColor)
            .shadow(color: color.LightShadowColor, radius: 3.0, x: 3.0, y: 3.0)
            .shadow(color: color.DarkShadowColor, radius: 3.0, x: -3.0, y: -3.0)
    }
}

class color {
    static let BaseColor: Color = Color(red: 0.3450978696346283, green: 0.37254902720451355, blue: 0.4156862497329712)
    static let LightShadowColor: Color = Color(red: 0.2666664719581604, green: 0.29411762952804565, blue: 0.3372548520565033)
    static let DarkShadowColor: Color = Color(red: 1.0078431367874146, green: 1.0117647647857666, blue: 1.0274510383605957)
    static let ForegroundColor: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 0.3450978696346283, green: 0.37254902720451355, blue: 0.4156862497329712), Color(red: 0.3450978696346283, green: 0.37254902720451355, blue: 0.4156862497329712)]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
import SwiftUI



//class color {
//    static let BaseColor: Color = Color(red: 0.929411768913269, green: 0.9333333373069763, blue: 0.9490196108818054)
//    static let LightShadowColor: Color = Color(red: 0.8509804010391235, green: 0.8549019694328308, blue: 0.8705882430076599)
//    static let DarkShadowColor: Color = Color(red: 1.0078431367874146, green: 1.0117647647857666, blue: 1.0274510383605957)
//    static let ForegroundColor: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 0.929411768913269, green: 0.9333333373069763, blue: 0.9490196108818054), Color(red: 0.929411768913269, green: 0.9333333373069763, blue: 0.9490196108818054)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//}
