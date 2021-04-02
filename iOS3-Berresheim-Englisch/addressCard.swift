//
//  adressCard.swift
//  iOS3-Berresheim-Englisch
//
//  Created by Kenneth Englisch on 11.11.20.
//

import Foundation

class AddressCard: Codable, Equatable {
    static func == (lhs: AddressCard, rhs: AddressCard) -> Bool {
        return lhs.firstname == rhs.firstname
    }
    
    let firstname: String
    var lastname: String
    
    var streetAndNumber: String
    var zipcode: Int
    var city: String
    
    var hobbies: [String] = []
    var friends: [AddressCard] = []
    
    init(firstname: String, lastname: String, streetAndNumber: String, zipcode: Int, city: String, hobbies: [String]) {
        
        self.firstname = firstname
        self.lastname = lastname
        self.streetAndNumber = streetAndNumber
        self.zipcode = zipcode
        self.city = city
        self.hobbies = hobbies
    }
    
    func add(hobby: String){
        hobbies.append(hobby)
    }
    
    func remove(hobby: String){
        if let temp = hobbies.firstIndex(of: hobby) {
            hobbies.remove(at: temp)
        }
    }
    
    func add(friend: AddressCard){
        friends.append(friend)
    }
    
    func remove(friend: AddressCard){
        if let temp = friends.firstIndex(of: friend) {
            friends.remove(at: temp)
        }
    }
    
    func print(){
        Swift.print("+-----------------------------------")
        Swift.print("| " + firstname + " " + lastname)
        Swift.print("| " + streetAndNumber)
        Swift.print("| " + String(zipcode) + " " + city)
        Swift.print("| Hobbys: ")
            for hobby in hobbies{
                Swift.print("|   " + hobby)
            }
        Swift.print("| Freunde: ")
            for friend in friends{
                Swift.print("|   " + friend.firstname + " " + friend.lastname + ", " + String(friend.zipcode) + " " + friend.city)
            }
        Swift.print("+-----------------------------------")
    }
}
