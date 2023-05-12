#!/bin/bash

. ./config.sh
. ./end_game.sh
. ./languages.sh
. ./new_letter.sh

if [[ `uname` == 'Darwin' ]]
then 
    if [[ `which gsed` == '' ]]
    then
        brew install gnu-sed
    fi
    if [[ `which gshuf` == '' ]]
    then
        brew install coreutils
    fi
    act_sed='gsed'
    act_shuf='gshuf'
fi

# установка локализации
export LANG=ru_RU.UTF-8

function init_game() {
    echo "Приветствую в игре 'Виселица'"
    echo "Вводите по одной букве или слово целиком, в противном случае будет браться первая буква"
    echo "Я загадал новое слово, начинаем игру!"
    echo
    
    # выбор случайного слова и заполнение переменных под него
    word_string=(`$act_shuf -n 1 $words_filename`)
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
    while IFS= read line
    do
        echo -E "$line"
    done <<< `cat $hangman_folder/${#wrong_letters[@]}`
    echo
}

init_game