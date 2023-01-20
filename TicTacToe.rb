require './GridWithSymbols.rb'

module TicTacToe
    class << self
        private
            @@pos = 0
            @@array_player_choicesX = Array.new(3) {Array.new()}
            @@array_player_choicesY = Array.new(3) {Array.new()}
            @@array_player_choices_diag = Array.new(3)
            @@array_of_valid_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            @@posX = 0
            @@posY = 0
            @@exists = false
            @@playerOne = true
            @@symbol = ''
            def checkIfExists
                @@array_of_valid_positions.each_with_index do
                    |val, ind|
                    if val == @@pos.to_i
                        @@array_of_valid_positions[ind] = 0
                        positionAssignment(@@pos)
                        @@exists = true
                    end
                end
                unless @@exists
                    puts `clear`
                    puts "There is already something in that position, press enter to continue"
                    gets
                    Grid.tttGrid
                    selectPosition
                end
            end
            def positionAssignment(pos)
                case pos.to_i
                    when 1..3
                        @@posX = 0
                    when 4..6
                        @@posX = 1
                    when 7..9
                        @@posX = 2
                end
                case ((pos.to_i + 3)%3)
                when 0
                    @@posY = 2
                when 1
                    @@posY = 0
                when 2 
                    @@posY = 1
                end
            end
            def changePlayer
                if @@playerOne
                    @@symbol = 'X'
                    @@playerOne = false
                else
                    @@symbol = "0" 
                    @@playerOne = true
                end
            end
            def selectPosition
                @@exists = false
                puts 'Select position'
                @@pos = gets.chomp
                until @@pos.to_i.between?(1, 9)
                    puts "Select again:\n"
                    @@pos = gets.chomp
                end
                checkIfExists
                @@array_player_choicesX[@@posX][@@posY] = @@symbol
                @@array_player_choicesY[@@posY][@@posX] = @@symbol
                @@array_player_choices_diag[@@posX] = @@symbol if @@posX == @@posY
            end
        public
        def newGame
            for i in 1..9 
                @@array_of_valid_positions[i] = i
            end
            Grid.clearGrid
        end
        def playOneRound
            changePlayer
            selectPosition
            Grid.ttt(@@posX, @@posY, @@symbol)
        end
        def testMethod
            p @@array_player_choicesX
            p @@array_player_choicesY
            p @@array_player_choices_diag
        end
    end
end

# TicTacToe.newGame
9.times{TicTacToe.playOneRound}
TicTacToe.testMethod
