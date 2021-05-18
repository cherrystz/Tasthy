import CoreData
import SwiftUI

public struct MenuView: View {
    
    public init() {
        
    }
    
    let Menu_Store: [Int:[String]] = fetchMenu()
    
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
                        
                        ForEach(1...Menu_Store.count, id: \.self) { index in
                            let data = Menu_Store[index]
                            NavigationLink(destination: RecipeView(
                                            CurrentMenu: fetchItem(id: index),
                                            MenuName: (data?[0])!,
                                            menu_id: index,
                                            didTap: Array(repeatElement(false, count: fetchItem(id: index)[0].count))
                                            
                                )) {
                                Image(name: (data?[1])! + ".jpg")
                                    .resizable()
                                    .cornerRadius(30)
                                    .overlay(
                                        Text((data?[0])!)
                                            .foregroundColor((data?[1])! == "food-default" ? .black : .white)
                                            .font(.system(size: 24.0))
                                            .padding()
                                        ,alignment: .bottomLeading
                                    )
                                    
                            }
                            
                            .frame(width: 381, height: 346, alignment: .center)
                            
                        }
                        
                        NavigationLink(destination: Create()) {
                            
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
