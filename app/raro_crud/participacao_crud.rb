class ParticipacaoCrud < RaroCrud
  titulo "Participacao"

  ordenar_por :nome

  campo_busca :nome, label: "Nome", model: "Usuario", full_name: "usuario_nome", dont_assoc: true
  campo_busca :id, label: "Ação", model: "Participacao", full_name: "q[acao_id_eq]", as: :select, collection: Acao.all.map{|a| [a.id, a.nome]}, dont_assoc: true
  campo_busca :state, label: "Tipo ação", as: :select, collection: [["", "Confirmada"],["presente", "Presente"]]
end
