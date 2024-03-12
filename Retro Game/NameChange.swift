//
//  NameChange.swift
//  Retro Game
//
//  Created by 平井悠貴 on 2024/03/11.
//

import SwiftUI
class NameChangeAppstorage:ObservableObject {
    @AppStorage("UserName") var UserName = ""
}
struct NameChange: View {
    @ObservedObject var UserName = NameChangeAppstorage()
    @State var isTextCountOver = false
    @Binding var isNameChange: Bool
  var body: some View {
      ZStack {
          VStack {
              Text("ゲームをするときのニックネームを決めてください")
              Text("８文字以内でお願いします")
              TextField("Enter text", text: $UserName.UserName)
                  .onChange(of: UserName.UserName) { newValue in
                      if newValue.count > 8 {
                          let index = newValue.index(newValue.startIndex, offsetBy: 8)
                          UserName.UserName = String(newValue.prefix(upTo: index))
                      }
                  }
              Button {
                  if UserName.UserName.count > 0 {
                      isNameChange = false
                  }
              }label: {
                  ZStack {
                      Text("決定")
                          .foregroundColor(.black)
                      Rectangle()
                          .frame(width: 100,height: 50)
                          .foregroundColor(.blue)
                  }
              }
              .padding()
              .interactiveDismissDisabled()
          }
      }
  }
}

