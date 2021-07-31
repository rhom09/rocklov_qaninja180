#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter o meu Dashboard atualizado

    Contexto: Login
        * Login com "barry@terra.com.br" e "pwd123"

    Cenario: Remover um anúncio

        Dado que teho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 100            |
        Quando eu solito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard
    
    Cenario: Não remover um anúncio

        Dado que teho um anúncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 30        |
        Quando eu solito a exclusão desse item
            Mas não confirmo a exclusão
        Então esse item deve permanecer no meu Dashboard