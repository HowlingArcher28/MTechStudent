import UIKit

enum Move {
    case rock
    case paper
    case scissors
}

enum Outcome {
    case tie
    case player1Win
    case player2Win
}

func playersImput(player1: Move, player2: Move) -> Outcome {
    guard player1 != player2 else { return .tie }
    
    switch player1 {
    case .rock:
        return player2 == .paper ? .player2Win : .player1Win
    case .paper:
        return player2 == .scissors ? .player2Win : .player1Win
    case .scissors:
        return player2 == .rock ? .player2Win : .player1Win
        }
        
}
    
playersImput(player1: .rock, player2: .paper)
    

    
    

