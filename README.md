# The documentation is currently in beta
# About
This is my Hangman game written in Bash. The game is still in beta and is being actively finalized, including tests will be written later.
# Project structure
## main.sh
Main file contains functions:
- **init_game()**
this function is *initializating* all variables (correct word, right letters, wrong letters)
- draw_current_hangman()
this function is *drawing* current hangman, correct letters of word and errors letters
- input_new_letter()
this function is *inputting* new letter and checking the presence of a letter in word
# TODO
- [ ] Random words generator
- [ ] Hangman images
- [ ] Comments to code
- [ ] End game
- [ ] Letter has already been introduced
- [ ] Add all existing guessed letters (2+ identical letters)