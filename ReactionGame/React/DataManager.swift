//
//  DataManager.swift
//  React
//
//  Created by cmStudent on 2025/10/01.
//

import Foundation

class Result: Identifiable { // 名前と反応速度の時間を管理するクラス
   let id = UUID()
   let name: String
   let reactTime: Double
   
   init(name: String, reactTime: Double) {
      self.name = name
      self.reactTime = reactTime
   }
}

var results: [Result] = []

func setResult(name: String, reactTime: Double) {
   let resultData = Result(name: name, reactTime: reactTime)
   results.append(resultData)
}

func getResults() -> [Result] {
   return results
}

func sortResults(){
   
   var isEnd = false
    if (results.isEmpty){return}
   while(!isEnd){
       
      var loopSwap = false
      for i in 0..<results.count - 1 {
         if results[i].reactTime > results[i+1].reactTime {
            let temp = results[i]
            results[i] = results[i+1]
            results[i+1] = temp
            loopSwap = true;
         }
      }
      if !loopSwap {
         isEnd = true
      }
   }
}
func showResult() {
   for result in results {
      print("\(result.name): \(result.reactTime)")
   }
}
