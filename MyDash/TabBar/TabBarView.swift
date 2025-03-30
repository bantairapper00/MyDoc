//
//  TabBarView.swift
//  MyDash
//
//  Created by Abhishek on 16/01/25.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = TabsData.about.rawValue
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TabView (selection: $selectedTab) {
                Group {
                    if viewModel.userSession != nil {
                        ProfileView()
                    } else {
                        LoginView()
                    }
                }
                    .tag(TabsData.about.rawValue)
                DocumentView()
                    .tag(TabsData.document.rawValue)
                NewsPageView(viewModel: NewsPageVIewModel())
                    .tag(TabsData.news.rawValue)
                Text("Anime")
                    .tag(TabsData.anime.rawValue)
                Text("Stock")
                    .tag(TabsData.stocks.rawValue)
            }
            .padding(.bottom, -50)
            HStack() {
                ForEach(TabsData.allCases, id: \.rawValue) { tabData in
                    TabItemView(tabData: tabData, tab: tabData.index, selectedTab: $selectedTab)
                }
            }
            .frame(height: appState.hideTabBar ? 0 : 50)
            .opacity(appState.hideTabBar ? 0 : 1)
        }
//        .onAppear {
//            let tabBarAppearance = UITabBarAppearance()
////            tabBarAppearance.configureWithDefaultBackground()
//            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//        }
        .ignoresSafeArea(.keyboard, edges: .all)
        
    }
}

#Preview {
    TabBarView()
        .environmentObject(AppState())
}
