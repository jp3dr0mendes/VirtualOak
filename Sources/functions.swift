//
//  File.swift
//  
//
//  Created by User on 14/03/24.
//

import Foundation

let linha = "================================================="

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




func criarBasedeDados(buddy: Buddy, filePath: String) {
    let fileManager = FileManager.default
    
    if let data = ("\(buddy)").data(using: .utf8) {
//    if let data = conteudo.data(using: .utf8) {
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

func checarBasedeDados() {
    let fileManager = FileManager.default
    //reads data from "myfile.txt" to show that data has been written
    if let fileData = fileManager.contents(atPath: filePath) {
        if let fileContentString = String(data: fileData, encoding: .utf8) {
            print("File contents:")
            print(fileContentString)
        }
    } else {
        print("Failed to read file")
    }
}

// Função auxiliar: Limpa o terminal
func clearTerminalScreen() {
    let clear = Process()
    clear.launchPath = "/usr/bin/clear"
    clear.arguments = []
    clear.launch()
    clear.waitUntilExit()
}

func criarBancoDeDados(data: Buddy){
    
    let file: String = "pokeData.json"
    let jsonEncode = JSONEncoder()
    let structToJSON = try! jsonEncode.encode(data)
    
    
    if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask).first {
        let pathWithFilename = documentDirectory.appendingPathComponent(file)
        do {
            try structToJSON.write(to: pathWithFilename)
            print("Pokedex criada")
        } catch {
            print("Error in save JSON")
        }
    }
}
//let path = "~/Users/user/Documents/"
let path: String = "User/user/VirtualOak"

func lerJSON(_ path: String) -> String{
    if let fileURL = Bundle.main.url(forResource: "User/user/VirtualOak", withExtension: "json") {
        do {
            // Lê o conteúdo do arquivo como uma string
            let jsonString = try String(contentsOf: fileURL)
            print("Conteúdo do arquivo JSON como string:")
            return jsonString
        } catch {
            print("Erro ao ler o arquivo JSON como string: \(error.localizedDescription)")
        }
    } else {
        print("Arquivo JSON não encontrado.")
    }
    return ""
}

let fileURL = URL(fileURLWithPath: "/Users/user/pokeData.json")

func saveData(_ path:URL, buddy: Buddy){
    // Instância da struct

    // Crie um objeto JSONEncoder
    let encoder = JSONEncoder()

    // Codificar a struct para JSON Data
    do {
        let jsonData = try encoder.encode(buddy)

        // Converta JSON Data em String (opcional)
        if let _jsonString = String(data: jsonData, encoding: .utf8) {

            // Gravar dados JSON no arquivo
            try jsonData.write(to: path)

        }
    } catch {
        print("Erro ao codificar a struct para JSON: \(error)")
    }
}


func readData(_ path:URL) -> Buddy?{
    do {
        // Ler os dados JSON do arquivo
        let jsonData = try Data(contentsOf: path)

        // Crie um objeto JSONDecoder
        let decoder = JSONDecoder()

        // Decodificar os dados JSON em uma instância da struct Person
        let buddy = try decoder.decode(Buddy.self, from: jsonData)

        // Imprimir os dados da pessoa
//        print("Nome: \(person.especie)")
        return buddy

    } catch {
        print("Erro ao ler o arquivo JSON: \(error)")
    }
    return nil
}

func printc(_ s: String, _ tam: Int) {
    let ne = (tam - s.count) / 2
    for _ in 0..<ne {
        print("", terminator: " ")
    }
    print(s)
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

func cabecalho(titulo: String){
    
    let maxWidth = 90
    let borda = "\(String(repeating: "-", count: 90))"
    let paddingChar = " "
    let paddingSize = (maxWidth - titulo.count) / 2
    let paddingTitle = String(repeating: paddingChar, count: (maxWidth - titulo.count) / 2)
    
    print(borda)
    print("|\(paddingTitle)\(titulo)\(paddingTitle)|")
    print(borda)
    
}

func verbosePrint(_ text: String){
    print("▷ \(text)")
    sleep(1)
}
