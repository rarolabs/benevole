class PapelCrud < RaroCrud
  
  titulo "Funções"
  link_superior "Nova Função", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome
  edicao Proc.new {|obj| obj.chave != "admin"}
  exclusao Proc.new {|obj| obj.chave != "admin"}
  acoes :associar, "Definir permissões", Proc.new {|obj| Usuario.current.ability.can?(:create,obj) && (obj.chave != "admin" || Usuario.current.root?)}

  campo_tabela :nome,  label: "Nome"
  campo_tabela :descricao,  label: "Descrição"

  campo_formulario :nome, label: "Nome"
  campo_formulario :descricao, label: "Descrição"
  campo_formulario :chave, label: "Chave"

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :descricao,  label: "Descrição"

  campo_busca :nome,  label: "Nome"
  campo_busca :descricao,  label: "Descrição"
end