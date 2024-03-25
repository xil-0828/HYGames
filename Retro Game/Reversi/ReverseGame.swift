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
    @State var BlackCount = 2;
    @State var WhiteCount = 2;
    @State var isSettingAnimation = false;
    @State var isViewReset = false;
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            if UIDevice.current.userInterfaceIdiom == .phone {
                VStack(spacing: 0) {
                    if(OthelloOrder == 0) {
                        HStack {
                            Spacer().frame(width: 5)
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 50)
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle()
                                        .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                        .modifier(NeumorphismModifier())
                                    
                                    Spacer()
                                    Text("\(BlackCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                    
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer()
                        }
                    
                    }else {
                        HStack {
                            Spacer().frame(width: 5)
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 50)
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle()
                                        .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                        .modifier(NeumorphismModifier())
                                    Spacer()
                                    Text("\(BlackCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                    
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
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
                                        let count = BoardCount(OthelloBoard: OthelloBoard)
                                        BlackCount = count.black
                                        WhiteCount = count.white
                                        OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                        OthelloOrder = (OthelloOrder + 1) % 2;
                                        if(OthelloPlace.count == 0) {
                                            OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                            OthelloOrder = (OthelloOrder + 1) % 2;
                                            if(OthelloPlace.count == 0) {
                                                Winner = WhereWinner(OthelloBoard: OthelloBoard)
                                                isSettingAnimation = true
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
                            Spacer().frame(width: 5)
                            Button {
                                isSettingAnimation.toggle()
                            }label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 10) / 8 * 1.5, height: 50)
                                    Image(systemName: "gear")
                                        .font(.system(size: 20))
                                        .foregroundColor(.gray)
                                    
                                        
                                }
                                .symbolEffect(.bounce,value:isSettingAnimation)
                            }
                            Spacer()
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 50)
                                
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    Spacer()
                                    Text("\(WhiteCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer().frame(width: 5)
                        }
                                        
                    }else {
                        HStack {
                            
                            Spacer().frame(width: 5)
                            Button {
                                isSettingAnimation.toggle()
                            }label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 10) / 8 * 1.5, height: 50)
                                    Image(systemName: "gear")
                                        .font(.system(size: 20))
                                        .foregroundColor(.gray)
                                    
                                        
                                }
                                .symbolEffect(.bounce,value:isSettingAnimation)
                            }
                            Spacer()
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 50)
                                
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 20) / 10.5, height: (deviceWidth - 20) / 10.5)
                                    Spacer()
                                    Text("\(WhiteCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer().frame(width: 5)
                        }
                    }
                }
            }else {
                VStack(spacing: 0) {
                    if(OthelloOrder == 0) {
                        HStack {
                            Spacer().frame(width: 5)
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 70)
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle()
                                        .frame(width: 65, height: 65)
                                        .modifier(NeumorphismModifier())
                                    
                                    Spacer()
                                    Text("\(BlackCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                    
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer()
                        }
                    
                    }else {
                        HStack {
                            Spacer().frame(width: 5)
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 70)
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle()
                                        .frame(width: 65, height: 65)
                                        .modifier(NeumorphismModifier())
                                    Spacer()
                                    Text("\(BlackCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                    
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
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
                                        let count = BoardCount(OthelloBoard: OthelloBoard)
                                        BlackCount = count.black
                                        WhiteCount = count.white
                                        OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                        OthelloOrder = (OthelloOrder + 1) % 2;
                                        if(OthelloPlace.count == 0) {
                                            OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
                                            OthelloOrder = (OthelloOrder + 1) % 2;
                                            if(OthelloPlace.count == 0) {
                                                Winner = WhereWinner(OthelloBoard: OthelloBoard)
                                                isSettingAnimation = true
                                            }
                                        }
                                        
                                    }
                                    
                                }label: {
                                    ZStack {
                                        let x = 50.0
                                        Rectangle()
                                            .stroke(Color(red: 197/255, green: 200/255, blue: 209/255), lineWidth: 0.5)
                                            .frame(width: x, height: x)
                                        
                                        
                              
                                        
                                        if(OthelloBoard[i][j] == 1) {
                                            Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                                .frame(width: x - 10, height: x - 10)
                                                
                                        }else if(OthelloBoard[i][j] == 0 ) {
                                            Circle()
                                                .frame(width: x - 10, height: x - 10)
                                                .modifier(NeumorphismModifier())
                        
                                            
                                        }else if(OthelloPlace.keys.contains(XY(x: i, y: j))) {
                                            Circle().fill(Color.Neumorphic.main).softInnerShadow(Circle())
                                                .frame(width: x - 10, height: x - 10)
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                    Spacer().frame(height: 40)
                    if(OthelloOrder == 0) {
                        HStack {
                            Spacer().frame(width: 5)
                            Button {
                                isSettingAnimation.toggle()
                            }label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 10) / 8 * 1.5, height: 70)
                                    Image(systemName: "gear")
                                        .font(.system(size: 25))
                                        .foregroundColor(.gray)
                                    
                                        
                                }
                                .symbolEffect(.bounce,value:isSettingAnimation)
                            }
                            Spacer()
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 70)
                                
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: 65, height: 65)
                                    Spacer()
                                    Text("\(WhiteCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer().frame(width: 5)
                        }
                                        
                    }else {
                        HStack {
                            
                            Spacer().frame(width: 5)
                            Button {
                                isSettingAnimation.toggle()
                            }label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: (deviceWidth - 10) / 8 * 1.5, height: 70)
                                    Image(systemName: "gear")
                                        .font(.system(size: 25))
                                        .foregroundColor(.gray)
                                    
                                        
                                }
                                .symbolEffect(.bounce,value:isSettingAnimation)
                            }
                            Spacer()
                            ZStack(alignment: .leading
                            ) {
                                RoundedRectangle(cornerRadius: 10).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: (deviceWidth - 10) / 8 * 3, height: 70)
                                
                                
                                HStack {
                                    Spacer().frame(width: 10)
                                    Circle().fill(Color.Neumorphic.main).softOuterShadow()
                                        .frame(width: 65, height: 65)
                                    Spacer()
                                    Text("\(WhiteCount)")
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer().frame(width: 10)
                                }
                                .frame(width: (deviceWidth - 10) / 8 * 3)
                            }
                            Spacer().frame(width: 5)
                        }
                    }
                }
            }
            
            if isSettingAnimation {
                
                ZStack {
                    // 背景部分
                    Color.black
                        .opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                    // ダイアログ部分
                    Button {
                        isSettingAnimation = false
                    }label: {
                        Rectangle()
                            .frame(width: deviceWidth,height: deviceHeight)
                            .opacity(0)
                    }
                    
                    VStack {
                        Spacer()
                        Button {
                            OthelloBoard =
                            [[-1, -1, -1, -1, -1, -1, -1, -1],
                             [-1, -1, -1, -1, -1, -1, -1, -1],
                             [-1, -1, -1, -1, -1, -1, -1, -1],
                             [-1, -1, -1,  1,  0, -1, -1, -1],
                             [-1, -1, -1,  0,  1, -1, -1, -1],
                             [-1, -1, -1, -1, -1, -1, -1, -1],
                             [-1, -1, -1, -1, -1, -1, -1, -1],
                             [-1, -1, -1, -1, -1, -1, -1, -1]];
                            //オセロの順番
                            OthelloOrder = 0
                            OthelloPlace = [XY: [XY]]()
                            GameFinish = false;
                            Winner = 0;
                            gameResetToken = UUID()
                            BlackCount = 2;
                            WhiteCount = 2;
                            isSettingAnimation = false;
                            isViewReset = false;
                        }label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: UIScreen.main.bounds.width / 1.2,height: 50)
                                
                                HStack {
                                    Spacer().frame(width: 20)
                                    Image(systemName: "restart.circle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                    Spacer().frame(width: 20)
                                    Text("Restart")
                                        .font(.custom("SofiaPro", size: 15))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width / 1.2)
                        }
                        Spacer()
                        Button {
                            self.presentation.wrappedValue.dismiss()
                        }label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.Neumorphic.main).softOuterShadow()
                                    .frame(width: UIScreen.main.bounds.width / 1.2,height: 50)
                                
                                HStack {
                                    Spacer().frame(width: 20)
                                    Image(systemName: "house.circle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 20))
                                    Spacer().frame(width: 20)
                                    Text("Home")
                                        .font(.custom("SofiaPro", size: 15))
                                        .foregroundColor(Color(red: 87/255, green: 95/255, blue: 107/255))
                                    Spacer()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width / 1.2)
                        }
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.1,height: UIScreen.main.bounds.width / 1.8)
                    .background(Color(red: 235/255, green: 240/255, blue: 243/255))
                    .cornerRadius(15)
                    
                    
                    
                        
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            OthelloPlace = FindOthelloPiece(OthelloBoard: OthelloBoard, OthelloOrder: OthelloOrder)
            OthelloOrder += 1;
        }
        .id(gameResetToken)
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
