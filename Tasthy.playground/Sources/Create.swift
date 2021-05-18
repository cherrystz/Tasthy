import CoreData
import SwiftUI

public struct Create: View {
    @State private var name: String = ""
    @State private var req = 3
    @State private var opt = 1
    @State private var step = 3
    
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    public var body: some View {
        HStack(alignment: .top){
            VStack{
                
                VStack {
                    Image(name: "food-default.jpg")
                        .resizable()
                        .frame(width: 200.0, height: 165.0)
                }
                
                HStack {
                    Text("Menu name: ")
                    TextField(" Tom yum kung", text: $name)
                        .border(Color.init(red: 0.7, green: 0.7, blue: 0.7))
                        .frame(width: 200, alignment: .center)
                }
                VStack {
                    Stepper("Recipe Require (\(req))", value: $req, in: 3...15)
                    Stepper("Recipe Optional (\(opt))", value: $opt, in: 1...15)
                    Stepper("Step Cook (\(step))", value: $step, in: 3...15)
                }
                .frame(width: 250, alignment: .center)
                NavigationLink(destination: RecipeCreate(
                    name: name,
                    req: req,
                    opt: opt,
                    step: step,
                    recipe_req: Array(repeating: "", count: req),
                    recipe_opt: opt > 0 ? Array(repeating: "", count: opt) : []
                )) {
                    Text("Next")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 250.0, height: 50.0, alignment: .center)
                        .background(name != "" ? Color.green : Color.gray)
                        .cornerRadius(25.0)
                }
                .allowsHitTesting(name != "" ? true : false)
            }
        }
        
        .navigationTitle("Create " + (name == "" ? "Menu" : name))
    }
    
}

