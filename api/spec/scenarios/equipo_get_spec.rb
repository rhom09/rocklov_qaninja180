describe "GET /equipos/{equipo_id}" do
  before(:all) do
    payload = { email: "fenomeno@ig.com.br", password: "090909" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter unico equipo" do
    before(:all) do
      # Dado que eu tenho um novo equipamento
      @payload = { thumbnail: Helpers::get_thumb("sanfona.jpg"),
                   name: "Sanfona",
                   category: "Outros",
                   price: 499 }

      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      # E eu tenho o id desse equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response["_id"]

      # Quando faço uma requisição get por id
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar o nome" do
      expect(@result.parsed_response).to include("name" => @payload[:name])
    end
  end

  context "equipo nao existe" do
    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it "deve retornar 404" do
      expect(@result.code).to eql 404
    end
  end
end

describe "GET /equipos" do
  before(:all) do
    payload = { email: "flash@ig.com.br", password: "pwd123" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "obter uma lista" do
    before(:all) do
      payloads = [{
        thumbnail: Helpers::get_thumb("sanfona.jpg"),
        name: "Sanfona",
        category: "Outros",
        price: 499,
      }, {
        thumbnail: Helpers::get_thumb("telecaster.jpg"),
        name: "Telecaster",
        category: "Cordas",
        price: 299,
      }, {
        thumbnail: Helpers::get_thumb("violao-nylon.jpg"),
        name: "Violao Nylon",
        category: "Cordas",
        price: 99,
      }]

      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end

      # Quando faço uma requisição get para /equipos
      @result = Equipos.new.list(@user_id)
    end

    it "deve retornar 200" do
      expect(@result.code).to eql 200
    end

    it "deve retornar uma lista de equipos" do
      expect(@result.parsed_response).not_to be_empty
    end
  end
end
