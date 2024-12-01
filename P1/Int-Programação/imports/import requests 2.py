import requests

from loguru import logger

try:
    for i in range(5):
    
        result= requests.get('https://api.adviceslip.com/advice')
    
        print(result.json())
        print(result.json()['slip'])
        print(result.json()['slip']['id'])
        print(result.json()['slip']['advice'])
    
except Exception as error:
    logger.exception(f'Error:{error}')