import SwiftUI
import CoreData

public struct RecipeView: View {
    
    var CurrentMenu: [[String]] = []
    var MenuName: String = ""
    var menu_id: Int = 0
    
    @State var didTap:[Bool] = Array(repeatElement(false, count: 6))
    
    // :- Body
    public var body: some View {
        VStack(alignment: .center) {
            
            LazyVStack(alignment: .leading) {
                
                HStack(spacing:0.0) {
                    Text("Required")
                        .foregroundColor(.black)
                        .bold()
                        .frame(width: 80.0, alignment: .trailing)
                    Text("*")
                        .foregroundColor(.red)
                        .bold()
                    Spacer()
                }
                .frame(height: 30.0)
                .background(Color.init(.systemGray5))
                
                List {
                    ForEach(0..<CurrentMenu[0].count, id: \.self) { x in
                            Button(action: {
                                self.didTap[x] = !didTap[x]
                            }) {
                                HStack {
                                    Image(systemName: didTap[x] ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundColor(didTap[x] ? .blue : .gray)
                                    Text(CurrentMenu[0][x])
                                        .frame(height: 40.0)
                                }
                            }
                    }
                }
                .frame(height: 200.0, alignment: .center)
                .padding(0.0)
                
                
                HStack {
                    Text("Optional")
                        .foregroundColor(.black)
                        .bold()
                        .frame(width: 80.0, alignment: .trailing)
                    Spacer()
                }
                    .frame(height: 30.0)
                    .background(Color.init(.systemGray5))
                
                List {
                    ForEach(CurrentMenu[1], id: \.self) { x in
                            Button(action: {
                                
                            }) {
                                
                                HStack {
                                    Text(x)
                                        .frame(height: 40.0)
                                }
                            }
                    }
                }
                .frame(height: 150.0, alignment: .center)
                
                
            }
            
            Spacer()
            
            NavigationLink(destination: StepCooking(
                            menu_id: menu_id,
                            count: 1
            )) {
                Text("Let's Cook")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 250.0, height: 50.0, alignment: .center)
                    .background(didTap.allSatisfy({$0 == true}) ? Color.green : Color.gray)
                    .cornerRadius(25.0)
            }
            .allowsHitTesting(didTap.allSatisfy({$0 == true}) ? true : false)
            
            Spacer()
            
            .navigationTitle(MenuName+"'s Recipe")
                .accentColor(.black)
        }
    }
}
