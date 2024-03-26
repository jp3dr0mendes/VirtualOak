//
//  File.swift
//  
//
//  Created by User on 14/03/24.
//

import Foundation

//Uso em macOS
let fileURL = URL(fileURLWithPath: "/Users/user/pokeData.json")
let advURL = URL(fileURLWithPath: "/Users/user/adversario.json")
let boxesPATH = "/opt/homebrew/Cellar/boxes/2.3.0/bin/boxes"

//Uso em Linux
//let boxesPATH = "/usr/bin/boxes"
//let fileURL = URL(fileURLWithPath: "/home/honorio/pokeData.json")
//let advURL = URL(fileURLWithPath: "/home/honorio/adversario.json")

let linha = "================================================="

let snackNarrative = [
    ["Hora de alimentar seu Pokémon!", "Vamos escolher um lanche delicioso...", "Ah, ele está devorando!", "Parece que ele adorou o lanche!"],
    ["Seu Pokémon está faminto!", "Vamos ver o que temos para ele comer...",  "Olha só como ele está saboreando cada pedacinho do lanche!"],
    ["Chegou a hora do lanche!", "Vamos garantir que seu Pokémon fique satisfeito...", "E parece que ele gostou bastante do que escolhemos!"],
    ["Hmm, seu Pokémon parece estar com fome!", "Vamos preparar um lanche especial para ele...", "Olha só como ele está contente enquanto come!"]]

let playNarrative = [
    ["Que tal brincar um pouco com seu Pokémon?", "Vamos escolher um jogo divertido...", "E olha só como ele está se divertindo!", "Parece que adorou a brincadeira!"],
    ["Seu Pokémon está pronto para se divertir!", "Vamos encontrar um brinquedo legal...", "Parece que ele está adorando a brincadeira que escolhemos!"],
    ["Hora de jogar!", "Vamos ver como seu Pokémon se sai em uma brincadeira...", "E parece que ele está se divertindo muito!", "Que bom vê-lo assim!"],
    ["Seu Pokémon parece animado para brincar!", "Vamos escolher uma atividade divertida...", "E veja só como ele está feliz enquanto brinca!"]]

let joyNarrative = [
    ["É hora de levar seu Pokémon para uma consulta com a Enfermeira Joy!", "Vamos lá... Tudo certo! Seu Pokémon está saudável e pronto para mais aventuras!"],
    ["Vamos garantir que seu Pokémon esteja sempre saudável!", "Consulta com a Enfermeira Joy...","Ótimo! Seu Pokémon está em perfeitas condições!"],
    ["Hora de verificar a saúde do seu Pokémon com a Enfermeira Joy!", "Vamos lá juntos...", "E parece que está tudo bem! Seu Pokémon está ótimo!"],
    ["Seu Pokémon merece cuidados especiais! Vamos visitar a Enfermeira Joy para uma rápida consulta... Tudo certo! Seu Pokémon está saudável e feliz!"]]

/*  Função utilizada para retornar um índice do array pokemons
    O usuario informa no terminal um inteiro entre 0 e 3: se for verdadeiro,
    a função retornar o numero selecionado; se não, a função retorna o número 0.
*/
func obterBuddyValido() -> Int {
    while true {
        print("Por favor, digite o número correspondente ao pokemon que deseja escolher: ")
        if let input = readLine(), let numero = Int(input), (0...3).contains(numero) {
            return numero
        } else {
            return 0
        }
    }
}

/*
    Função exibe uma ASCII ART de um pokemon ao realizar a escolha do inicial
     - Parameter buddy: Índice do array pokemons
*/
func showPokemons(buddy: Int){
    switch buddy{
    case 0: showPikachu();
    case 1: showCharmander();
    case 2: showSquirtle();
    case 3: showBulbassaur();
    default: print("")
    }
}

// Função auxiliar para limpar o terminal
func clearTerminalScreen() {
    let clear = Process()
    clear.launchPath = "/usr/bin/clear"
    clear.arguments = []
    clear.launch()
    clear.waitUntilExit()
}

/*
    Função utilizada para salvar um arquivo em JSON
     - Parameters:
       - path: Caminho do diretório onde o arquivo JSON será salvo
       - buddy: Instância da struct Buddy
*/
func saveData(_ path:URL, buddy: Buddy){

    // Crie um objeto JSONEncoder
    let encoder = JSONEncoder()

    // Codificar a struct para JSON Data
    do {
        let jsonData = try encoder.encode(buddy)

        // Converte JSON Data em String (opcional)
        if let _jsonString = String(data: jsonData, encoding: .utf8) {

            // Gravar dados JSON no arquivo
            try jsonData.write(to: path)

        }
    } catch {
        print("Erro ao codificar a struct para JSON: \(error)")
    }
}

/*
    Função para ler um arquivo JSON e transforma-lo em uma struct Buddy
     - Parameter path: Caminho do diretório onde o arquivo JSON está salvo
     - Returns: Uma instância da struct Buddy
*/
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

func readAdv(_ path:URL) -> Adversario?{
    do {
        // Ler os dados JSON do arquivo
        let jsonData = try Data(contentsOf: path)

        // Crie um objeto JSONDecoder
        let decoder = JSONDecoder()

        // Decodificar os dados JSON em uma instância da struct Person
        let adversario = try decoder.decode(Adversario.self, from: jsonData)

        // Imprimir os dados da pessoa
//        print("Nome: \(person.especie)")
        return adversario

    } catch {
        print("Erro ao ler o arquivo JSON: \(error)")
    }
    return nil
}

/*
    Função para exibir um texto no terminal e esperar 1 segundo para encerrar a função
     - Parameter text: Texto que será exibido
*/
func verbosePrint(_ text: String){
    print("▷ \(text)")
    sleep(1)
}

/*
Função que executa uma biblioteca chamada boxes. Esse método executa um comando
de bash e retornar um texto dentro de um cabeçalho
 - Parameters:
   - text: Texto que será exibido
   - style: Modelo do cabeçalho disponível na biblioteca
   - path: Caminho do diretório onde a biblioteca boxes está alocada
*/
func printWithBox(_ text: String, style: String, path: String) {
    let process = Process()
    process.launchPath = "/bin/bash"
    process.arguments = ["-c", "echo -e '\(text)' | \(path) -d \(style)"] // Use o caminho completo para o executável boxes
    
    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
}
/*
    Função usada para imprimir texto como se fosse em um jogo de RPG,
    onde cada caractere é exibido um por um com um pequeno atraso, dando uma sensação de animação.
     - Parameter text: Texto que será mostrado
*/
func printRPGText(_ text: String) {
    let delay = 0.1 // Ajuste este valor para controlar a velocidade da animação

    for char in text {
        // Imprimir uma letra por vez, com um pequeno atraso
        // terminator força a função print a exibir os caracteres na mesma linha
        print(char, terminator: "")
        fflush(stdout)
        Thread.sleep(forTimeInterval: delay)
    }
    print() // Adicionar uma nova linha no final
}

/*
    Função para exibir narrativas ao executar uma flag de care
     - Parameter: Array de Narrativas
*/
func verbose(narratives: [[String]]) {
    let randomIndex = Int.random(in: 0..<narratives.count)
    let selectedNarrative = narratives[randomIndex]
    
    for phrase in selectedNarrative {
        print(phrase)
        sleep(1) // Espera 1 segundo antes de exibir a próxima frase
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

func callForPokemon(pokemon: String, path: URL, file: String) -> Adversario?{
    let processo = Process()
    processo.launchPath = "/usr/bin/python3"
    processo.arguments = ["/Users/user/Documents/VirtualOak/request.py", pokemon, file]
    
    let pipe = Pipe()
    processo.standardOutput = pipe
    
    processo.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print(output)
    }
    // let url = URL(fileURLWithPath: "/Users/user/adversario.json")
    let pokemon = readAdv(path)
//    return pokemon
    return pokemon
}

func callForBattle(_ adversario: String){
    var buddy = readData(fileURL)!
    buddy.getAttacks()
    
    if var pokemon = callForPokemon(pokemon: adversario, path: advURL, file: "adv"){
        
        printRPGText("Procurando pokemon...")
        verbosePrint("Um \(pokemon.especie) selvagem apareceu!")
        verbosePrint("Inciando batalha com \(pokemon.especie)")
                
        var count: Int = 1
        
        while true{
            printWithBox("Round \(count)", style: "parchment", path: boxesPATH)
            sleep(3)
            
            shell("clear")
            
            var choose = 0
            
            while true {
                
                battleArt(adversario: pokemon, buddy: buddy)
                
                print("")
                
                if let input = readLine(), let attack = Int(input), (1...2).contains(attack) {
                    choose = attack
                    break
                } else {
                    print("Ataque inexistente")
                }
            }
            var rng = SystemRandomNumberGenerator()
//            let critic: Int = Int.random(in: 0...faces, using: &rng)
            
            print("\(String(describing: buddy.nomeBuddy ?? "")) usou \(buddy.ataques?.ataques?[choose-1] ?? "erro") ")
            print("Causou \(20 + dado(faces: 6)*20) de dano")
            buddy.status.saude = buddy.status.saude - (20 + dado(faces: 6)*20)
            
            print("\(String(describing: pokemon.especie)) usou \(pokemon.ataques[Int.random(in: 0...1, using: &rng)]) ")
            print("Causou \(20 + dado(faces: 6)*20) de dano")
            pokemon.saude = pokemon.saude - (20 + dado(faces: 6)*20)
            
            if pokemon.saude <= 0{
                print("PARABENS!")
                print("\(buddy.nomeBuddy ?? "") ganhou!!!")
                break
            } else if buddy.status.saude <= 0 {
                print("Essa não!")
                print("\(pokemon.especie) ganhou!")
                print("Leve seu buddy até a Enfermeira Joy e tente novamente!")
                break
            }
            
            count += 1
        }
    } else {
        print("Erro ao iniciar a batalha, tente novamente!")
    }
    
    saveData(fileURL, buddy: buddy)
}

func dado(faces: Int) -> Double{
    var rng = SystemRandomNumberGenerator()
    let critic: Int = Int.random(in: 0...faces, using: &rng)
    var low: Int = Int.random(in: 0...faces, using: &rng)
    
    while low == critic {
        low = Int.random(in: 0...faces, using: &rng)
    }
    
    let randomNumber = Int.random(in: 0...faces, using: &rng)
    
    if randomNumber == critic {
        return 0.2
    } else if randomNumber == low {
        return -0.2
    } else {
        return 0.0
    }
}

//func evolve()
