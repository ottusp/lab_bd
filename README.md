# Lab BD

## Desenvolvendo
Esse repositório usa `virtualenv` para virtualizar o ambiente.
Para começar a desenvolver, baixe esse pacote globalmente:
```shell
pip3 install virtualenv
```

Em seguida, dentro do diretório, inicie o ambiente virtual:
```shell
source venv/bin/activate
```

E instale os pacotes utilizados:
```shell
pip3 install -r requirements.txt
```

Pronto, você já está pronto para desenvolver.

Quando quiser sair do ambiente virtual, use o seguinte commando:

```shell
deactivate
```

### Instalando novos pacotes
Instale os pacotes necessários para o seu desenvolvimento.
Quando adicionar novos pacotes, coloque-os no `requirements.txt`
para que outros desenvolvedores possam instalá-los. Rode:
```shell
pip3 freeze > requirements.txt
```
