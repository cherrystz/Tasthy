import SwiftUI
import CoreData
import PlaygroundSupport

public struct Complete: View {
    
    @State var emotional: String = ""
    
    public var body: some View {
        Color(red: 118/255, green: 175/255, blue: 188/255)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .center, spacing: 30.0){
                    Text("Do you think your food is delicious?")
                    
                    HStack(alignment: .center, spacing: 15.0){
                        Button(action: {
                            emotional = "Awful"
                        }){
                            Image(uiImage: UIImage(named: "angry.png")!)
                        }
                        Button(action: {
                            emotional = "Not bad"
                        }){
                            Image(uiImage: UIImage(named: "neutural.png")!)
                        }
                        Button(action: {
                            emotional = "Delicious"
                        }){
                            Image(uiImage: UIImage(named: "delicious.png")!)
                        }
                    }
                    
                    Text(emotional)
                    
                    Button(action: {
                        hosted()
                    }, label: {
                        Text("Back")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 250.0, height: 50.0, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(25.0)
                    })
                    
                }
            )
            
            .navigationBarHidden(true)
    }
}

public func hosted() {
    let host = UIHostingController(rootView: MenuView())
    host.preferredContentSize = CGSize(width: 414  , height: 896)
    PlaygroundPage.current.liveView = host
}
