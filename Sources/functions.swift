//
//  File.swift
//  
//
//  Created by User on 14/03/24.
//

import Foundation

let linha = "=================================================\n"


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

//struct Treinador {
//    //resto dos dados
//}

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


// Chamando a função para criar um arquivo de texto

//func criarBancoDeDados(data: Buddy, filePath: String) {
//    let jsonEncoder = JSONEncoder()
//
//    jsonEncoder.OutputFormatting = .prettyPrinted//.prettyPrinted
//
//    do {
//        let jsonData = try JSONEncoder.encode(data)//JSONEncoder.encode(data)
//
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsURL.appendingPathComponent(filePath)
//
//        try jsonData.write(to: fileURL)
//        print("Sua jornada começou!!")
//    } catch {
//        print("Error!")
//    }
//}

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

//func lerBancodeDados() -> Buddy {
//    let buddyData = Data(lerJSON(path).utf8)
//    
//    print(lerJSON(path))
//    
//    let jsonDecoder = JSONDecoder()
//    
//    let testBuddy = Buddy(nomeBuddy: "ljdfng", tipo: "kxhdbf", especie: "ksjdhfjks")
//    
//    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//    
//    do {
//        let decodedBuddy = try jsonDecoder.decode(Buddy.self, from: buddyData)
//        
//        print("""
//        Pokemon Status: \(decodedBuddy.status.felicidade)
//        """)
//        return decodedBuddy
//    } catch {
//        print("Error: \(error.localizedDescription)")
//    }
//    
//    return testBuddy
//}

let fileURL = URL(fileURLWithPath: "/Users/user/pokeData.json")

func saveData(_ path:URL, buddy: Buddy){
    // Instância da struct

    // Crie um objeto JSONEncoder
    let encoder = JSONEncoder()

    // Codificar a struct para JSON Data
    do {
        let jsonData = try encoder.encode(buddy)

        // Converta JSON Data em String (opcional)
        if let jsonString = String(data: jsonData, encoding: .utf8) {

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
        print(" ", terminator: "")
    }
    print(s)
}

//func lerBancodeDados() -> Buddy? {
//    let jsonDecoder = JSONDecoder()
//    
//    // Verifique se o arquivo pokeData.json existe no diretório de documentos
//    if let filePath = Bundle.main.path(forResource: "/Users/user/Documents/.pokeData", ofType: "json"){
//        do {
//            let buddyData = try Data(contentsOf: URL(fileURLWithPath: Pa))
//            let decodedBuddy = try jsonDecoder.decode(Buddy.self, from: buddyData)
//            
//            print("""
//            Pokemon Status: \(decodedBuddy.status.felicidade)
//            """)
//            return decodedBuddy
//        } catch {
//            print("Error: \(error.localizedDescription)")
//            return nil
//        }
//
//    }

    
