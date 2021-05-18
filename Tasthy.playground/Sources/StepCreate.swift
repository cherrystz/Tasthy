import CoreData
import SwiftUI
import PlaygroundSupport

public struct StepCreate: View {
    
    @State var name: String = ""
    
    @State var recipe_req: [String] = []
    @State var recipe_opt: [String] = []
    @State var step_name: [String] = []
    @State private var showingAlert = false
    
    public var body: some View {
        VStack(spacing: 5.0){
            Text("\(name)'s Step Process")
            
            
            // Req List
            HStack(spacing:0.0) {
                Text("Process")
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
                ForEach(1...step_name.count, id: \.self) { x in
                    HStack {
                        Text("\(x):  ")
                        TextField("Step \(x)", text: $step_name[x-1])
                            .border(Color.init(red: 0.7, green: 0.7, blue: 0.7))
                            .frame(width: 300, alignment: .center)
                    }
                }
            }
            .frame(height: 200.0, alignment: .center)
            
            Button(action: {
                showingAlert = true
            }, label: {
                Text("Complete")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 250.0, height: 50.0, alignment: .center)
                    .background(step_name.allSatisfy({$0 != ""}) ? Color.green : Color.gray)
                    .cornerRadius(25.0)
            })
            .allowsHitTesting(step_name.allSatisfy({$0 != ""}) ? true : false)
            
            Spacer()
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(
                title: Text("Create Menu"),
                message: Text("Are you sure to create \(name)?"),
                primaryButton: .default(
                    Text("Sure"),
                    action: {
                        addMenu(name: name, recipe_req: recipe_req, recipe_opt: recipe_opt, step: step_name)
                        hostedToRoot()
                    }
                ), secondaryButton: .destructive(
                    Text("Delete")
                ))
        })
        
        .navigationTitle("Create Step Cooking")
    }
    
}

public func hostedToRoot() {
    let host = UIHostingController(rootView: MenuView())
    host.preferredContentSize = CGSize(width: 414  , height: 896)
    PlaygroundPage.current.liveView = host
}
