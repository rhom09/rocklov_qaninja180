describe "POST /equipos" do

  # Before para pegar o id do usuario, para usar no headers do POST.
  before(:all) do
    payload = { email: "fenomeno@ig.com.br", password: "090909" }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response["_id"]
  end

  context "novo equipo" do
    before(:all) do
      # O argumento rb serve para que a imagem seja carregada corretamente e no formato binario como pede na api.
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "kramer.jpg"), "rb")

      payload = { thumbnail: thumbnail,
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
      # O argumento rb serve para que a imagem seja carregada corretamente e no formato binario como pede na api.
      thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images", "baixo.jpg"), "rb")

      payload = { thumbnail: thumbnail,
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
