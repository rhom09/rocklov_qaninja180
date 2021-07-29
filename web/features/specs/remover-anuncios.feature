#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter o meu Dashboard atualizado

    Cenario: Remover um anúncio

        Dado que teho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 100            |
        Quando eu solito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard

    Cenario: Remover um anúncio

        Dado que teho um anúncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 100            |
        Quando eu solito a exclusão desse item
            Mas não confirmo a exclusão
        Então devo ver esse item no meu Dashboard