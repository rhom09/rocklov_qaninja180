#language: pt

@all_cadastros
Funcionalidade: Cadastro
     Sendo um músico que possui equipamentos musicais
     Quero fazer o meu cadastro no RockLov
     Para que eu possa disponibilizá-los para locação

     @cadastro
     Cenario: Fazer cadastro

          Dado que acesso a página de cadastro
          Quando submeto o seguinte formulário de cadastro:
               | nome           | email              | senha  |
               | Romilton Viana | rhom0909@gmail.com | pwd123 |
          Então sou redirecionado para o Dashboard

     @tentativa_cadastro
     Esquema do Cenario: Tentativa de cadastro

          Dado que acesso a página de cadastro
          Quando submeto o seguinte formulário de cadastro:
               | nome         | email         | senha         |
               | <nome_input> | <email_input> | <senha_input> |
          Então vejo a mensagem de alerta: "<mensagem_output>"

          Exemplos:
               | nome_input     | email_input        | senha_input | mensagem_output                  |
               |                | rhom0909@gmail.com | pwd123      | Oops. Informe seu nome completo! |
               | Romilton Viana |                    | pwd123      | Oops. Informe um email válido!   |
               | Romilton Viana | rhom0909#gmail.com | pwd123      | Oops. Informe um email válido!   |
               | Romilton Viana | rhom0909@gmail.com |             | Oops. Informe sua senha secreta! |