import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
enum FlightStatus: String {
    case EnRoute
    case Scheduled
    case Cancelled
    case Delayed
    case Boarding

}

struct Airport {
    let Destination: String
    let Arrival: String

}


struct Flight {
    var destination: PopularDestinations
    var airline: Airlines
    var terminal: String?
    var departureDate: Date? = nil
    var flightStatus: FlightStatus

}

enum Airlines { //This was optional
    case American_Airlines_1709
    case Delta_Airlines_1542
    case AeroMexico_3020
    case United_1552
    case SouthWest_9874
    case Spirit_0098
}

enum PopularDestinations { //This was optional
    case Punta_Cana
    case Las_Vegas
    case Miami
    case Florida_Keys
    case New_York
    case Washington
    case Mexico_DF
}



class DepartureBoard {
    
    var airline: Airlines
    var destination: PopularDestinations
    var airportName: String
    var flightStatus: FlightStatus
    var myFlights = [Flight]()
    
    
    
    init(airline: Airlines, destination: PopularDestinations, airportName: String, flightStatus: FlightStatus) {
        
        self.airline = airline
        self.destination = destination
        self.airportName = airportName
        self.flightStatus = flightStatus
        self.myFlights = []
    }
}

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

func unwrapDate(dateToUnwrap: Optional<Date>) -> String {
    if let returnDate = dateToUnwrap {
        return returnDate.toString(dateFormat: "HH:mm")
    } else {
        return "TBD"
    }
}

func unwrapTerminal(terminalToUnwrap: Optional<String>) -> String {
    if let terminal = terminalToUnwrap {
        return terminal
    }else {
        return "TBD"
    }
}


func alertPassengers() {
    for departure in addFlight.myFlights {
        switch departure.flightStatus {
        case .Cancelled:
            print("We're sorry but your flight to \(PopularDestinations.Miami) has been cancelled, here is a $500 voucher")
        case .EnRoute:
            print("Your flight to \(PopularDestinations.New_York) is on time.")
        case .Scheduled:
            print("Your flight to \(PopularDestinations.Washington) is scheduled to depart at \(unwrapDate(dateToUnwrap: departure.departureDate))")
        case .Delayed:
            print("Your flight to \(PopularDestinations.Punta_Cana) has been Delayed.")
        case .Boarding:
            print("Your flight is borading, please head to terminal: \(departure.terminal) immediately. The doors are closing soon.")
        }
    }
}




//This is one of the steps to add a flight to the array [myFlights].

let addFlight = DepartureBoard(airline: .AeroMexico_3020, destination: .New_York, airportName: "TBD", flightStatus: .Scheduled)





                                //========================= End of Step 2 ================================
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
//Function to print (DepartureBoard:) class {}

func printDepartures(departureBoard: DepartureBoard) {
    for departure in departureBoard.myFlights {
        let date = unwrapDate(dateToUnwrap: departure.departureDate)
        let terminal = unwrapTerminal(terminalToUnwrap: departure.terminal)
        print(" (((-- Destination: \(departure.destination) -- Airline: \(departure.airline) -- Terminal: \(terminal) -- Departure Time: \(date) -- Flight Status: \(departure.flightStatus) --- )))")
        print(" -- Status En Route: \(FlightStatus.EnRoute.rawValue) -- Status Scheduled: \(FlightStatus.Scheduled) -- Status Cancelled: \(FlightStatus.Cancelled.rawValue) -- Status Delayed: \(FlightStatus.Delayed.rawValue)")
        
        
        
    }
}

printDepartures(departureBoard: addFlight)








//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:

var nyFlight = Flight(destination: .New_York, airline: .SouthWest_9874, terminal: "TBD", departureDate: Date(), flightStatus: .EnRoute)
var dominicanRepFlight = Flight(destination: .Punta_Cana, airline: .United_1552, terminal: "Santo Domingo", departureDate: Date(), flightStatus: .Delayed)
var miamiFlight = Flight(destination: .Miami, airline: .Spirit_0098, terminal: "TBD", departureDate: nil, flightStatus: .Cancelled)
var washingtonFlight = Flight(destination: .Washington, airline: .Spirit_0098, terminal: nil, departureDate: Date(), flightStatus: .Scheduled)
var mexicoFlight = Flight(destination: .Mexico_DF, airline: .AeroMexico_3020, terminal: "TBD", departureDate: Date(), flightStatus: .Scheduled)

//This is how the flights created above are being added to the array.
addFlight.myFlights.append(nyFlight)
addFlight.myFlights.append(dominicanRepFlight)
addFlight.myFlights.append(miamiFlight)
addFlight.myFlights.append(washingtonFlight)

//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDepartures2(departureBoard: DepartureBoard) {
    for departure2 in departureBoard.myFlights {
        let date = unwrapDate(dateToUnwrap: departure2.departureDate)
        let terminal = unwrapTerminal(terminalToUnwrap: departure2.terminal)
        print(" (((-- Destination: \(departure2.destination) -- Airline: \(departure2.airline) -- Terminal: \(terminal) -- Departure Time: \(date) -- Flight Status: \(departure2.flightStatus) --- )))")
    
    }
}
printDepartures2(departureBoard: addFlight)


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.
alertPassengers()
//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func totalfarePrice(checkedBags: Double, miles: Double, travelers: Double) -> Double {
    let bagPrice = 25.0
    let eachmile = 0.10
    let totalBags = (bagPrice * checkedBags)
    let totalMiles = (miles * eachmile)
    let totalFare = (totalBags + totalMiles) * travelers
    return totalFare
}

print("The total fare is: $\(totalfarePrice(checkedBags: 2, miles: 10, travelers: 2)).")





