//
//  ContentView.swift
//  BoringDay
//
//  Created by gabrielfelipo on 11/11/22.
//

import SwiftUI

struct Activities: Codable {
    var activity: String
    var type: String
}


struct ContentView: View {
    @AppStorage("progressActivities") var progressActivities: [String] = []
    @AppStorage("completeActivities") var completeActivities: [String] = []
    @AppStorage("withdrawalActivities") var withdrawalActivities: [String] = []
    @AppStorage("progressDates") var progressDates: [Date] = []
    @AppStorage("withdrawalTime") var withdrawalTime: [String] = []
    @AppStorage("completeTime") var completeTime: [String] = []
    @State var activities = Activities(activity: "", type: "")
    @State var refresh: Bool = false
    @State var filter = "/"
    @State var tabSelection = 1
    let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            CompleteView(activities: $completeActivities, completeTime: $completeTime)
                .tabItem() {
                    Image(systemName: "checkmark.circle")
                    Text("Completos")
                }
                .tag(0)
                .task {
                    await fetchData()
                }
            
            ProgressView(activitie: $activities, activities: $progressActivities, dates: $progressDates, refresh: $refresh, filter: $filter, tabSelection: $tabSelection, withdrawalTime: $withdrawalTime, completeTime: $completeTime, completeActivities: $completeActivities, withdrawalActivities: $withdrawalActivities)
                .task {
                    await fetchData()
                }
                .badge(progressActivities.count)
                .tabItem() {
                    Image(systemName: "figure.walk")
                    Text("Andamento")}
                .tag(1)
                .onReceive(timer) {_ in
                    if refresh == true {
                        tabSelection = 1
                        refresh = false
                    }
                            }
            
            WithdrawalView(activities: $withdrawalActivities, withdrawalTime: $withdrawalTime)
                .tabItem() {
                    Image(systemName: "x.circle")
                    Text("Desistência")
                }
                .tag(2)
            
        }
    }
    func fetchData() async  {
        // create url
        guard let url = URL(string: "http://www.boredapi.com/api/activity\(filter)") else {
            print("URL not working")
            return
        }
        //fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(url)
            //decode that data
            if let decodedResponse = try? JSONDecoder().decode(Activities.self, from: data) {
                self.activities = decodedResponse
            }
        } catch {
            print("This data is invalid")
        }
        
        
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
