//
//  addressBook.swift
//  iOS3-Berresheim-Englisch
//
//  Created by Kenneth Englisch on 11.11.20.
//

import Foundation

class AddressBook: Codable {
    var addressCards: [AddressCard] = []
    
    func add(card: AddressCard){
        addressCards.append(card)
    }
    
    func remove(card: AddressCard){
        if let temp = addressCards.firstIndex(of: card){
            addressCards.remove(at: temp)
            
            for adressCard in addressCards {
                adressCard.remove(friend: card)
            }
        }
    }
    
    func sortAddressCards(){
        addressCards.sort(by: { ( s1: AddressCard, s2: AddressCard ) -> Bool in return s1.lastname < s2.lastname})
    }
    
    func searchAddressCard(lastname: String) -> [AddressCard]?{
        var matchingCards: [AddressCard] = []
        
        for addressCard in addressCards{
            if addressCard.lastname == lastname {
                matchingCards.append(addressCard)
            }
        }
        
        return matchingCards
    }
    
    func save(toFile path: String){
        let url = URL(fileURLWithPath: path)
        
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(self){
            try? data.write(to: url)
        }
    }
    
    class func addressBook(fromFile path: String) -> AddressBook?{
        let url = URL(fileURLWithPath: path)
    
        if let data = try? Data(contentsOf: url){
            let decoder = PropertyListDecoder()
            if let addressBook = try? decoder.decode(AddressBook.self, from: data){
                return addressBook
            }
        }
        
        return nil
    }
}
