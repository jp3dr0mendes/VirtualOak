// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct Oak: ParsableCommand, Decodable {
    
    static var configuration = CommandConfiguration(
        abstract: "Pokemon Pet Buddy",
        discussion: "O VirtualOak permite que você cuide do seu Pokemon diretamente do seu terminal, com ele, você poderá brincar com ser Pokemon, alimenta-lo, acompanhar o seu progresso e leva-lo à enfermeira Joy sempre que precisar. Além disso, é possível fazer batalhas amigáveis para treina-lo e (talvez) evolui-lo. Basta chamar o Professor Carvalho pelo seu terminal e informá-lo que tipo de interação você deseja ter com o seu monstrinho (e não esqueça de se despedir).",
        subcommands: [Init.self, Check.self, Care.self, Battle.self]
    )
}

struct Init: ParsableCommand {
    
    //TODO: manipulacao de arquivo

    static var configuration = CommandConfiguration(
            abstract: "Inicie sua jornada Pokemon"
    )
    
    func run(){
        
        printWithBox(   """
                        Seja bem-vindo Treinador!
                        
                        Muito prazer em conhece-lo, me chamo professor carvalho estou aqui para ajuda-lo
                        durante toda sua jornada. Se precisar de mim, basta me chamar da seguinte forma:
                        """
        ,style: "scroll"
        ,path: boxesPATH)
        
        print("""
            oak <subcomando> [option]
            
            Qualquer dúvida de como interagir basta colocar:
            
            oak --help
            
            Pressione enter para continuar...
            """)
        
        let _continueText = readLine() ?? ""
        
        clearTerminalScreen()
        
        pokebals()

        let chooseBuddy = obterBuddyValido()
        
        clearTerminalScreen()
        
        print("\nVocê escolheu o Pokemon: " + pokemons[chooseBuddy].especie.capitalized)
        showPokemons(buddy: chooseBuddy)
        
        print("Você deseja colocar um apelido no seu Pokemon? [S/N]")
        
        while (true){
            let selectNickname = readLine() ?? "N"
            
            if selectNickname.uppercased() == "N"{
                
                pokemons[chooseBuddy].nomeBuddy = pokemons[chooseBuddy].especie
                
                print("Nice! Dados de \(pokemons[chooseBuddy].nomeBuddy?.capitalized ?? "") adicionados na PokeDex")
                
                break
                
            }
            
            else if selectNickname.uppercased() == "S"{
                
                print("Qual o nome voce deseja colocar no seu Buddy? ")
                
                let nickname = readLine()
                
                pokemons[chooseBuddy].nomeBuddy = nickname
                
                print("Nice! Dados de \(pokemons[chooseBuddy].nomeBuddy?.capitalized ?? "") adicionados na PokeDex")
                
                break
                
            }
            else {
                print("Entrada invalida")
                print("Digite SIM (S) ou NAO (N)")
            }
        }
        //pokemons[chooseBuddy].getAttacks()
        saveData(fileURL, buddy: pokemons[chooseBuddy])
    }
}

struct Check: ParsableCommand{

    static var configuration = CommandConfiguration(
            abstract: "Check como está o seu pokemon"
    )
        
    var charmander = Charmander()
    
    func run(){
        
        if let buddy = readData(fileURL) {

            printWithBox("""
                         Status do seu buddy
                         """, style: "important", path: boxesPATH)

            print("""
            
            Fome       : \(buddy.status.fome)
            Felicidade : \(buddy.status.felicidade)
            Saude      : \(buddy.status.saude)
            """)
            
            if buddy.especie == "charmander"{
                if buddy.status.fome > 80 || buddy.status.saude < 20 || buddy.status.felicidade < 20 {
                    charmander.charmanderDoente()
                } else {
                    charmander.charmanderFeliz()
                }
            } else if buddy.especie == "squirtle" {

            } else {
                
            }
        } else {
            print("Erro ao ler os dados do buddy")
        }
        diminuirFelicidade()
        aumentarFome()
    }
}


struct Care: ParsableCommand{
    
    static var configuration = CommandConfiguration(
        abstract: "Cuide do seu Pokémon."
    )
    
    @Flag(name: .shortAndLong, help: "Dê um lanche para o seu Pokemon")
    var snack: Bool = false
    
    @Flag(name: .shortAndLong, help: "Brinque com seu Pokemon")
    var play: Bool = false
    
    @Flag(name: .shortAndLong, help: "Chame a enfermeira Joy")
    var joy: Bool = false
        
    func run(){
        if snack{
            printWithBox("Alimentando seu Buddy", style: "parchment", path: boxesPATH)
            verbose(narratives: snackNarrative)
            diminuirFome()
        } else if play{
            printWithBox("Brincando com seu Buddy", style: "parchment", path: boxesPATH)
            verbose(narratives: playNarrative)
            aumentarFelicidade()
            aumentarFome()
        } else if joy{
            printWithBox("Centro Pokemon", style: "parchment", path: boxesPATH)
            verbose(narratives: joyNarrative)
            aumentarSaude()
        }
    }
}


struct Battle: ParsableCommand{
    static var configuration = CommandConfiguration(
        abstract: "Batalhe com outros pokemons"
    )
    
    @Argument(help: "Chame seu pokemon para uma batalha")
    var pokemon: String
    
    func run() {
        callForBattle(pokemon)
    }
}
