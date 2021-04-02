//
//  main.swift
//  iOS3-Berresheim-Englisch
//
//  Created by Kenneth Englisch on 11.11.20.
//

import Foundation

let filePath = "book.plist"

var addressBook = AddressBook.addressBook(fromFile: filePath)

if addressBook ==  nil{
    addressBook = AddressBook()
}

userPrompt()

func userPrompt(){
    let input = read(withPrompt: "(E)ingabe, (S)uche, (L)iste oder (Q)uit?")
    
    switch input.lowercased() {
    case "e":
        insertToAddressBook()
        userPrompt()
    case "s":
        searchInAddressBook()
    case "l":
        printAddressBook()
        userPrompt()
    case "q":
        addressBook!.save(toFile: filePath)
        exit(0)
    default:
        print(".!. Falscher Input, versuchs nochmal .!.")
        userPrompt()
    }
}

func insertToAddressBook(){
    let firstname = read(withPrompt: "Vorname: ")
    let lastname = read(withPrompt: "Nachname: ")
    let streetAndNumber = read(withPrompt: "Straße + Hausnummer: ")
    let zipcode = Int(read(withPrompt: "Postleitzahl: ")) ?? 0
    let city = read(withPrompt: "Ort: ")
    let hobbies = readHobby(withPrompt: "Hobby(s): (Abbruch mit (Q)) ")
    
    let addressCard = AddressCard(firstname: firstname, lastname: lastname, streetAndNumber: streetAndNumber, zipcode: zipcode, city: city, hobbies: hobbies)
    
    addressBook?.add(card: addressCard)
    addressBook?.sortAddressCards()
}

func searchInAddressBook(){
    let input = read(withPrompt: "Nachname: ")
    
    let results = addressBook?.searchAddressCard(lastname: input)

    let result = results?.first
    result?.print()
    
    if(result != nil){
        userSearchedPrompt(user: result!)
    }
    else{
        print("... Es wurde keine Person mit diesem Namen gefunden.")
        userPrompt()
    }
}

func userSearchedPrompt(user: AddressCard){
    let input = read(withPrompt: "(F)reund/in hinzufügen, (L)öschen oder (Z)urück?").lowercased()
    
    switch input {
    case "f":
        let friendName = read(withPrompt: "Name Freund/in: ")
        let contact = addressBook?.searchAddressCard(lastname: friendName)?.first
        if contact != nil{
            user.add(friend: contact!)
            print("'" + contact!.firstname + " " + contact!.lastname + "' hinzugefügt.")
        } else {
            print("... Es wurde keine Person mit diesem Namen gefunden.")
        }
        userSearchedPrompt(user: user)
    case "l":
        addressBook?.remove(card: user)
        print("'" + user.firstname + " " + user.lastname + "' gelöscht.")
        userPrompt()
    case "z":
        userPrompt()
    default:
        print(".!. Falscher Input, versuchs nochmal .!.")
        userSearchedPrompt(user: user)
    }
}

func read(withPrompt: String) -> String{
    var temp = ""
    
    print(withPrompt)
    
    if let input = readLine(){
        temp = String(input)
    }
    
    return temp
}

func readHobby(withPrompt: String) -> [String]{
    var hobby = ""
    var hobbyArray: [String] = []
    
    print(withPrompt)
    
    if var input = readLine(){
        while input.lowercased() != "q" {
            hobby = String(input)
            hobbyArray.append(hobby)
            input = readLine()!
        }
    }
    return hobbyArray
}

func printAddressBook(){
    if let addressCards = addressBook?.addressCards{
        for addressCard in addressCards{
            addressCard.print()
        }
    }
    
}
