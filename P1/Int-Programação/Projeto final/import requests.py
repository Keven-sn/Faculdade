import requests

result= requests.get('https://api.adviceslip.com/advice')

print(result)
print(result.status_code)
print(result.text)
print(result.encoding)
print(result.json())
print(result.json()['slip'])
print(result.json()['slip']['id'])
print(result.json()['slip']['advice'])