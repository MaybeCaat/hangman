#!/bin/bash
function input_new_letter() {
    read -p "Введите новую букву: " current_letter
    if [[ ! "$current_letter" ]]
    then
        echo "Вы ничего не ввели!"
        echo
        input_new_letter
    fi

    # если ввели слово
    if [[ ${current_letter} == ${word_string} ]]
    then
        win
    elif [[ ${#current_letter} -eq ${#word[@]} ]]
    then
        echo "Неверное слово! Попробуйте другое слово или букву!"
        echo
        input_new_letter
    fi
    
    # если ввели не слово (длина не сходится)
    current_letter=${current_letter:0:1}
    current_letter=`echo ${current_letter} | sed -n "s/[${langset[1]}]/\L&/p" | sed -n "/[${langset[0]}]/p"`
    if [[ "$current_letter" == "" ]]
    then
        echo "Вы ввели недопустимый символ! (цифру, пробел и т.п.)"
        echo
        input_new_letter
    fi
    if [[ "${correct_letters[@]}" =~ "${current_letter}" || "${wrong_letters[@]}" =~ "${current_letter}"  ]]
    then
        echo "Вы уже вводили данную букву!"
        echo
        input_new_letter
    fi

    # поиск буквы
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

    # все буквы отгаданы
    if [[ $remaining_letters -eq 0 ]]
    then
        draw_current_hangman
        win
    fi

    if [[ $is_word_has_letter -eq 0 ]]
    then
        wrong_letters+=($current_letter)
        # попытки закончились
        if [[ ${#wrong_letters[@]} -eq $attempts ]]
        then
            draw_current_hangman
            game_over
        fi
    fi
    draw_current_hangman
    input_new_letter
}