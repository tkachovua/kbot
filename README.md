# kbot

t.me/tkachovua_bot

Telegram-бот написаний на мові <b>goleng</b> з використанням бібліотек cobra та telebot.v3 (github.com/spf13/cobra, gopkg.in/telebot.v3).

На запит <b>/start hello</b> повертає повідомлення з версією бота <b>Hello. I'm Kbot v1.0.2!</b>

На запит <b>/start menu</b> повертає <b>menu</b>

Інструкція з встановлення:

1. Склонуйте репозиторій <b>$git clone https://github.com/tkachovua/kbot</b>

2. Зберіть проект <b>$go build -ldflags "-X="github.com/tkachovua/kbot/cmd.appVersion=v1.0.2</b>

3. Створіть Telegram-бота за допомогою Telegram BotFather 

4. Скопіюйте токен новостворенного бота

5. Додайте токен в середовеще проекту:

<b>$read -s TELE_TOKEN</b>

<b>Вставьте токен (Ctrl+V)</b>

<b>$export TELE_TOKEN</b>

6. Запустіть бот командою <b>$./kbot start</b>

7. Enjoy!