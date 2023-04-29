#!/bin/bash
words_filename=words_data
hangman_folder=hangman_images
function init_game() {
    echo "Приветствую в игре 'Виселица'"
    echo "Я загадал новое слово, начинаем игру!"
    echo
    word_string=(`shuf -n 1 $words_filename`)
    word=(`echo $word_string | grep -o .`)
    correct_letters=()
    for (( i=0; i<${#word[@]}; i++ ))
    do
        correct_letters+=("_")
    done
    wrong_letters=()
    remaining_letters=${#word[@]}
    input_new_letter
}

function draw_current_hangman() {
    echo "Слово: ${correct_letters[@]}"
    echo "Ошибки: ${wrong_letters[@]}"
    echo "Осталось ошибок: $((8-${#wrong_letters[@]}))"
    while read line
    do
        echo "$line"
    done < $hangman_folder/${#wrong_letters[@]}
    echo
}

function input_new_letter() {
    read -p "Введите новую букву: " current_letter
    current_letter=${current_letter:0:1}
    current_letter=`echo "$current_letter" | sed 's/[А-Я]/\L&/g'`

    if [[ ! "$current_letter" || "$current_letter" != *[a-z]* ]]
    then
        echo "Вы ввели недопустимый символ! (цифру, пробел и т.п.)"
        input_new_letter
    fi

    if [[ "${correct_letters[*]}" =~ "${current_letter}" || "${wrong_letters[*]}" =~ "${current_letter}"  ]]
    then
        echo "Вы уже вводили данную букву!"
        input_new_letter
    fi

    is_word_has_letter=0
    for i in "${!word[@]}"
    do
        if [[ "${word[$i]}" = "${current_letter}" ]]
        then
            is_word_has_letter=1
            correct_letters[$i]=${word[$i]}
            remaining_letters=$(($remaining_letters-1))
        fi
    done

    if [[ $remaining_letters -eq 0 ]]
    then
        draw_current_hangman
        win
    fi

    if [[ $is_word_has_letter -eq 0 ]]
    then
        wrong_letters+=($current_letter)
        if [[ ${#wrong_letters[@]} -eq 7 ]]
        then
            draw_current_hangman
            game_over
        fi
    fi
    draw_current_hangman
    input_new_letter
}

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

init_game