#!/bin/bash
words_filename=words_data
hangman_folder=hangman_images
function init_game() {
    word_string=(`shuf -n 1 $words_filename`)
    word=(`echo $word_string | grep -o .`)
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
    while read line
    do
        echo $line
    done < $hangman_folder/$current_hangman
    echo
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