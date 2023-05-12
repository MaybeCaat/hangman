#!/bin/bash
# настройки языка
act_sed=sed
act_shuf=shuf
language=ru
langset=("а-я" "А-Я")
available_languages=("ru" "en")

# сколько ошибок может совершить пользователь
attempts=7

# настройки нахождения папок
words_filename=words/words_ru
hangman_folder=hangman_images
languages_folder=languages