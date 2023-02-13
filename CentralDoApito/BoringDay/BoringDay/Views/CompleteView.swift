//
//  CompleteView.swift
//  BoringDay
//
//  Created by gabrielfelipo on 11/11/22.
//

import SwiftUI

struct CompleteView: View {
    @Binding var activities: [String]
    @Binding var completeTime: [String]
    
    var body: some View{
        VStack{
            Text("Completas").font(.title)
            ScrollView{
                VStack(spacing: 8){
                    ForEach(0..<activities.count, id: \.self) { index in
                        VStack {
                            Spacer().frame(height: 8)
                            
                            Text(activities[index])
                            
                            Text("Você completou em: \(completeTime[index])").foregroundColor(.gray)
                            
                            Spacer().frame(height: 8)
                        }.frame(width: UIScreen.screenWidth)
                            .background(Color.blue.opacity(0.05))
                    }
                }
            }
        }
    }
}
