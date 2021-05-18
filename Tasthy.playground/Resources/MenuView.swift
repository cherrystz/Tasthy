import SwiftUI
import CoreData

public struct MenuView: View {
    
    let MenuList: [String] = ["pad-kraprao","green-curry","clear-soup","pad-thai","tom-yum"]
    
    public var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 25.0) {
                
                // Heading and sub of Apps
                VStack(alignment: .center) {
                    Text("Tasthy!")
                        .bold()
                        .font(.system(size: 48))
                    Text("Pick a menu of Thai food to help your cook")
                        .bold()
                        .font(.system(size: 14))
                }
                
                // Horizontal Stack of view
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 10) {
                        
                        ForEach(MenuList, id: \.self) { menu in
                            
                            NavigationLink(destination: RecipeView(CurrentMenu: menu)) {
                                Image(menu)
                                    .cornerRadius(30)
                                    .overlay(
                                        Text(Menus[menu]!)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24.0))
                                            .padding()
                                        ,alignment: .bottomLeading
                                    )
                            }
                            .frame(width: 381, height: 346, alignment: .center)
                            
                        }
                        
                        NavigationLink(destination: RecipeView()) {
                            
                            VStack {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .accentColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                    .frame(width: 100, height: 100, alignment: .center)
                                Text("Add new")
                                    .accentColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                            }
                            
                                
                        }
                        .frame(width: 381, height: 346, alignment: .center)
                    }
                })
            }
            .navigationBarHidden(true)
            
        }
    }
}
