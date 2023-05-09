#!/bin/bash
# осталось только заполнить файлы с локализацией и вставить их использование в коде
function set_language() {
    echo "Доступные языки для игры: ${available_languages[@]}"
    read -p "Выберите язык: " language
    if ! [[ "${available_languages[@]}" =~ "${language}" ]]
    then
        echo "Выберите корректный язык!"
        echo
        set_language
    fi
    while read line
    do
        if [[ $line == '-----' ]]
        then
            langset+=("$curr")
            curr=""
        else
            curr="${curr}${line}\n"
        fi
    done < "languages/$language"
    words_filename="words/words_$language"
    echo
}