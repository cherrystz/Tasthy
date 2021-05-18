import Foundation
import SwiftUI
import CoreData

// Setup Image Extension
extension Image {
    public init(name:String) {
        self.init(uiImage: #imageLiteral(resourceName: name))
    }
}

public let colorBackground: [UIColor] = [
    .init(red: 153/255, green: 211/255, blue: 159/255, alpha: 1),
    .init(red: 158/255, green: 219/255, blue: 223/255, alpha: 1),
    .init(red: 228/255, green: 220/255, blue: 145/255, alpha: 1),
    .init(red: 234/255, green: 158/255, blue: 190/255, alpha: 1)
]

// Setup Core data
public func createMainContext() -> NSManagedObjectContext {
    
    let modelUrl = Bundle.main.url(forResource: "Tasthy", withExtension: "momd")
    guard let model = NSManagedObjectModel.init(contentsOf: modelUrl!) else { fatalError("model not found") }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    try! psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: modelUrl!, options: nil)
    
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}

public let context = createMainContext()

public func basedData() {
    
    let Menu_name: [String] = ["Pad Kra Prao","Green Curry","Clear Soup"]
    let Menu_image: [String] = ["pad-kraprao","green-curry","clear-soup"]
    let Item_name_req: [[String]] = [
        [
            "Minced Pork 200g",
            "Garlic 1-2 pcs",
            "Oil 1 tbsp",
            "Oyster Sauce 2 tbsp",
            "Soy sauce 1 tbsp",
            "A handful of Holy Basil"
        ],[
            "grams of sliced chicken breast or thighs",
            "green curry paste",
            "sunflower oil",
            "Coconut milk",
            "soy sauce",
            "oyster sauce",
            "fish sauce",
            "Thai basil leaves",
            "Thai eggplants",
            "Thai chili (fresh)",
            "Kaffir lime leaves"
        ],[
            "piece Galangal",
            "Lemon Grass",
            "Lime Leaves",
            "Water",
            "vegetables",
            "diced steamed carrot",
            "steamed green peas",
            "Tofu, diced"
        ]
    ]
    let Item_name_opt: [[String]] = [
        [
            "Chili pepper 9 pcs",
            "Water 1 tbsp",
            "Sugar 1 tsp",
            "Black Soy Sauce 1/2 tsp"
        ],[
            "sugar",
            "water"
        ],[
            "Veggie stock cube",
            "teaspoon Salt"
        ],
    ]
    let Process: [[String]] = [
        [
            "Pound the garlic and chili until coarsely.",
            "Heat the pan on almost high heat and add oil to it.",
            "Add the rest of the seasoning and stir for 45 seconds.",
            "Add basil leaves into the pan. And turn off the fire."
        ],[
            "Put Thai Green Curry paste, Coconut Milk in pot",
            "Boil a 3 minutes, for combine",
            "Put chicken and vegetables in pot",
            "Combine with stir for 45 seconds and turn off the fire"
        ],[
            "Crush and roughly chop the ingredients for the broth.",
            "Pressure boil the broth ingredients in 2 cups of water.",
            "Cook for 2 whistles on medium flame.",
            "Strain the broth and set aside.",
            "Serve hot!"
        ]
    ]
    
    var ent_menu: [NSManagedObject] = []
    var ent_item: [NSManagedObject] = []
    var ent_step: [NSManagedObject] = []
    
    for index in 0..<3 {
        ent_menu.append(NSEntityDescription.insertNewObject(forEntityName: "Menu", into: context))
        ent_menu[index].setValue(index+1, forKey: "id")
        ent_menu[index].setValue(Menu_image[index], forKey: "image")
        ent_menu[index].setValue(Menu_name[index], forKey: "name")
    }
    
    for index in 0..<3 {
        for item in Item_name_req[index] {
            ent_item.append(NSEntityDescription.insertNewObject(forEntityName: "Item", into: context))
            ent_item[ent_item.count-1].setValue(item, forKey: "item_name")
            ent_item[ent_item.count-1].setValue(index+1, forKey: "menu_id")
            ent_item[ent_item.count-1].setValue(true, forKey: "req")
        }
        for item in Item_name_opt[index] {
            ent_item.append(NSEntityDescription.insertNewObject(forEntityName: "Item", into: context))
            ent_item[ent_item.count-1].setValue(item, forKey: "item_name")
            ent_item[ent_item.count-1].setValue(index+1, forKey: "menu_id")
            ent_item[ent_item.count-1].setValue(false, forKey: "req")
        }
    }
    
    for index in 0..<3 {
        for step in 0..<Process[index].count {
            ent_step.append(NSEntityDescription.insertNewObject(forEntityName: "Process", into: context))
            ent_step[ent_step.count-1].setValue(index+1, forKey: "menu_id")
            ent_step[ent_step.count-1].setValue(step+1, forKey: "level")
            ent_step[ent_step.count-1].setValue(Process[index][step], forKey: "desc")
        }
    }
    
    try! context.save()
}

public func addMenu(name: String, recipe_req: [String], recipe_opt: [String], step: [String]) {
    
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Menu")
    let result = try! context.fetch(fr) as! [NSManagedObject]
    let db_id = result.map { $0.value(forKey: "id")! } as! [Int]
    
    let max = db_id.max()!
    
    let ent_menu = NSEntityDescription.insertNewObject(forEntityName: "Menu", into: context)
    ent_menu.setValue(max+1, forKey: "id")
    ent_menu.setValue("food-default", forKey: "image")
    ent_menu.setValue(name, forKey: "name")
    
    var ent_item: [NSManagedObject] = []
    var ent_step: [NSManagedObject] = []
    
    for req in recipe_req {
        ent_item.append(NSEntityDescription.insertNewObject(forEntityName: "Item", into: context))
        ent_item[ent_item.count-1].setValue(req, forKey: "item_name")
        ent_item[ent_item.count-1].setValue(4, forKey: "menu_id")
        ent_item[ent_item.count-1].setValue(true, forKey: "req")
    }
    
    for opt in recipe_opt {
        ent_item.append(NSEntityDescription.insertNewObject(forEntityName: "Item", into: context))
        ent_item[ent_item.count-1].setValue(opt, forKey: "item_name")
        ent_item[ent_item.count-1].setValue(4, forKey: "menu_id")
        ent_item[ent_item.count-1].setValue(false, forKey: "req")
    }
    
    for process in 0..<step.count {
        ent_step.append(NSEntityDescription.insertNewObject(forEntityName: "Process", into: context))
        ent_step[ent_step.count-1].setValue(4, forKey: "menu_id")
        ent_step[ent_step.count-1].setValue(process+1, forKey: "level")
        ent_step[ent_step.count-1].setValue(step[process], forKey: "desc")
    }
    
    try! context.save()
}

public func fetchMenu() -> [Int:[String]] {
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Menu")
    let result = try! context.fetch(fr) as! [NSManagedObject]
    let db_id = result.map { $0.value(forKey: "id")! } as! [Int]
    let db_name = result.map { $0.value(forKey: "name")! } as! [String]
    let db_image = result.map { $0.value(forKey: "image")! } as! [String]
    var value = [Int:[String]]()
    
    for index in 0..<result.count {
        value[db_id[index]] = [db_name[index],db_image[index]]
    }
    
    return value
}

public func fetchItem(id: Int) -> [[String]] {
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
    let result = try! context.fetch(fr) as! [NSManagedObject]
    let db_id = result.map { $0.value(forKey: "menu_id")! } as! [Int]
    let db_name = result.map { $0.value(forKey: "item_name")! } as! [String]
    let db_req = result.map { $0.value(forKey: "req")! } as! [Bool]
    var value: [[String]] = [[],[]]

    for index in 0..<result.count {
        if db_id[index] == id {
            if db_req[index] {
                value[0].append(db_name[index])
            }
            else {
                value[1].append(db_name[index])
            }
        }
    }
    return value
}

public func fetchProcess(id: Int) -> [String] {
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Process")
    let result = try! context.fetch(fr) as! [NSManagedObject]
    let db_id = result.map { $0.value(forKey: "menu_id")! } as! [Int]
    let db_desc = result.map { $0.value(forKey: "desc")! } as! [String]
    let db_level = result.map { $0.value(forKey: "level")! } as! [Int]
    var data: [String] = []
    var level: [Int] = []
    var value: [String] = []

    for index in 0..<result.count {
        if db_id[index] == id {
            data.append(db_desc[index])
            level.append(db_level[index])
        }
    }
    
    for index in 0..<level.count {
        value.append(data[level.firstIndex(of: index+1)!])
    }
    
    return value
}

