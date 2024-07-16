## Скрипт установки и запуска Wiki.js в LXC контейнере Astra Linux SE 1.7.5

| Требование             | Описание                     |
|------------------------|------------------------------|
| Платформа Astra Linux SE              | Версии 1.7.5         |
| Подключение к интернету| Для загрузки зависимостей    |
| Установка LXC          | Для создания и управления контейнерами |

1. Клонируйте репозиторий
```
git clone https://github.com/RaSabirov/alse-lxc-wikijs.git
```

2. Перейдите в папку со скриптом
```
cd alse-lxc-wikijs
```

3. Сделайте скрипт установки исполняемым
```
chmod +x setup.sh
```

4. Запустите скрипт установки
```
./setup.sh
```
5. Дождитесь окончания установки. Ориентировочное время: ~

6. Запустите Wiki.js в браузере по адрес: http://ВАШ_IP_КОНТЕЙНЕРА:3000
![Wiki.js](https://github.com/RaSabirov/alse-lxc-wikijs/blob/main/wikijs.jpg)
