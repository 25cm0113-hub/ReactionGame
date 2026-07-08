import SwiftUI

struct ContentView: View {
   
   @State var isShowingPlayingView = false // ゲーム画面が表示されているか
   @State var isShowingRankingView = false // ランキング画面が表示されているか
   
   let scwidth = UIScreen.main.bounds.width // 画面サイズ横幅取得
   let scheight = UIScreen.main.bounds.height // 画面サイズ高さ取得
   
   let soundPlayer = SoundPlayer() // 音源データ
    
   
   var body: some View {
      ZStack {
         Image("home")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
          VStack {
              Image(.gameTitle) // ゲームタイトル画像
                  .resizable()
                  .scaledToFit()
                  .padding(.init(top: 0, leading: 20, bottom: 80, trailing:40))
              buttons
              Spacer()
          }
         .padding(.top, 20)
      }
      .onAppear(){
          soundPlayer.backgroundMusic()
      }
      
   }
   
   var buttons: some View {
      VStack {
         // Startボタン
         Button {
             soundPlayer.backgroundMusicStop()
            soundPlayer.soundTapPlay()
            isShowingPlayingView = true // View移動をtrue
         } label: {
            VStack {
               Image(systemName: "play.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: scwidth * 0.125)
               Text("Start")
                  .font(.largeTitle)
                  .fontWeight(.bold)
                  .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, minHeight: scheight * 0.2)
            .background(Color.white.opacity(0.75))
            .cornerRadius(20)
         }
         .fullScreenCover(isPresented: $isShowingPlayingView) {
            PlayingView()
         }
         .padding(.horizontal, 80) // Startボタンend
         // Rankingボタン
         Button {
            sortResults()
            soundPlayer.soundTapRanking()
            isShowingRankingView = true
         } label: {
            VStack {
               Image(systemName: "flag.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: scwidth * 0.125)
               Text("Ranking")
                  .font(.largeTitle)
                  .fontWeight(.bold)
                  .foregroundStyle(.black)
            }
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: scheight * 0.2)
            .background(Color.white.opacity(0.75))
            .cornerRadius(20)
         }
         .fullScreenCover(isPresented: $isShowingRankingView) {
            RankingView()
         }
         .padding(.top, 50)
         .padding(.horizontal, 80) // Ranking Button end.
      }
   }
}

#Preview {
   ContentView()
}

