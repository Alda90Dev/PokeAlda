//
//  MainTabView.swift
//  PokeAlda
//
//  Created by Aldair Carrillo on 20/10/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace var animation
    @State var currentXValue: CGFloat = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            
            Text("Search")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Types)
            
            PokedexModule.create()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Home)
            
            Text("Notifications")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Regions)
        }
        .overlay(alignment: .bottom) {
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
            }
            .padding(.vertical)
            .padding(.bottom, getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
            .background(
                MaterialEffect(style: .systemUltraThinMaterialDark)
                    .clipShape(BottomCurve(currentXValue: currentXValue))
                    
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .preferredColorScheme(.dark)
        .onAppear {
            let screenSizeWidth = UIScreen.main.bounds.width
            currentXValue = screenSizeWidth / 2
        }
    }
    
    @ViewBuilder
    func SampleCards(color: Color, count: Int) -> some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(1...count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(height: 250)
                    }
                }
                .padding()
                .padding(.bottom, 60)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            }
            .navigationTitle("Home")
        }
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        GeometryReader { proxy in
            Button {
                withAnimation(.spring()) {
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                VStack {
                    getIconTabView(with: tab)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(currentTab == tab ? 15 : 0)
                        .background(
                            ZStack {
                                if currentTab == tab {
                                    MaterialEffect(style: .systemChromeMaterialDark)
                                        .clipShape(Circle())
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .contentShape(Rectangle())
                        .offset(y: currentTab == tab ? -50 : 0)
                    if currentTab != tab {
                        Text(tab.title)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .onAppear {
                if tab == Tab.allCases.first && currentXValue == 0 {
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }

    private func getIconTabView(with tab: Tab) -> Image {
        return tab == .Home ? Image(tab.rawValue) :  Image(systemName: tab.rawValue)
    }
}

#Preview {
    MainTabView()
}

enum Tab: String, CaseIterable {
    case Types = "pawprint.circle.fill"
    case Home = "pokebola"
    case Regions = "map.fill"
    
    var title: String {
        switch self {
        case .Types:
            return "Tipos"
        case .Home:
            return "Pokedex"
        case .Regions:
            return "Regiones"
        }
    }
}

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
}
