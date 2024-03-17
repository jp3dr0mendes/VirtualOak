//
//  File.swift
//  
//
//  Created by User on 14/03/24.
//

import Foundation

struct Status{
    var fome: Int = 100
    var saude: Int = 100
    var felicidade: Int = 100
}

struct Buddy {
    var nomeBuddy: String? = nil
    let tipo: String
    let especie: String
    var xp: Int = 10
    var level: Int = 1
    var status: Status = Status()
}

//struct Treinador {
//    //resto dos dados
//}

var pikachu: Buddy = Buddy(tipo: "Elétrico", especie: "Pikachu")

var charmander: Buddy = Buddy(tipo: "Fogo", especie: "charmander", status: Status(fome: 10))

var squirtle: Buddy = Buddy(tipo: "Agua", especie: "squirtle")

var bulbasaur: Buddy = Buddy(tipo: "Planta", especie: "bulbasaur")

let pokemons:[Buddy] = [pikachu, charmander, squirtle, bulbasaur]

func showPokemons(buddy: Int){
    switch buddy{
        case 1: showCharmander();
        case 2: showSquirtle();
        case 3: showBulbassaur();
    default: print("")
    }
}

func criarBasedeDados(conteudo: String, filePath: String) {
    let fileManager = FileManager.default
    
    if let data = conteudo.data(using: .utf8) {
        let success = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        if success {
            print("File created and data written successfully.")
        } else {
            print("Failed to create file.")
        }
    } else {
        print("Failed to convert string to data.")
    }
}

// Chamando a função para criar um arquivo de texto

/*

func criarBancoDeDados(data: Buddy, filePath: String) {
    let jdonEncoder = JSONEncoder()

    jsonEncoder.outputFormatting = .prettyPrinted

    do {
        let jsonData = try jsonEncoder.encode(data)

        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsURL.appendingPathComponent(filePath)

        try jsonData.write(to: fileURL)
        print("Sua jornada começou!!")
    } catch {
        print("Error!")
    }
}

*/