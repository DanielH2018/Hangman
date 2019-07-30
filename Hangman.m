%************************************************
%*  Name:  Group H       Date:  10/20/18        *
%*  Seat/Table:  31      File:  Hangman.m       *
%*  Instructor:  Dr. Pulcherio 12:40            *                   
%************************************************ 


%Clear Everything
clc
clear
%Get Word to Guess
wordToGuess = input('Enter a secret word/phrase to guess: ');
%Clear input from Console
clc
%Create String of questions marks to display hidden word/phrase
toShow = blanks(strlength(wordToGuess));
toShow(1:strlength(wordToGuess)) = '?';
lengthToSubtract = 0;
%Only convert alphanumeric letters into '?'
for n = 1:1:strlength(wordToGuess)
   if(isstrprop(wordToGuess(n), 'alpha') ~= 1)
       toShow(n) = wordToGuess(n);
       lengthToSubtract = lengthToSubtract + 1;
   end
end
%Create Incorrect Guess counter
incorrectGuesses = 0;
%Create Guess storing matrix
guessMatrix = [];
%Display Converted String
fprintf('The Word\n %s\n',toShow);
%Loop while less then 6 incorrect guesses
while incorrectGuesses < 6
    %Get User guess
    guess = input('\nGuess a letter or the word/phrase: ');
    foundLetter = 0;
    %If the guess is valid(1 && character), check for validity
    if(length(guess) ~= 0 && min(isletter(guess) == 1) && (strlength(guess) == 1) )
        %If the letter wasn't already guessed
        if max(lower(guess) == lower(toShow))
            fprintf('Letter already guessed!\n')
        else
            for n = 1:1:strlength(wordToGuess)
                if(lower(wordToGuess(n)) == lower(guess))
                    toShow(n) = wordToGuess(n);
                    foundLetter = 1;
                end
            end
            %If letter is found and the word isn't finished, display correct and number of incorrect
            %guesses left
            if((foundLetter == 1) && ~min(wordToGuess == toShow))
                fprintf('Correct! Guess again! (%1.0f Incorrect guesses left)', (6 - incorrectGuesses))
                guessMatrix = [guessMatrix, guess];
                fprintf('\nAlready guessed letters: ')
                fprintf('%c ',guessMatrix)
                fprintf('\n')
            elseif(~min(wordToGuess == toShow))
                %If letter isn't found and the word isn't finished, display incorrect, increment
                %incorrect guess counter, and display number of incorrect
                %guesses left
                incorrectGuesses = incorrectGuesses + 1;
                fprintf('\nIncorrect! Try again! (%1.0f Incorrect guesses left)', (6 - incorrectGuesses))
                guessMatrix = [guessMatrix, guess];
                fprintf('\nAlready guessed letters: ')
                fprintf('%c ',guessMatrix)
                fprintf('\n')
            end
            %Print converted string with guessed letters
            fprintf('\n %s \n',toShow)
            %If the word to guess equals the converted string, break from the
            %loop display
            if(wordToGuess == toShow)
                fprintf('\nYou Got the word!')
                break;
            end
        end
    elseif (numel(guess) == numel(wordToGuess))
        if(min(guess == wordToGuess))
            fprintf('\nYou Got the word!')
            break;
        else
            incorrectGuesses = incorrectGuesses + 1;
            fprintf('\nIncorrect! Try again! (%1.0f Incorrect guesses left)', (6 - incorrectGuesses))
            if(numel(guessMatrix) > 0)
            fprintf('\nAlready guessed letters: ')
            fprintf('%c ',guessMatrix)
            end
            fprintf('\n\n %s \n',toShow)
        end
    else
        fprintf('Invalid Input! Try Again!\n')
    end
end
%If incorrect guesses is 6 when the loop exits, display loss message 
if(incorrectGuesses == 6)
    fprintf('\nYou did not get the word!\n')
    fprintf('The word was: %s\n', wordToGuess)
end