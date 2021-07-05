require_relative "routes/sessions"
require_relative "helpers"

describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "jamaica@terra.com.br", password: "canabis123" }
      @result = Sessions.new.login(payload)
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

  # examples = [
  #   {
  #     title: "senha incorreta",
  #     payload: { email: "jamaica@terra.com.br", password: "erva123" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "usuario não exixte",
  #     payload: { email: "bob@terra.com.br", password: "erva123" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "email em branco",
  #     payload: { email: "", password: "erva123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "sem o campo email",
  #     payload: { password: "erva123" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha em branco",
  #     payload: { email: "jamaica@terra.com.br", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "sem o campo senha",
  #     payload: { email: "jamaica@terra.com.br" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem de error #{e[:error]}" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
