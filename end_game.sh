#!/bin/bash
function game_over() {
    echo "Вы проиграли!"
    echo "Было загадано слово ${word[@]}"
    echo "Вы отгадали: ${correct_letters[@]}"
    choose_new_game
}

function win() {
    echo "Вы выиграли!"
    echo "Загаданное слово: ${word[@]}"
    choose_new_game
}

function choose_new_game() {
    echo
    read -p "Введите q, чтобы выйти или любой другой символ, чтобы начать новую игру: " new
    if [[ $new == "q" ]]
    then
        exit 0
    else
        echo
        init_game
    fi
}