//
//  WithdrawalView.swift
//  BoringDay
//
//  Created by gabrielfelipo on 11/11/22.
//

import SwiftUI

struct WithdrawalView: View {
    @Binding var activities: [String]
    @Binding var withdrawalTime: [String]
    
    var body: some View{
        VStack {
            Text("Desistência").font(.title)
            ScrollView{
                VStack(spacing: 8){
                    ForEach(0..<activities.count, id: \.self) { index in
                        VStack {
                            Spacer().frame(height: 8)
                            
                            Text(activities[index])
                            
                            Text("Você desistiu em: \(withdrawalTime[index])").foregroundColor(.gray)
                            
                            Spacer().frame(height: 8)
                        }.frame(width: UIScreen.screenWidth)
                            .background(Color.blue.opacity(0.05))
                    }
                }
            }
        }
    }
}
