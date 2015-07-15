class VeiculoCrud < RaroCrud
  titulo "Veículos"

  link_superior "Novo Veículo", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :nome
  itens_por_pagina 20
  sem_visualizacao

  campo_tabela :nome,  label: "Nome"
  campo_tabela :instituicao,  label: "Instituição"
  
  campo_formulario :instituicao,  label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :nome,  label: "Nome"

  campo_busca :nome,  label: "Nome"
  campo_busca :instituicao,  label: "Instituição"
end