// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation



@main
struct Oak: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        abstract: "Pokemon Pet Buddy",
        discussion: "O VirtualOak permite que você cuide do seu Pokemon diretamente do seu terminal, com ele, você poderá brincar com ser Pokemon, alimenta-lo, acompanhar o seu progresso e leva-lo à enfermeira Joy sempre que precisar. Além disso, é possível fazer batalhas amigáveis para treina-lo e (talvez) evolui-lo. Basta chamar o Professor Carvalho pelo seu terminal e informá-lo que tipo de interação você deseja ter com o seu monstrinho (e não esqueça de se despedir).",
        subcommands: [Init.self]
    )
    
    //mutating func run() throws {}
}

//struct Check: ParsableCommand {
//
//    @Argument(help: "first number")
//    var number1: Int
//
//    @Argument(help: "second number")
//    var number2: Int
//
//    func run() {
//        print(number1+number2)
//    }
//}

//struct Care{
//    //TODO
//}


struct Init: ParsableCommand {
    
    //TODO: manipulacao de arquivo
    
    func run(){
        let fileURL = URL(fileURLWithPath: "/Users/user/Documents/")
        let contentDirectory = try! FileManager.default.contentsOfDirectory(at: fileURL, includingPropertiesForKeys: nil)
        let validateArray = contentDirectory.map{$0.absoluteString}
        
        if !(validateArray.contains("nomedoarquivo.txt")){
            print("""
                  Sua jornada pokemon js foi iniciada!!!
                  Cheque como seu pokemon esta com um 'oak check'
                  """)
            
            return
        }

        
        print("Saudações Treinador!\n")
        
        print("""
            Muito prazer em conhecê-lo,meu nome é professor carvalho
            estou aqui para ajuda-lo na sua jornada. Então qualquer coisa basta me chamar da seguinte forma:
            
            oak <subcomando> [option]
            
            Qualquer dúvida de como interagir basta colocar:
            
            oak --help
            
            Pressione enter para continuar...
            """)
        
        let continueText = readLine() ?? ""
        
        print(shell("clear"))
        
        print("""
                             @@@@@@@@@@                              @@@@@@@@@@@                              @@@@@@@@@@
                         @@@           @@@                        @@@           @@@                        @@@           @@@
                       @@                 @@@                  @@@                 @@@                  @@@                 @@
                     @@                     @@                @@                     @@                @@                     @@
                    @@                        @@             @                         @              @                        @@
                   @@                          @            @                           @            @                          @@
                  @@            @@@            @@          @@            @@@            @@          @@            @@@            @@
                  @@          @@   @@           @          @           @@   @@           @          @           @@   @@          @@
                  @@@@@@@@@@@@@     @@@@@@@@@@@@@          @@@@@@@@@@@@@     @@@@@@@@@@@@@          @@@@@@@@@@@@@     @@@@@@@@@@@@@
                  @@          @@   @@           @          @           @@   @@           @          @           @@   @@          @@
                  @@            @@@            @@          @@            @@@            @@          @@            @@@            @@
                   @@                          @            @@                         @@            @                          @@
                    @@                        @              @@                       @@              @                        @@
                     @@                     @@                @@                     @@                @@                     @@
                       @@                 @@@                   @@                 @@                   @@@                 @@
                         @@@           @@@                        @@@           @@@                        @@@           @@@
                             @@@@@@@@@                                @@@@@@@@@                                @@@@@@@@@
                                                                                                                                                     
                            
                            Charmander                                Squirtle                                 Bulbassaur
                                                                                                                                                     
        
        """)
        
        
    }
}

struct Care{
    @Option(help: "Formas de se cuidar o seu pokemon")
    var careOption: String
    
    func run(){
        
    }
}



struct Status{
    var fome: Int
    var saude: Int
    var felicidade: Int
}

struct Buddy {
    let nomeBuddy: String
    let tipo: String
    let especie: String
    var nicknameBuddy: String
    var xp: Int
    var level: Int
    var status: Status
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
