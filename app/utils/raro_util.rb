class RaroUtil
  ABBR_MESES = ["","Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"]
  def self.to_time_desc(segundos)
    hora = Time.at(segundos).gmtime.strftime("%H")
    minuto = Time.at(segundos).gmtime.strftime("%M")
    segundo = Time.at(segundos).gmtime.strftime("%S")
    
    tempo = ""
    if hora.to_i == 1
      tempo += "#{hora} hora "
    elsif hora.to_i > 1
      tempo += "#{hora} horas "
    end
    
    tempo += "e " if tempo.present? && segundo.to_i == 0
    
    if minuto.to_i == 1
      tempo += "#{minuto} minuto "
    elsif minuto.to_i > 1
      tempo += "#{minuto} minutos "
    end
    
    tempo += "e " if tempo.present? && segundo.to_i > 0
    
    if segundo.to_i == 1
      tempo += "#{segundo} segundo"
    elsif segundo.to_i > 1
      tempo += "#{segundo} segundos"
    end
    tempo.strip
  end
  
  def self.random(size=10)
    "I#{Array.new(size){rand(size)}.join}"
  end
  
  def self.dia_semana?(data)
    !(data.saturday? || data.sunday?)
  end
  
  def self.formata_data(data,formato = "%d/%m/%Y")
    data.present? ? data.strftime(formato) : ""
  end
  
  def self.formata_moeda(valor, unit = "R$")
    ActionController::Base.helpers.number_to_currency(valor.to_f, unit: unit, :separator => ",", :delimiter => ".")
  end
  
  def self.formata_moeda_banco(valor)
    valor.to_s.gsub(".","").gsub(",",".").to_f
  end
  
  def self.formata_telefone(ddd,telefone)
    tel = ""
    if ddd.present?
      tel += "(#{RaroUtil.somente_numero(ddd)}) "
    end
    if telefone.present?
      tel += "#{RaroUtil.somente_numero(telefone).insert(4,'-')}"
    end
    tel
  end
  
  def self.somente_numero(numero)
    "#{numero}".gsub(/\D/,"")
  end
end