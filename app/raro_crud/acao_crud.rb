class AcaoCrud < RaroCrud
  titulo "Ações"

  link_superior "Nova Ação", id: "novo-button", icon: "plus", link: "new", can: Proc.new {|obj| Usuario.current.ability.can?(:create, Acao)}
  
  ordenar_por :nome
  itens_por_pagina 20

  acoes :convidar_usuarios, "Convidar", Proc.new{|a| ((a.nova? || a.em_andamento?) && Usuario.current.ability.can?(:create, a))}
  acoes :iniciar!, "Iniciar", Proc.new{|a| a.nova? && Usuario.current.ability.can?(:create, a)}
  acoes :cancelar!, "Cancelar", Proc.new{|a| ((a.nova? || a.em_andamento?) && Usuario.current.ability.can?(:create, a))}
  acoes :concluir_acao, "Concluir", Proc.new{|a| a.em_andamento? && Usuario.current.ability.can?(:create, a)}

  campo_tabela :nome,  label: "Nome"
  campo_tabela :data_inicio,  label: "Data início", date_format: "%d/%m/%Y"
  campo_tabela :data_fim,  label: "Data fim", date_format: "%d/%m/%Y"

  campo_formulario :instituicao,  label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :projeto,  label: "Projeto"
  campo_formulario :nome,  label: "Nome"
  campo_formulario :quantidade_voluntario,  label: "Quantidade voluntário"
  campo_formulario :data_inicio,  label: "Data início", as: :string, input_html: {class: "datepicker"}
  campo_formulario :data_fim,  label: "Data fim", as: :string, input_html: {class: "datepicker"}
  campo_formulario :horario,  label: "Horário"
  campo_formulario :descricao,  label: "Descrição", input_html: {rows: 5}
  campo_formulario :observacao,  label: "Orientação", input_html: {rows: 5}
  campo_formulario :usuarios,  label: "Participantes", as: :hidden
  adicionar_endereco

  campo_visualizacao :state,  label: "Status"
  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :instituicao,  label: "Instituição"
  campo_visualizacao :quantidade_voluntario,  label: "Quantidade voluntario"
  campo_visualizacao :data_inicio,  label: "Data início"
  campo_visualizacao :data_fim,  label: "Data fim"
  campo_visualizacao :horario,  label: "Horário"
  campo_visualizacao :endereco,  label: "Endereco"
  campo_visualizacao :descricao,  label: "Descrição"
  campo_visualizacao :observacao,  label: "Orientação"

  campo_busca :nome,  label: "Nome"
  campo_busca :quantidade_voluntario,  label: "Quantidade voluntário"
  campo_busca :data_inicio,  label: "Data início"
  campo_busca :data_fim,  label: "Data fim"
  campo_busca :horario,  label: "Horário"
  
  escopos [[:nova, "Novas"], [:em_andamento, "Em andamento"], [:concluida, "Concluídas"], [:cancelada, "Canceladas"]]
end