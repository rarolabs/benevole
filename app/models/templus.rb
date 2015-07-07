class Templus
  @@nome_aplicacao = "Bénévole"
  @@nome_empresa = "Bénévole"
  @@logo = 'logo.png'
  @@logo_menor = 'logo.png'
  @@logo_rodape = 'raro_azul.png'
  @@logo_landpage = 'logo.png'
  @@favicon = 'favicon.ico'
  @@paragrafo_login = ""

  def self.nome_aplicacao
    @@nome_aplicacao
  end

  def self.nome_empresa
    @@nome_empresa
  end

  def self.logo
    @@logo
  end

  def self.logo_menor
    @@logo_menor
  end
  
  def self.logo_rodape
    @@logo_rodape
  end
  
  def self.logo_landpage
    @@logo_landpage
  end
  
  def self.paragrafo_login
    @@paragrafo_login
  end
  
  def self.favicon
    @@favicon
  end
end