class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior "Novo Usuário", id: "novo-button", icon: "plus", link: "new", can: Proc.new {|obj| Usuario.current.ability.can?(:create, obj)}

  ordenar_por :nome
  exclusao Proc.new {|obj| obj != Usuario.current}

  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"

  campo_formulario :instituicao, label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :qualificacao_list, label: "Qualificações", input_html: {data:{role:'tagsinput'}, placeholder: "digite a qualificação"}, value: Proc.new{|f| f.object.try(:qualificacao_list).try(:present?) ? f.object.qualificacao_list.to_s : ""}, if: Proc.new {|obj| Usuario.current.root? || Usuario.current.papel.try(:admin?) }
  campo_formulario :papel, label: "Função", label_method: :descricao, if: Proc.new {|obj| Usuario.current.root? || Usuario.current.papel.try(:admin?) }
  campo_formulario :nome, label: "Nome"
  campo_formulario :email, label: "Email"
  campo_formulario :foto, label: "Foto"
  campo_formulario :data_nascimento, label: "Data de nascimento", as: :string, input_html: {"data-mask" => "99/99/9999"}
  campo_formulario :telefone, label: "Telefone", input_html: {"data-mask" => "(99)9999-9999"}
  campo_formulario :celular, label: "Celular", input_html: {"data-mask" => "(99)9999-9999"}
  campo_formulario :facebook, label: "Facebook"
  campo_formulario :doador_sangue, label: "Doador de sangue?", input_html: {class: "i-checks"}
  campo_formulario :veiculo, label: "Como conheceu?", add_registro: false
  campo_formulario :outros_veiculo, label: "Outros"
  campo_formulario :password, label: "Senha", default_test: "12345678", edit: false
  campo_formulario :password_confirmation, label: "Confirmação Senha", default_test: "12345678", edit: false
  adicionar_endereco

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :email, label: "email"
  campo_visualizacao :papel, label: "Papel"
  campo_visualizacao :foto, label: "Foto"
  campo_visualizacao :instituicao, label: "Instituição"
  campo_visualizacao :qualificacao, label: "Qualificações", if: Proc.new {|obj| Usuario.current.root? || Usuario.current.papel.try(:admin?) }
  campo_visualizacao :endereco, label: "Endereço"

  campo_busca :nome,  label: "Nome"
  campo_busca :data_nascimento,  label: "Data nascimento"
  campo_busca :email, label: "email"
  campo_busca :descricao, label: "Função", model: "Papel", full_name: "papel_descricao", dont_assoc: true
end
