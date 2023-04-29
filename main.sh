#!/bin/bash
words_filename=words_data
hangman_folder=hangman_images
function init_game() {
    echo "Приветствую в игре 'Виселица'"
    echo "Я загадал новое слово, начинаем игру!"
    word_string=(`shuf -n 1 $words_filename`)
    word=(`echo $word_string | grep -o .`)
    correct_letters=()
    for (( i=0; i<${#word[@]}; i++ ))
    do
        correct_letters+=("_")
    done
    wrong_letters=()
    remaining_letters=${#word[@]}
    current_hangman=0
    input_new_letter
}

function draw_current_hangman() {
    echo "Слово: ${correct_letters[@]}"
    echo "Ошибки: ${wrong_letters[@]}"
    while read line
    do
        echo $line
    done < $hangman_folder/$current_hangman
    echo
}

function input_new_letter() {
    read -p "Введите новую букву: " current_letter
    current_letter=`echo "$current_letter" | sed 's/[А-Я]/\L&/g'`
    temp_index=-1
    for i in "${!word[@]}"
    do
        if [[ "${word[$i]}" = "${current_letter}" ]]
        then
            temp_index=$i
        fi
    done
    if [[ $temp_index -eq -1 ]]
    then
        current_hangman=$(($corrent_letter+1))
        wrong_letters+=($current_letter)
        if [[ $current_hangman -eq 6 ]]
        then
            game_over
        fi
    else
        correct_letters[$temp_index]=${word[$temp_index]}
        remaining_letters=$(($remaining_letters-1))
        if [[ $remaining_letters -eq 0 ]]
        then
            win
        fi
    fi
    draw_current_hangman
    input_new_letter
}

function game_over() {
    echo "Вы проиграли!"
    echo "Было загадано слово ${word[@]}"
    echo "Вы отгадали: ${correct_letters[@]}"
    read -p "Введите q, чтобы выйти или любой другой символ, чтобы начать новую игру: " new
    if [[ $new == "q" ]]
    then
        exit 0
    else
        echo
        init_game
    fi
}

function win() {
    echo "Вы выиграли!"
    echo "Загаданное слово: ${word[@]}"
    read -p "Введите q, чтобы выйти или любой другой символ, чтобы начать новую игру: " new
    if [[ $new == "q" ]]
    then
        exit 0
    else
        echo
        init_game
    fi
}

init_game