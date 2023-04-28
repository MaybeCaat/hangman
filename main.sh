#!/bin/bash
hangman=("нулевой" "первый" "второй")
function init_game() {
    word=("п" "р" "о" "в" "е" "р" "к" "а")
    correct_letters=()
    for (( i=0; i<${#word[@]}; i++ ))
    do
        correct_letters+=("_")
    done
    wrong_letters=()
    errors_counter=0
    current_hangman=0
}

function draw_current_hangman() {
    echo "Слово: ${correct_letters[@]}"
    echo "Ошибки: ${wrong_letters[@]}"
    echo "${hangman[$current_hangman]}"
}

init_game
draw_current_hangman