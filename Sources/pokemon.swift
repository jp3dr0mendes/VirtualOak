//
//  File.swift
//  
//
//  Created by User on 21/03/24.
//

import Foundation

struct Status: Codable {
    var fome: Int = 10
    var saude: Int = 100
    var felicidade: Int = 100
}

struct Ataques: Codable{
    let ataques: [String]?
}

struct Buddy: Codable {
    var nomeBuddy: String? = nil
    let tipo: String
    let especie: String
    var xp: Int = 10
    var level: Int = 1
    var status: Status = Status()
    var ataques: Ataques?
    
    mutating func getAttacks(){
        
        let especie = self.especie

        let processo = Process()
        processo.launchPath = "/usr/bin/python3"
        
        processo.arguments = ["/Users/user/Documents/VirtualOak/request.py", self.especie, "buddy"]
        
        let pipe = Pipe()
        processo.standardOutput = pipe
        
        processo.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
        }
        
        // Ler os dados JSON do arquivo
        let path = URL(fileURLWithPath: "/Users/user/ataques.json")
        let jsonData = try! Data(contentsOf: path)

        // Crie um objeto JSONDecoder
        let decoder = JSONDecoder()

        // Decodificar os dados JSON em uma instância da struct Person
        let ataques = try! decoder.decode(Ataques.self, from: jsonData)
        self.ataques = ataques
//        self.ataques = try decoder.decode(Ataques.self, from: jsonData)
//        print("dljsfhg")
//        print("ataques: \(self.ataques)")
        
        shell("rm /Users/user/ataques.json")
    }
}

struct Adversario: Codable {
    let especie: String
    let tipo: String
    var saude: Int
    let ataques: [String]
}

var pikachu: Buddy = Buddy(tipo: "Elétrico", especie: "Pikachu")

var charmander: Buddy = Buddy(tipo: "Fogo", especie: "charmander", status: Status(fome: 10))

var squirtle: Buddy = Buddy(tipo: "Agua", especie: "squirtle")

var bulbasaur: Buddy = Buddy(tipo: "Planta", especie: "bulbasaur")

var pokemons:[Buddy] = [pikachu, charmander, squirtle, bulbasaur]

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
