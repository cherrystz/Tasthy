import CoreData
import SwiftUI

public struct RecipeCreate: View {
    
    @State var name: String = ""
    @State var req = 3
    @State var opt = 1
    @State var step = 3
    
    @State var recipe_req: [String] = []
    @State var recipe_opt: [String] = []
    
    public var body: some View {
        VStack(spacing: 5.0){
            Text("\(name)'s Recipe")
            
            
            // Req List
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
                ForEach(1...req, id: \.self) { x in
                    HStack {
                        Text("\(x):  ")
                        TextField("Recipe \(x)", text: $recipe_req[x-1])
                            .border(Color.init(red: 0.7, green: 0.7, blue: 0.7))
                            .frame(width: 200, alignment: .center)
                    }
                }
            }
            .frame(height: 150.0, alignment: .center)
            
            // Opt List
            HStack {
                Text("Optional")
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 80.0, alignment: .trailing)
                Spacer()
            }
            .frame(height: 30.0)
            .background(Color.init(.systemGray5))
            
            if opt > 0 {
                List {
                    ForEach(1...opt, id: \.self) { x in
                        HStack {
                            Text("\(x):  ")
                            TextField("Recipe \(x)", text: $recipe_opt[x-1])
                                .border(Color.init(red: 0.7, green: 0.7, blue: 0.7))
                                .frame(width: 150, alignment: .center)
                        }
                    }
                }
                .frame(height: 120.0, alignment: .center)
            }
            else {
                Text("No Optional Recipe")
                .frame(height: 120.0, alignment: .center)
            }
            
            NavigationLink(destination: StepCreate(
                name: name,
                recipe_req: recipe_req,
                recipe_opt: recipe_opt,
                step_name: Array(repeating: "", count: step)
            )) {
                Text("Next")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 250.0, height: 50.0, alignment: .center)
                    .background(recipe_req.allSatisfy({$0 != ""}) && (recipe_opt.allSatisfy({$0 != ""}) || recipe_opt == []) ? Color.green : Color.gray)
                    .cornerRadius(25.0)
            }
            .allowsHitTesting(recipe_req.allSatisfy({$0 != ""}) && (recipe_opt.allSatisfy({$0 != ""}) || recipe_opt == []) ? true : false)
            Spacer()
        }
        
        .navigationTitle("Create Recipe")
    }
    
}
