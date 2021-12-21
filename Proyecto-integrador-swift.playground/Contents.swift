

import UIKit

struct Parking{
    var vehicles: Set<Vehicle> = []
}

protocol  Parkable{
    var plate: String { get }
    var type: VehicleType { get }
    var checkInDate: Date {get}
    var discountCard : String? {get}
    var parkedTime: Int {get}
    
    
}

struct Vehicle :Parkable, Hashable{
    
    let plate:String
    let type: VehicleType
    let checkInDate: Date
    let discountCard : String?
    
    var parkedTime :Int{Calendar.current.dateComponents([.minute], from:checkInDate, to: Date()).minute ?? 0
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs:Vehicle,rhs:Vehicle)->Bool{
        return lhs.plate == rhs.plate
    }
}

enum VehicleType{
    case auto, moto, miniBus, bus
    
    var hourValue : Int{
        
        switch self {
            
            case .auto: return 20
            
            case .moto:return 15
            
            case .miniBus: return 25
    
            case .bus: return 30
            
        }
      
    }
    
}

var alkeParkin = Parking()


//Creo objetos
let auto = Vehicle(plate: "AA111AA", type: VehicleType.auto, checkInDate: Date(), discountCard: "Discoun_Card_001")

let moto = Vehicle(plate: "B222BbB", type: VehicleType.moto, checkInDate: Date(), discountCard: nil)

let miniBus = Vehicle(plate: "CC333CC", type: VehicleType.miniBus, checkInDate: Date(), discountCard: nil)

let bus = Vehicle(plate: "DD44DD", type: VehicleType.bus, checkInDate: Date(), discountCard: "Discoun_Card_002")


let auto2 = Vehicle(plate: "AA21112AA", type: VehicleType.auto, checkInDate: Date(), discountCard: "Discoun_Card_002")
//inserto en Array
alkeParkin.vehicles.insert(auto)

alkeParkin.vehicles.insert(moto)

alkeParkin.vehicles.insert(miniBus)

alkeParkin.vehicles.insert(bus)


