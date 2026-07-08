//
//  SoundPlayer.swift
//  React
//
//  Created by cmStudent on 2025/10/01.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
   
   // 音源データ読み込み
   let BtnPlay = NSDataAsset(name: "tapPlay")!.data
   let BtnRanking = NSDataAsset(name: "tapRanking")!.data
   let fail = NSDataAsset(name: "tapFail")!.data
   let thunder = NSDataAsset(name: "dropThunder")!.data
   let waitingThunder = NSDataAsset(name: "waitingThunder")!.data
   let backGroundMusic = NSDataAsset(name: "backgroundmusic")!.data
   
   // 音源プレイヤーの変数
   var BtnPlayPlayer: AVAudioPlayer!
   var BtnRankingPlayer: AVAudioPlayer!
   var failPlayer: AVAudioPlayer!
   var thunderPlayer: AVAudioPlayer!
   var waitingThunderPlayer: AVAudioPlayer!
   var backGroundMusicPlayer: AVAudioPlayer!
   
   // 音源呼び出しメソッド
    func backgroundMusicStop(){
        backGroundMusicPlayer.stop()
    }
    
    func backgroundMusic(){
        do{
            backGroundMusicPlayer = try AVAudioPlayer(data: backGroundMusic)
            backGroundMusicPlayer.play()
            backGroundMusicPlayer.numberOfLoops = -1
         } catch {
            print("bgmでエラー")
        }
    }
    
   func soundTapPlay() {
      do {
         BtnPlayPlayer = try AVAudioPlayer(data: BtnPlay)
         BtnPlayPlayer.play()
      } catch {
         print("playボタン音でエラー")
      }
   }
   func soundTapRanking() {
      do {
         BtnRankingPlayer = try AVAudioPlayer(data: BtnRanking)
         BtnRankingPlayer.play()
      } catch {
         print("rankingボタン音でエラー")
      }
   }
   func soundFail() {
      do {
         failPlayer = try AVAudioPlayer(data: fail)
         failPlayer.play()
      } catch {
         print("Fail音エラー")
      }
   }
   func soundThunder() {
      do {
         thunderPlayer = try AVAudioPlayer(data: thunder)
         thunderPlayer.play()
      } catch {
         print("Thunder音でエラー")
      }
   }
   func soundWaitingThunder() {
      do {
         waitingThunderPlayer = try AVAudioPlayer(data: waitingThunder)
         waitingThunderPlayer.play()
      } catch {
         print("WaitingThunder音でエラー")
      }
   }
   
}
