//
//  FilterSheet.swift
//  BoringDay
//
//  Created by gabrielfelipo on 19/11/22.
//

import Foundation
import SwiftUI

struct FilterSheet: View {
    @Binding var showPopUp: Bool
    @Binding var filter: String
    @Binding var tabSelection: Int
    @Binding var refresh: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    showPopUp = false
                }
                .ignoresSafeArea()
            ZStack{
                VStack {
                    Spacer().frame(height: 8)
                    
                    Text("Filtros").font(.title.bold())
                    
                    Spacer().frame(height: 16)
                    
                    VStack(spacing:8){
                        Text("without filter")
                            .onTapGesture {
                                filter = "/"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("education")
                            .onTapGesture {
                                filter = "?type=education"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("recreational")
                            .onTapGesture {
                                filter = "?type=recreational"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("social")
                            .onTapGesture {
                                filter = "?type=social"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("diy")
                            .onTapGesture {
                                filter = "?type=diy"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("charity")
                            .onTapGesture {
                                filter = "?type=charity"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("cooking")
                            .onTapGesture {
                                filter = "?type=cooking"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("relaxation")
                            .onTapGesture {
                                filter = "?type=relaxation"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("music")
                            .onTapGesture {
                                filter = "?type=music"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                        Text("busywork")
                            .onTapGesture {
                                filter = "?type=busywork"
                                showPopUp = false
                                refresh = true
                                self.tabSelection = 0
                            }
                    }
                    Spacer()
                    
                }.frame(width: UIScreen.screenWidth/1.1, height: UIScreen.screenHeight/2)
                    .background(Color.white)
                
            }
        }
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

