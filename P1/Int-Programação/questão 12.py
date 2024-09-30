from random import randint

espada_atq = randint(40, 120)
espada_dur = randint(50, 100)

arco_atq = randint(50, 120)
arco_dur = randint(30, 100)

lança_atq = randint(30, 120)
lança_dur = randint(30, 120)

if espada_atq > 50 and espada_dur < 70:
    print('Espada')
elif arco_atq > 50 and arco_dur < 70:
    print('Arco')
elif lança_atq > 50 and lança_dur < 70:
    print('Lança')
else:
    print('Tente Novamente')
