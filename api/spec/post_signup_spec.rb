require_relative "routes/signup"
require_relative "libs/mongo"

describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Ronaldo", email: "fenomeno@ig.com.br", password: "090909" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      # parsed_response converte o response da API(Json) para HASH da linguagem Ruby.
      # Funciona sem o parsed_response. Ex: expect(result["name"]).to eql "Bob Marley"
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      payload = { name: "Olav Snow", email: "olav@ig.com.br", password: "snow123" }
      MongoDB.new.remove_user(payload[:email])

      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  ### DESAFIO ###
  examples = Helpers::get_fixture("signup")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create(e[:payload])
      end

      it "deve retornar #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "deve retornar mensagem #{e[:error]}" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end

  ### DESAFIO AUTOMATIZAR OS DEMAIS CENARIOS DE SIGNUP ####

  # name é obrigatorio
  # email é obrigatorio
  # password é obrigatorio

end
