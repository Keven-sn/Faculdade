import requests

from loguru import logger

try:
    for i in range(5):

        result= requests.get('https://api.adviceslip.com/advice')

        print(result.json())
        print(result.json()['slip'])
        print(result.json()['slip']['id'])
        print(result.json()['slip']['advice'])

        texto = f'{result.json()['slip']['id']}-{result.json()['slip']['advice']}'

        with open('conselho.txt'), 'a', encoding ='UTF-8' as arquivo:
            arquivo.write(texto + "\n")


except Exception as error:
    logger.exception(f'Error:{error}')