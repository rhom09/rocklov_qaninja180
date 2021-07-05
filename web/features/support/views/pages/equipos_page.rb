class EquiposPage
  include Capybara::DSL

  def create(equipo)
    # Checkpoint com timeout explicito
    page.has_css?("#equipoForm")

    # Só vai implementar a foto se for maior que 0, lá no cadstro-anuncios.feature
    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]
    select_categoria(equipo[:categoria]) if equipo[:categoria].length > 0
    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  def select_categoria(categoria)
    find("#category").find("option", text: categoria).select_option
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name

    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
