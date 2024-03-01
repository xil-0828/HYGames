import SwiftUI

struct Retro_GameView: View {
    //ステートプロパティ
    @State private var trigger = false

    var body: some View {
        VStack {
            Text("破スイッチ")
                .font(.largeTitle)
            Spacer()
            ZStack{
                //三項演算子(条件式 ? true時の値 : false時の値)
                Image(self.trigger ? "computer_note_bad" :"computer_man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                //triggerがtrueだったら
                if trigger{
                    //構造体を呼び出す
                    LoadingView()
                }
            }
            Spacer()
            Button(action: {
                //クロージャ内ではプロパティを参照する際には自分自身を指すselfを指定
                //toggleメソッドはブール値(Bool型)の値を反転させる
                self.trigger.toggle()
            }) {
                //三項演算子(条件式 ? true時の値 : false時の値)
                Text(self.trigger ? "もういちど" : "ばくはつ!")
            }
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding()
        }
    }
}

struct LoadingView: View {
    //ステートプロパティ
    @State private var index = 0
    //mapで1~16の数字に処理を適用し、その処理を施した配列imagesを作成する
    private let images = (1...16).map { UIImage(named: "explotion_\($0)")! }
    //指定された時間の間隔で現在の日時への接続を繰り返す
    private var timer = Timer.publish(every: 0.05, on: .main, in: .default).autoconnect()

    var body: some View {
       return Image(uiImage: images[index])
           .resizable()
           .scaledToFit()
           .frame(width: 300, height: 300, alignment: .center)
           //パブリッシャー(timer)によって発行されたデータを検出したときの処理
           .onReceive(
               timer,
               perform: { _ in
                   //クロージャ内ではプロパティを参照する際には自分自身を指すselfを指定
                   self.index = self.index + 1
                   if self.index >= 16 {
                       //timerの自動接続を停止
                       self.timer.upstream.connect().cancel()
                       self.index = 0
                   }
               }
           )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
