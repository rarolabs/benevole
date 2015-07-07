class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior "Novo Usuário", id: "novo-button", icon: "plus", link: "new"

  ordenar_por :nome

  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"

  campo_formulario :nome, label: "Nome"
  campo_formulario :email, label: "Email"
  campo_formulario :foto, label: "Foto"
  campo_formulario :instituicao, label: "Instituição"
  campo_formulario :qualificacao_list,  label: "Qualificações", input_html: {data:{role:'tagsinput'}, placeholder: "digite a qualificação"}, value: Proc.new{|f| f.object.try(:qualificacao_list).try(:present?) ? f.object.qualificacao_list.to_s : ""}
  campo_formulario :password, label: "Senha", default_test: "12345678", edit: false
  campo_formulario :password_confirmation, label: "Confirmação Senha", default_test: "12345678", edit: false
  campo_formulario :papel, label: "Papel", label_method: :descricao
  adicionar_endereco

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :email, label: "email"
  campo_visualizacao :papel, label: "Papel"
  campo_visualizacao :foto, label: "Foto"
  campo_visualizacao :instituicao, label: "Instituição"
  campo_visualizacao :qualificacao,  label: "Qualificações"
  campo_visualizacao :endereco, label: "Endereço"

  campo_busca :nome,  label: "Nome"
  campo_busca :email, label: "email"
  campo_busca :papel_id,  label: "Papel"

end
