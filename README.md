# The documentation is currently in beta
# About
This is my Hangman game written in Bash. The game is still in beta and is being actively finalized, including tests will be written later.
# Project structure
## main.sh
Main file contains functions:
- **init_game()**

this function is *initializating* all variables (correct word, right letters, wrong letters)

- **draw_current_hangman()**

this function is *drawing* current hangman, correct letters of word and errors letters

- **input_new_letter()**

this function is *inputting* new letter and checking the presence of a letter in word


## words_data
The file contains words that are used as riddles in the game


## hangman_images
This folder contains hangman images that are used in the stages of the game
# TODO
- [x] Random words generator
- [x] Hangman images
- [ ] Change hangman images
- [ ] Comments to code
- [ ] End game
- [ ] Letter has already been introduced
- [ ] Add all existing guessed letters (2+ identical letters)
- [x] Lowercase translation of the inputted letter
- [ ] 1 letter limit
- [ ] Check input letter (not space, not number)