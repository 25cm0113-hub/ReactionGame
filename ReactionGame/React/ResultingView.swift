import SwiftUI

struct ResultingView: View {
    
    let reactionTime: Double? // 成功時の反応時間
    let isFail: Bool          //フライング判定
    let onRetry: () -> Void
    let scheight = UIScreen.main.bounds.height
    let soundPlayer = SoundPlayer()
    
    @State var showRankingSheet = false
    @State var name = ""
    
    @Environment(\.dismiss) private var dismiss //ひとつ前に戻る
    
    var body: some View {
        ZStack {
            Image(.resultBack)
                .ignoresSafeArea()
            VStack(){
                Text("リザルト")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .bold()
                if isFail {
                    Text("押すの早すぎ！")
                        .font(.title)
                        .foregroundColor(.red)
                    
                } else if let time = reactionTime {
                    Text(String(format: "%.6f秒", time))
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }

                Button{
                    onRetry()
                    soundPlayer.soundTapRanking()
                } label: {
                    Text("もう一回")
                        .font(.title2)
                        .padding()
                        .frame(width: 250)
                        .background(Color.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                }
                
                Button{
                    dismiss()
                    soundPlayer.soundTapRanking()
                } label: {
                    Text("ホームに戻る")
                        .font(.title2)
                        .padding()
                        .frame(width: 250)
                        .background(Color.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                }
                if !isFail {
                    Button {
                        showRankingSheet.toggle()
                        soundPlayer.soundTapRanking()
                    } label: {
                        Text("ランキングに載せる！")
                            .font(.title2)
                            .padding()
                            .frame(width: 250)
                            .background(Color.yellow)
                            .foregroundColor(.blue)
                            .cornerRadius(15)
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.9))
            .cornerRadius(25)
            .shadow(radius: 10)
            
            .sheet(isPresented: $showRankingSheet) {
                ZStack {
                    LightningPattern()
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        // タイトルと閉じるボタン
                        HStack {
                            Image(systemName: "bolt.badge.a.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(ThemeColor.accentYellow)
                                .rotationEffect(.degrees(-30))
                            
                            Text("LIGHTNING RANKING")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .tracking(2)
                            
                            Spacer()
                            
                            Button {
                                showRankingSheet = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.gray.opacity(0.7))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 25)
                        .padding(.bottom, scheight * 0.125)
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(ThemeColor.accentYellow)
                                Text("記録を登録")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(ThemeColor.accentYellow)
                            }
                            
                            HStack {
                                // 名前入力
                                TextField("Your Name", text: $name)
                                    .padding(10)
                                // SwiftUIでRoundedBorderTextFieldStyleを再現
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white.opacity(0.9))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(ThemeColor.accentYellow, lineWidth: 2) // 黄色の枠線
                                            )
                                    )
                                    .foregroundColor(.black)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled(true)
                                
                                // OKボタン
                                Button{
                                    // 記録を登録
                                    setResult(name: name, reactTime: reactionTime!)
                                    dismiss()
                                    dismiss()
                                } label: {
                                    Text("OK")
                                        .font(.headline)
                                        .fontWeight(.heavy)
                                        .frame(width: 60, height: 40)
                                        .background(ThemeColor.accentYellow)
                                        .foregroundColor(Color(hex: 0x1E3A8A)) // 濃い青
                                        .cornerRadius(8)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            Text("Score: \(reactionTime!) ms")
                                .font(.subheadline)
                                .foregroundColor(ThemeColor.accentYellow.opacity(0.8))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Spacer()
                        }
                    }
                }
                .presentationBackground(Material.ultraThinMaterial)
            }
        }
    }
}

extension Color {
    // HEXコードからColorを生成するヘルパー（SwiftUIプレビューで便利）
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ThemeColor {
    // 背景グラデーションの開始色 (blue-900)
    static let darkGradientStart = Color(hex: 0x1E3A8A)
    // 背景グラデーションの終了色 (indigo-900)
    static let darkGradientEnd = Color(hex: 0x3730A3)
    // アクセントカラー (黄色/雷)
    static let accentYellow = Color(hex: 0xFACC15)
    // 登録セクションの背景 (blue-800/60をイメージ)
    static let registrationBackground = Color(hex: 0x1E40AF).opacity(0.6)
    // リストの行の背景
    static let rowBackground = Color.blue.opacity(0.5)
}

struct LightningPattern: View {
    var body: some View {
        ZStack {
            // 背景のメイングラデーション
            LinearGradient(colors: [ThemeColor.darkGradientStart, ThemeColor.darkGradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            // 稲妻のパターンをPathで表現し、薄く重ねる
            GeometryReader { geometry in
                Path { path in
                    let patternSize: CGFloat = 80
                    
                    // シンプルな斜めの線でシャープな模様を作成
                    for i in stride(from: -patternSize, to: geometry.size.width + patternSize, by: patternSize) {
                        for j in stride(from: -patternSize, to: geometry.size.height + patternSize, by: patternSize) {
                            path.move(to: CGPoint(x: i, y: j))
                            path.addLine(to: CGPoint(x: i + patternSize, y: j + patternSize))
                        }
                    }
                }
                .stroke(ThemeColor.accentYellow, lineWidth: 1)
                .opacity(0.1) // 非常に薄い半透明
                .rotationEffect(.degrees(45))
            }
        }
    }
}

#Preview {
    ResultingView(reactionTime: 0.4, isFail: false, onRetry: {})
}
