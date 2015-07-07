class AcaoCrud < RaroCrud
  titulo "Ações"

  link_superior "Nova Ação", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :nome
  itens_por_pagina 20

  acoes :convidar_usuarios, "Convidar"

  campo_tabela :nome,  label: "Nome"
  campo_tabela :data_inicio,  label: "Data início", date_format: "%d/%m/%Y"
  campo_tabela :data_fim,  label: "Data fim", date_format: "%d/%m/%Y"

  campo_formulario :nome,  label: "Nome"
  campo_formulario :quantidade_voluntario,  label: "Quantidade voluntário"
  campo_formulario :data_inicio,  label: "Data início", as: :string, input_html: {class: "datepicker"}
  campo_formulario :data_fim,  label: "Data fim", as: :string, input_html: {class: "datepicker"}
  campo_formulario :horario,  label: "Horário"
  campo_formulario :descricao,  label: "Descrição"
  campo_formulario :observacao,  label: "Observação"
  adicionar_endereco

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :instituicao,  label: "Instituicao"
  campo_visualizacao :quantidade_voluntario,  label: "Quantidade voluntario"
  campo_visualizacao :data_inicio,  label: "Data início"
  campo_visualizacao :data_fim,  label: "Data fim"
  campo_visualizacao :horario,  label: "Horário"
  campo_visualizacao :endereco,  label: "Endereco"
  campo_visualizacao :descricao,  label: "Descrição"
  campo_visualizacao :observacao,  label: "Observação"

  campo_busca :nome,  label: "Nome"
  campo_busca :quantidade_voluntario,  label: "Quantidade voluntário"
  campo_busca :data_inicio,  label: "Data início"
  campo_busca :data_fim,  label: "Data fim"
  campo_busca :horario,  label: "Horário"
end