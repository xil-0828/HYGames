//
//  OnlineReversiGame.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/13.
//

import SwiftUI
import FirebaseFirestore
import Combine
struct OnlineReversiGame: View {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    @Binding var OthelloOrder: Int
    @ObservedObject var reversiBattleModel = ReversiBattleModel()
    @State var isAppear = false;
    @StateObject var monitoringNetworkState = MonitoringNetworkState()
    @State  private var count: Int = 0
    @State  var timerPublisher: AnyCancellable?
    @State  private var backgroundTaskID = UIBackgroundTaskIdentifier(rawValue: 0)
    @Environment(\.scenePhase) private var scenePhase
    private func backgroundCount() {
        self.backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
        timerPublisher = Timer.publish(every: 1, on: .current, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue(label: "subthread", qos: .background))
            .sink { _ in
                
                if((reversiBattleModel.addCount - 1) % 2 == OthelloOrder) {
                    count -= 1
                }
                if count == 1000 {
                    UIApplication.shared.endBackgroundTask(backgroundTaskID)
                }
            }
    }
    var body: some View {
        let x = (reversiBattleModel.addCount - 1) % 2
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<8) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { j in
                            Button {
                                //オセロのコマをひっくり返す
                                if(reversiBattleModel.TurnPlace.keys.contains(XY(x: i, y: j)) && x == OthelloOrder) {
                                    //何色にひっくり返すか
                                    
                                    let turnplace = reversiBattleModel.TurnPlace[XY(x: i, y: j)]!
                                    reversiBattleModel.reversiData.OthelloBoard[i][j] = x
                                    for z in turnplace {
                                        reversiBattleModel.reversiData.OthelloBoard[z.x][z.y] = x
                                    }
                                    reversiBattleModel.AddData()
                                    
                                }
                                
                                
                            }label: {
                                ZStack {
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: 0.5)
                                        .frame(width: (deviceWidth - 20) / 8, height: (deviceWidth - 20) / 8)
                                    if(reversiBattleModel.reversiData.OthelloBoard.count > 7) {
                                        if(reversiBattleModel.reversiData.OthelloBoard[i][j] == 0) {
                                            Text("●")
                                        }else if(reversiBattleModel.reversiData.OthelloBoard[i][j] == 1) {
                                            Text("◯")
                                        }else if(reversiBattleModel.TurnPlace.keys.contains(XY(x: i, y: j))) {
                                            Text("x")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                
            }
            if(OthelloOrder == x) {
                Text("あなたのターンです。count:\(count)")
                    .position(x:80,y:((deviceHeight / 2) + ((deviceWidth - 20) / 2)) + 10)
            }else {
                Text("相手のターンです")
                    .position(x:80,y:((deviceHeight / 2) + ((deviceWidth - 20) / 2)) + 10)
                    
            }
            if(reversiBattleModel.GameFinish) {
                Text("ゲーム終了")
                    .position(x:80,y:((deviceHeight / 2) + ((deviceWidth - 20) / 2)) + 10)
            }
            
        }
        .onAppear {
            backgroundCount()
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("フォアグラウンド")
            case .inactive:
                print("フォアグラウンド(作業を一時停止する必要)")
            case .background:
                print("バックグラウンド")
                
            @unknown    default:
                print("不明")
            }
        }.onChange(of:reversiBattleModel.addCount) { x in
            if((reversiBattleModel.addCount - 1) % 2 != OthelloOrder) {
                count = 30
            }
        }.onChange(of: reversiBattleModel.GameFinish) { x in
            if(x) {
                reversiBattleModel.DeleteData()
            }
        }
       
        
    }
}

