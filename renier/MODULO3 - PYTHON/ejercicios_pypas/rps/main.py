def run(player1: str, player2: str) -> int:
    # winner = 0
    # if (player1.lower() == 'paper' and player2.lower() == 'scissors'):
    #     winner = 2
    # elif (player1.lower() == 'paper' and player2.lower() == 'rock'):
    #     winner = 1
    # elif (player1.lower() == 'scissors' and player2.lower() == 'paper'):
    #     winner = 1
    # elif (player1.lower() == 'scissors' and player2.lower() == 'rock'):
    #     winner = 2
    # elif (player1.lower() == 'rock' and player2.lower() == 'paper'):
    #     winner = 2
    # elif (player1.lower() == 'rock' and player2.lower() == 'scissors'):
    #     winner = 1

    # return winner


    player1 = player1.lower() 
    player2 = player2.lower() 

    # Mapea cada opción con la jugada a la que vence
    beats = {'paper': 'rock', 'rock': 'scissors', 'scissors': 'paper'}

    winner = 0 if player1 == player2 else (1 if beats[player1] == player2 else 2)
    return winner


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
