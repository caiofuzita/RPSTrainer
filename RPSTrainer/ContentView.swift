import SwiftUI

struct ContentView: View {
    @State private var roundCurrent = 1
    @State private var roundLimit = 10
    @State private var score = 0
    @State private var chooses = ["Pedra", "Papel", "Tesoura"]
    
    @State private var randomOptionWin = Bool.random()
    @State private var randomChoose = Int.random(in:0...2)
    
    @State private var showingResult = false
    @State private var resultMessage = ""
    
    var optionWin: Text {
        if randomOptionWin {
            return Text("Ganhar")
                .foregroundColor(.green)
        }
        
        return Text("Perder")
            .foregroundColor(.red)
    }
    
    var optionCpu: String {
        return chooses[randomChoose]
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Round: \(roundCurrent)/\(roundLimit)")
                .font(.title)
            HStack() {
                Text("\(optionWin) de:")
                    .font(.largeTitle)
                Image(optionCpu)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            VStack() {
                ForEach(chooses, id: \.self) { choose in
                    Button(action:{
                        print(choose)
                        buttonTapped(userChoose: choose)
                    }) {
                        Image(choose)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            
                    }
                }
            }
            
            Text("Pontuação: \(score)")
                .font(.title2)
        }
        
        .alert("Fim de jogo", isPresented: $showingResult) {
            Button("Reiniciar", action: resetGame)
        } message: {
            Text("Pontuação final: \(score)")
        }
    }
    
    func buttonTapped(userChoose: String) {
        var win = isWin(choose1: userChoose, choose2: optionCpu)
        
        if (!randomOptionWin) { win.toggle() }
            
        if win {
            score += 1
        } else {
            score -= 1
        }
        
        if (roundCurrent < roundLimit) {
            roundCurrent += 1
            shuffleGame()
        } else {
            showingResult = true
        }
        
    }
    func shuffleGame() {
        randomOptionWin = Bool.random()
        randomChoose = Int.random(in:0...2)
    }
    
    func resetGame() {
        roundCurrent = 1
        score = 0
        shuffleGame()
    }
    
    func isWin(choose1: String, choose2: String) -> Bool {
        if (choose1 == "Pedra" && choose2 == "Tesoura") { return true }
        
        if (choose1 == "Papel" && choose2 == "Pedra") { return true }
        
        if (choose1 == "Tesoura" && choose2 == "Papel") { return true }
            
        return false
    }

}

#Preview {
    ContentView()
}
