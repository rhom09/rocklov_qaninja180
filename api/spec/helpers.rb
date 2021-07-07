module Helpers
  def get_fixture(item)
    # symbolize_name é usado para transformar cada campo do arquivo YAML para simbolo das chaves simbolizadas (Ex: :payload)
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  def get_thumb(file_name)
    # O argumento rb serve para que a imagem seja carregada corretamente e no formato binario como pede na api.
    return File.open(File.join(Dir.pwd, "spec/fixtures/images", file_name), "rb")
  end

  module_function :get_fixture
  module_function :get_thumb
end
