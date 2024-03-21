//
//  File.swift
//  
//
//  Created by User on 21/03/24.
//

import Foundation

struct Status: Encodable, Decodable {
    var fome: Int = 100
    var saude: Int = 100
    var felicidade: Int = 100
}

struct Buddy: Encodable, Decodable {
    var nomeBuddy: String? = nil
    let tipo: String
    let especie: String
    var xp: Int = 10
    var level: Int = 1
    var status: Status = Status()
}

var pikachu: Buddy = Buddy(tipo: "Elétrico", especie: "Pikachu")

var charmander: Buddy = Buddy(tipo: "Fogo", especie: "charmander", status: Status(fome: 10))

var squirtle: Buddy = Buddy(tipo: "Agua", especie: "squirtle")

var bulbasaur: Buddy = Buddy(tipo: "Planta", especie: "bulbasaur")

var pokemons:[Buddy] = [pikachu, charmander, squirtle, bulbasaur]

func showPokemons(buddy: Int){
    switch buddy{
        case 1: showCharmander();
        case 2: showSquirtle();
        case 3: showBulbassaur();
    default: print("")
    }
}

func aumentarFelicidade(){
    var buddy = readData(fileURL)!
    if buddy.status.felicidade > 101 || buddy.status.felicidade <= 0 {
        return
    }
    
    buddy.status.felicidade += 25
    
    saveData(fileURL, buddy: buddy)
}


func diminuirFelicidade(){
    var buddy = readData(fileURL)!
    
    buddy.status.felicidade -= 10
    
    saveData(fileURL, buddy: buddy)
}

func aumentarFome(){
    var buddy = readData(fileURL)!
    if buddy.status.fome > 101 || buddy.status.fome <= 0 {
        return
    }
    buddy.status.fome += 10
    
    saveData(fileURL, buddy: buddy)
}

func diminuirFome(){
    var buddy = readData(fileURL)!
    if buddy.status.fome > 101 || buddy.status.fome <= 0 {
        return
    }
    buddy.status.fome -= 25
    
    saveData(fileURL, buddy: buddy)
}

func aumentarSaude(){
    var buddy = readData(fileURL)!
    
    buddy.status.saude = 100
    
    saveData(fileURL, buddy: buddy)
}

func diminuirSaude(points: Int){
    var buddy = readData(fileURL)!
    
    if buddy.status.saude > 101 || buddy.status.saude <= 0 {
        return
    }
    
    buddy.status.saude -= points
    
    saveData(fileURL, buddy: buddy)
}
