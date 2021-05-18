import SwiftUI
import CoreData

public struct StepCooking: View {
    
    var menu_id: Int = 0
    var count: Int = 0
    var contain: String = ""
    
    public var body: some View {
            Color(colorBackground.randomElement()!)
                .ignoresSafeArea()
                .overlay(

                    VStack(alignment: .center, spacing: 15.0) {
                        
                        
                        if fetchProcess(id: menu_id)[count-1].contains("stir") {
                            GIFView(gifName: "stir")
                                .frame(width: 230.0, height: 230.0, alignment: .center)
                        }
                        else if fetchProcess(id: menu_id)[count-1].contains("boil") {
                            GIFView(gifName: "boil")
                                .frame(width: 230.0, height: 230.0, alignment: .center)
                        }
                        else if fetchProcess(id: menu_id)[count-1].contains("pan") || fetchProcess(id: menu_id)[count-1].contains("grill") {
                            GIFView(gifName: "grill")
                                .frame(width: 230.0, height: 230.0, alignment: .center)
                        }
                        else {
                            GIFView(gifName: "ingredients")
                                .frame(width: 230.0, height: 230.0, alignment: .center)
                        }
                        
                        Text(fetchProcess(id: menu_id)[count-1])
                            .frame(width: 250.0, alignment: .center)
                        
                        if count != fetchProcess(id: menu_id).count {
                            NavigationLink(destination: StepCooking(
                                            menu_id: menu_id,
                                            count: count+1
                                )) {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 250.0, height: 50.0, alignment: .center)
                                    .background(Color.green)
                                    .cornerRadius(25.0)
                            }
                        }
                        else {
                            NavigationLink(destination: Complete()) {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 250.0, height: 50.0, alignment: .center)
                                    .background(Color.green)
                                    .cornerRadius(25.0)
                            }
                        }
                    
                    
                }
            )
        .navigationTitle("STEP \(count)")
        
    }
}

