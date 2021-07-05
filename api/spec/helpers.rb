module Helpers
  def get_fixture(item)
    # symbolize_name é usado para transformar cada campo do arquivo YAML para simbolo das chaves simbolizadas (Ex: :payload)
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  module_function :get_fixture
end
