//
//  ProgressView.swift
//  BoringDay
//
//  Created by gabrielfelipo on 11/11/22.
//

import SwiftUI

struct ProgressView: View {
    @Binding var activitie: Activities
    @State var showPopUp = false
    @Binding var activities: [String]
    @Binding var dates: [Date]
    @Binding var refresh: Bool
    @Binding var filter: String
    @Binding var tabSelection: Int
    @Binding var withdrawalTime: [String]
    @Binding var completeTime: [String]
    @Binding var completeActivities: [String]
    @Binding var withdrawalActivities: [String]
    @State var timeCount = 0
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var body: some View{
        ZStack{
            VStack {
                Text(String(timeCount)).hidden()
                if filter.count > 1{
                    let start = filter.index(filter.startIndex, offsetBy: 6)
                    let end = filter.index(filter.endIndex, offsetBy: -1)
                    let range = start...end
                    let subFilter = String(filter[range])
                    
                    Text("Seu filtro de atividade atual é: \(subFilter)")
                }
                else {
                    Text("Você não tem filtros ativos")
                }
                
                HStack {
                    Button("Gerar atividade"){
                        activities.insert(activitie.activity, at: 0)
                        dates.insert(Date.now, at: 0)
                        refresh = true
                        self.tabSelection = 0
                    }
                    Button("Alterar filtro") {
                        showPopUp = true
                    }
                }
                .buttonStyle(.bordered)

                
                Spacer().frame(height: 16)
                ScrollView{
                    VStack(spacing: 8){
                        ForEach(0..<activities.count, id: \.self) { index in
                            VStack {
                                Spacer().frame(height: 8)
                                
                                Text(activities[index])
                                let dif = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: dates[index], to: Date.now)
                                var duringTime = "\(dif.day ?? 0) dias \(dif.hour ?? 0) horas \(dif.minute ?? 0) minutos \(dif.second ?? 0) segundos"
                                Text(duringTime).foregroundColor(.gray)
                                    .onReceive(timer) {_ in
                                        let dif = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: dates[index], to: Date.now)
                                        duringTime = "\(dif.day ?? 0) dias \(dif.hour ?? 0) horas \(dif.minute ?? 0) minutos \(dif.second ?? 0) segundos"
                                        timeCount += 1
                                    }
                                
                                HStack {
                                    Button("Concluir"){
                                        let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: dates[index], to: Date.now)
                                        let endTime = "\(diffs.day ?? 0) dias \(diffs.hour ?? 0) horas \(diffs.minute ?? 0) minutos"
                                        completeTime.insert(String(endTime), at: 0)
                                        
                                        completeActivities.insert(activities[index], at: 0)
                                        
                                        activities.removeFirst()
                                    }.foregroundColor(Color.green)
                                    
                                    Button("Desistir") {
                                        let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: dates[index], to: Date.now)
                                        let endTime = "\(diffs.day ?? 0) dias \(diffs.hour ?? 0) horas \(diffs.minute ?? 0) minutos"
                                        withdrawalTime.insert(String(endTime), at: 0)
                                        
                                        withdrawalActivities.insert(activities[index], at: 0)
                                        
                                        activities.removeFirst()
                                    }.foregroundColor(Color.red)
                                }.buttonStyle(.bordered)
                                
                                Spacer().frame(height: 8)
                            }.frame(width: UIScreen.screenWidth)
                                .background(Color.blue.opacity(0.05))
                        }
                    }
                }
                Spacer()
            }
            if showPopUp {
                FilterSheet(showPopUp: $showPopUp, filter: $filter, tabSelection: $tabSelection, refresh: $refresh)
            }
        }
    }
}

