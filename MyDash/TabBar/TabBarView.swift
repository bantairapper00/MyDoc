//
//  TabBarView.swift
//  MyDash
//
//  Created by Abhishek on 16/01/25.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = TabsData.about.rawValue
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView (selection: $selectedTab) {
                Text("About")
                    .tag(TabsData.about.rawValue)
                Text("Document")
                    .tag(TabsData.document.rawValue)
                NewsPageView(viewModel: NewsPageVIewModel())
                    .tag(TabsData.news.rawValue)
                Text("Anime")
                    .tag(TabsData.anime.rawValue)
                Text("Stock")
                    .tag(TabsData.stocks.rawValue)
            }
            HStack() {
                ForEach(TabsData.allCases, id: \.rawValue) { tabData in
                    TabItemView(tabData: tabData, tab: tabData.index, selectedTab: $selectedTab)
                }
            }
            .frame(height: 50)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    TabBarView()
}
