import PlaygroundSupport
import SwiftUI

let Menus: [String:String] = ["pad-kraprao":"Pad Kra Prao","green-curry":"Green Curry","clear-soup":"Clear Soup","pad-thai":"Pad Thai","tom-yum":"Tom Yum Kung","":"Unknown"]

struct RecipeView: View {
    var body: some View {
        Text("Hello World")
    }
}

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    
    static var list = [
        Fruit(name: "Apple", emoji: "🍎"),
        Fruit(name: "Bannanna", emoji: "🍌"),
        Fruit(name: "Cherry", emoji: "🍒"),
        ]
}
    
struct Menu: View {
    
    let MenuList: [String] = ["pad-kraprao","green-curry","clear-soup","pad-thai","tom-yum"]
    
    var body: some View {
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
                        ForEach( Fruit.list ) { fruit in
                                HStack {
                                    Text("\(fruit.emoji)")
                                    Text("\(fruit.name)")
                                }
                                .font(.title)
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
        }
    }
}

