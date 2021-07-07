describe "POST /equipos" do

  # Before para pegar o id do usuario, para usar no headers do POST.
  before(:all) do
    payload = { email: "fenomeno@ig.com.br", password: "090909" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "novo equipo" do
    before(:all) do
      payload = { thumbnail: Helpers::get_thumb("kramer.jpg"),
                  name: "Kramer Eddie Van Halen",
                  category: "Cordas",
                  price: 299 }

      MongoDB.new.remove_equipo(payload[:name], @user_id)

      @result = Equipos.new.create(payload, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end
  end

  context "nao autorizado" do
    before(:all) do
      payload = { thumbnail: Helpers::get_thumb("baixo.jpg"),
                  name: "Contra Baixo",
                  category: "Cordas",
                  price: 59 }

      MongoDB.new.remove_equipo(payload[:name], @user_id)

      @result = Equipos.new.create(payload, nil)
    end

    it "deve retornar 401" do
      expect(@result.code).to eql 401
    end
  end
end
