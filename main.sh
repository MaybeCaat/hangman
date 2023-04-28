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
    input_new_letter
}

function draw_current_hangman() {
    echo "Слово: ${correct_letters[@]}"
    echo "Ошибки: ${wrong_letters[@]}"
    # echo "${hangman[$current_hangman]}"
}

function input_new_letter() {
    read -p "Введите новую букву: " current_letter
    temp_index=-1
    for i in "${!word[@]}"
    do
        if [[ "${word[$i]}" = "${current_letter}" ]]
        then
            temp_index=$i
        fi
    done
    echo $temp_index
    if [[ $temp_index -eq -1 ]]
    then
        errors_counter=$(($errors_counter+1))
        current_hangman=$(($corrent_letter+1))
        wrong_letters+=($current_letter)
    else
        correct_letters[$temp_index]=${word[$temp_index]}
    fi
    draw_current_hangman
    input_new_letter
}

init_game