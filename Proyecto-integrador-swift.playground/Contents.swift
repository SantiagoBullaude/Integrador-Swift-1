/*
 Proyecto Integrador 1
 Autores:
    -Santiago Bullaude
    -Valeria Malbran
    -Dessiree Sanchez
 */

import UIKit

struct Parking {
    var vehicles: Set<Vehicle> = []
    private let maxVehicles = 20
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard vehicles.count < maxVehicles else {
            onFinish(false) // no hay puesto disponible
            return //corta la ejecucion si es mayor a 20
        }
        
        guard vehicles.filter( { $0.plate == vehicle.plate}).isEmpty else {
            onFinish(false) // no se puede ingresar vehiculo con la patente repetida
            return
        }
        
        vehicles.insert(vehicle)
        onFinish(true)
    }
    
    mutating func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
        guard let vehicle = vehicles.filter({ $0.plate == plate }).first else {
            onError()
            return
        }
        
        vehicles.remove(vehicle)
        let totalToPay = calculateFee(type: vehicle.type, parkedTime: vehicle.parkedTime, hasDiscountCard: true)
        onSuccess(totalToPay)
    }

    mutating func calculateFee(type: VehicleType, parkedTime: Int, hasDiscountCard: Bool) -> Int {
        var totalToPay = type.hourValue
        
        if parkedTime > 120 { // mas de 2 horas (120 minutos)
            let extra = (parkedTime - 120) / 15
            totalToPay = totalToPay + Int(ceil(Double((extra * 5)) / 1.15))
            
            
        }
        
        if hasDiscountCard {
            
        }

        return totalToPay
    }
    
}


protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInDate: Date {get}
    var discountCard : String? {get}
    var parkedTime: Int {get}
//    func checkOutVehicle(plate: String, onSuccess: (Int) -> Void, onError: () -> Void)

    
}

struct Vehicle: Parkable, Hashable {

    let plate: String
    let type: VehicleType
    let checkInDate: Date //Deberiamos cambiarla a checkInTime?
    let discountCard : String?
    
    var parkedTime: Int { Calendar.current.dateComponents([.minute], from:checkInDate, to: Date()).minute ?? 0
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func == (lhs:Vehicle,rhs:Vehicle)->Bool{
        return lhs.plate == rhs.plate
    }
    
    
    
}



enum VehicleType {
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
let auto = Vehicle(plate: "AA111AC", type: VehicleType.auto, checkInDate: Date(), discountCard: "Discoun_Card_001")

let moto = Vehicle(plate: "B222BbB", type: VehicleType.moto, checkInDate: Date(), discountCard: nil)

let miniBus = Vehicle(plate: "CC333CB", type: VehicleType.miniBus, checkInDate: Date(), discountCard: nil)

let bus = Vehicle(plate: "DD44DF", type: VehicleType.bus, checkInDate: Date(), discountCard: "Discoun_Card_002")


let auto2 = Vehicle(plate: "AA21112AG", type: VehicleType.auto, checkInDate: Date(), discountCard: "Discoun_Card_002")
//inserto en Array
alkeParkin.vehicles.insert(auto)

alkeParkin.vehicles.insert(moto)

alkeParkin.vehicles.insert(miniBus)

alkeParkin.vehicles.insert(bus)

//var parking = Parking()
//parking.checkInVehicle(bus) { finish in
//    print(finish)
//}
//
//print(parking.vehicles.count)


// Instancia de vehiculos
let vehicle1 = Vehicle(plate: "AA111AA", type: VehicleType.auto, checkInDate: Date(),                              discountCard:"DISCOUNT_CARD_001")

let vehicle2 = Vehicle(plate: "B222BBB", type:
                       VehicleType.moto, checkInDate: Date(), discountCard: nil)

let vehicle3 = Vehicle(plate: "CC333CC", type:VehicleType.miniBus, checkInDate: Date(),    discountCard:nil)

let vehicle4 = Vehicle(plate: "DD444DD",
                       type: VehicleType.bus,
                       checkInDate: Date(),
                       discountCard: "DISCOUNT_CARD_002")

let vehicle5 = Vehicle(plate: "AA111BB",
                       type: VehicleType.auto,
                       checkInDate: Date(),
                       discountCard: "DISCOUNT_CARD_003")

let vehicle6 = Vehicle(plate: "B222CCC",
                       type: .moto,
                       checkInDate: Date(),
                       discountCard: "DISCOUNT_CARD_004")

let vehicle7 = Vehicle(plate: "CC333DD",
                       type: .miniBus,
                       checkInDate: Date(),
                       discountCard: nil)

let vehicle8 = Vehicle(plate: "DD444EE",
                       type: .bus,
                       checkInDate: Date(),
                       discountCard: "DISCOUNT_CARD_005")

let vehicle9 = Vehicle(plate: "AA111CC",
                       type: .auto,
                       checkInDate: Date(),
                       discountCard: nil)

let vehicle10 = Vehicle(plate: "B222DDD",
                        type: .moto,
                        checkInDate: Date(),
                        discountCard: nil)

let vehicle11 = Vehicle(plate: "CC333EE",
                        type: .miniBus,
                        checkInDate: Date(),
                        discountCard: nil)

let vehicle12 = Vehicle(plate: "DD444GG",
                        type: .bus,
                        checkInDate: Date(),
                        discountCard: "DISCOUNT_CARD_006")

let vehicle13 = Vehicle(plate: "AA111DD",
                        type: .auto,
                        checkInDate: Date(),
                        discountCard: "DISCOUNT_CARD_007")

let vehicle14 = Vehicle(plate: "B222EEE",
                        type: .moto,
                        checkInDate: Date(),
                        discountCard: nil)

let vehicle15 = Vehicle(plate: "CC333FF",
                        type: .miniBus,
                        checkInDate: Date(),
                        discountCard: nil)

let vehicle16 = Vehicle(plate: "CC444FF",
                        type: .miniBus,
                        checkInDate: Date(),
                        discountCard: nil)

let vehicle17 = Vehicle(plate: "CC555FF",
                        type: .bus,
                        checkInDate: Date(),
                        discountCard: nil)

let arrayOfVehicles = [vehicle1, vehicle2, vehicle3, vehicle4, vehicle5, vehicle6, vehicle7, vehicle8, vehicle9, vehicle10, vehicle11, vehicle12, vehicle13, vehicle14, vehicle15, vehicle16, vehicle17]

arrayOfVehicles.forEach { vehicle in
    alkeParkin.checkInVehicle(vehicle) { registered in
        if registered {
            print("Welcome to AlkeParking!")
        } else {
            print("Sorry, the check-in failed")
        }
    }
}

print(alkeParkin.vehicles.count)

//for vehicle in arrayOfVehicles {
//    alkeParkin.checkInVehicle(vehicle) { registered in
//        if registered {
//            print("Welcome to AlkeParking!")
//        } else {
//            print("Sorry, the check-in failed")
//        }
//    }
//}


print("El valor total a pagar es: \(alkeParkin.calculateFee(type: .moto, parkedTime: 30, hasDiscountCard: true))")



