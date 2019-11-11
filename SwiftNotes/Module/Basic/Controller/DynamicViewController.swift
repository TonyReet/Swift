//
//  DynamicViewController.swift
//  SwiftNotes
//
//  Created by TonyReet on 2019/11/8.
//  Copyright © 2019 TonyReet. All rights reserved.
//

import UIKit

class DynamicViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        printPet(Cat()) // Meow
        printPet(Dog()) // Bark
        printPet(Pet()) // Pet
        
        printThem(Dog(), Cat())//Pet,Meow
        
        printThemType(Dog(), Cat())//Bark,Meow
    }
    
    func printThem(_ pet: Pet, _ cat: Cat) {
        printPet(pet)
        printPet(cat)
    }
    
    func printThemType(_ pet: Pet, _ cat: Cat) {
        if let aCat = pet as? Cat {
            printPet(aCat)
        } else if let aDog = pet as? Dog {
            printPet(aDog)
        }
        printPet(cat)
    }
    
    func printPet(_ pet: Pet) {
        print(debug: "Pet")
    }

    func printPet(_ cat: Cat) {
        print(debug: "Cat")
    }

    func printPet(_ dog: Dog) {
        print(debug: "Dog")
    }
}

class Pet {}
class Cat: Pet {}
class Dog: Pet {}


