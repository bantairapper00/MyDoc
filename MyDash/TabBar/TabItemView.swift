//
//  TabItemView.swift
//  MyDash
//
//  Created by Abhishek on 17/01/25.
//

import Foundation
import SwiftUI

struct TabItemView: View {
    var tabData: TabsData
    var tab: Int
    @Binding var selectedTab: Int
    var body: some View {
        VStack(spacing: 10){
            Rectangle()
                .fill(tab == selectedTab ? Color.black : Color.clear)
                .frame(height: 4)
            Image(systemName: tabData.tabImage)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
            
            Text(tabData.tabName)
                .font(.system(size: 14))
        }
        .onTapGesture {
            withAnimation {
                selectedTab = tab
            }
        }
    }
}

#Preview {
    TabItemView(tabData: TabsData.about, tab: 1, selectedTab: .constant(1))
}
