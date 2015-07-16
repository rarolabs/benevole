class VeiculoCrud < RaroCrud
  titulo "Veículos"

  link_superior "Novo Veículo", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :nome
  itens_por_pagina 20
  sem_visualizacao

  campo_tabela :nome,  label: "Nome"
  campo_tabela :instituicao,  label: "Instituição", sort_field: :instituicao_nome
  
  campo_formulario :instituicao,  label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :nome,  label: "Nome"

  campo_busca :nome,  label: "Nome"
  campo_busca :nome,  label: "Instituição", model: "Instituicao", full_name: "instituicao_nome", dont_assoc: true
end