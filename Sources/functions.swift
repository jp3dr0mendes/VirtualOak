//
//  File.swift
//  
//
//  Created by User on 14/03/24.
//

import Foundation

let fileURL = URL(fileURLWithPath: "/Users/user/pokeData.json")

let linha = "================================================="

// Função auxiliar: Limpa o terminal
func clearTerminalScreen() {
    let clear = Process()
    clear.launchPath = "/usr/bin/clear"
    clear.arguments = []
    clear.launch()
    clear.waitUntilExit()
}

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

func cabecalho(titulo: String){
    
    let maxWidth = 90
    let borda = "✦\(String(repeating: "-", count: 90))✦"
    let paddingChar = " "
//    let _paddingSize = (maxWidth - titulo.count) / 2
    let paddingTitle = String(repeating: paddingChar, count: (maxWidth - titulo.count) / 2)
    
    print(borda)
    print("| \(paddingTitle)\(titulo)\(paddingTitle)|")
    print(borda)
    
}

func verbosePrint(_ text: String){
    print("▷ \(text)")
    sleep(1)
}

func printWithBox(_ text: String, style: String) {
    let process = Process()
    process.launchPath = "/bin/bash"
    process.arguments = ["-c", "echo -e '\(text)' | /opt/homebrew/Cellar/boxes/2.3.0/bin/boxes -d \(style)"] // Use o caminho completo para o executável boxes
    
    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
}


@discardableResult
func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    print(output)
    return output
}

func printRPGText(_ text: String) {
    let delay = 0.1 // Ajuste este valor para controlar a velocidade da animação

    for char in text {
        // Imprimir uma letra por vez, com um pequeno atraso
        print(char, terminator: "")
        fflush(stdout)
        Thread.sleep(forTimeInterval: delay)
    }
    print() // Adicionar uma nova linha no final
}
func callForPokemon(pokemon: String){
    let processo = Process()
    processo.launchPath = "/usr/bin/python3"
    processo.arguments = ["/Users/user/Documents/VirtualOak/request.py", pokemon]
    
    let pipe = Pipe()
    processo.standardOutput = pipe
    
    processo.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
}
