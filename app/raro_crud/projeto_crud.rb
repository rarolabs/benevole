class ProjetoCrud < RaroCrud
  titulo "Projetos"

  link_superior "Novo Projeto", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :nome
  itens_por_pagina 20

  campo_tabela :nome,  label: "Nome"
  campo_tabela :descricao,  label: "Descrição"

  campo_formulario :instituicao,  label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :nome,  label: "Nome"
  campo_formulario :descricao,  label: "Descrição"
  
  campo_visualizacao :instituicao,  label: "Instituição"
  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :descricao,  label: "Descrição", input_html: {rows: 5}

  campo_busca :nome,  label: "Nome"
end