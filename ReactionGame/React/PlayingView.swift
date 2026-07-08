import SwiftUI

struct PlayingView: View {
    @State private var isShining = false        // 光ったかどうか
    @State private var startTime: Date?         // 光り始めた時刻
    @State private var reactionTime: Double?    // 成功時の反応時間
    @State private var isFail = false           // フライング判定
    @State private var showResult = false       // 結果画面表示
    @State private var workFailSoundWork : DispatchWorkItem?
   
    let sp = SoundPlayer()

    var body: some View {
        ZStack {
            if showResult {
                // 結果画面をそのまま重ねて表示
                ResultingView(
                    reactionTime: reactionTime,
                    isFail: isFail,
                    onRetry: resetGame
                )
                .transition(.opacity) // フェード切り替え
            } else {
                // 通常のプレイ画面
                ZStack {
                    (isShining ? Image(.shining) : Image(.waiting))
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    if isShining{
                        Image(.tap)
                            .resizable()
                            .scaledToFit()
                            
                    } else {
                        Text("Ready?")
                            .font(.largeTitle)
                            .foregroundColor(isShining ? .yellow : .white)
                    }
                    

                }
                .transition(.opacity)
                .onAppear { startWaiting() }
                .onTapGesture { handleTap() }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showResult) // スムーズな切替
    }

    // ランダムで光る
    func startWaiting() {
        isShining = false
        reactionTime = nil
        isFail = false
        showResult = false
        workFailSoundWork?.cancel()
       
        let delay = Double.random(in: 5...7)
        let work = DispatchWorkItem{
                sp.soundThunder()
                isShining = true
                startTime = Date()
        }
        workFailSoundWork = work
        DispatchQueue.main.asyncAfter(deadline: .now() + delay ,execute : work)
    }

    // タップ処理
    func handleTap() {
        workFailSoundWork?.cancel()
        if isShining, let start = startTime {
            reactionTime = Date().timeIntervalSince(start)
            isFail = false
           
        } else {
            reactionTime = nil
            isFail = true
           
                sp.soundFail()
        }
        withAnimation {
            showResult = true
        }
    }

    // リセット
    func resetGame() {
        withAnimation {
            startWaiting()
        }
    }
}

#Preview {
    PlayingView()
}


