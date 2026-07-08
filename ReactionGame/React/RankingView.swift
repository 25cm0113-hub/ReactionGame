//
//  RankingView.swift
//  React
//
//  Created by cmStudent on 2025/10/01.
//

import SwiftUI

struct RankingView: View {
    
    let results: [Result] = getResults()
    let scwidth = UIScreen.main.bounds.width // 画面サイズ横幅取得
    @Environment(\.dismiss) private var dismiss //ひとつ前に戻る
    
    var body: some View {
        ZStack {
            LightningPattern()
                .ignoresSafeArea()
            VStack {
                if results.isEmpty {
                    VStack{
                        Text("まだランキングがないよ")
                            .foregroundStyle(.yellow)
                            .font(.largeTitle)
                    }
                } else {
                    resultRanking
                }
                Button{
                    dismiss()
                } label: {
                    Text("ホームに戻る")
                        .padding()
                        .font(.title2)
                        .frame(width: 250)
                        .background(Color.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                }
            }
        }
    }
    
    var resultRanking: some View {
        List {
            ForEach(Array(results.enumerated()), id: \.element.id) { index, result in
                HStack(spacing: 15) {
                    ZStack {
                        Rectangle()
                        //                         LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .foregroundStyle(Color(hex: 0xFACC15))
                            .scaledToFit()
                            .frame(maxWidth: scwidth * 0.1)
                            .cornerRadius(10)
                        Text("\(index + 1)")
                            .font(.title)
                            .foregroundStyle(Color.blue)
                            .fontWeight(.bold)
                    }
                    Text("\(result.name)")
                        .font(.title)
                        .foregroundStyle(Color.white)
                    //                        .frame(width: scwidth * 0.35)
                        .lineLimit(1)
                        .padding(.trailing)
                    ZStack {
                        Color(hex: 0xFACC15)
                            .cornerRadius(10)
                            .opacity(0.5)
                        Text("\(result.reactTime)秒")
                            .font(.title)
                            .foregroundStyle(Color.white)
                    }
                }
                if index == 2 {
                    Color(hex: 0xFACC15)
                        .frame(width: scwidth, height: 5)
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RankingView()
}


