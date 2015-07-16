class UsuarioCrud < RaroCrud
  titulo "Usuários"

  link_superior "Novo Usuário", id: "novo-button", icon: "plus", link: "new", can: Proc.new {|obj| Usuario.current.ability.can?(:create, obj)}

  ordenar_por :nome
  exclusao Proc.new {|obj| obj != Usuario.current}

  acoes :qualificar, "Qualificar", Proc.new {|obj| Usuario.current.admin? && obj.atualizado?}
  
  campo_tabela :nome,  label: "Nome"
  campo_tabela :email, label: "email"

  campo_formulario :instituicao, label: "Instituição", if: Proc.new {|obj| Usuario.current.root? }
  campo_formulario :email, label: "Email", if: Proc.new {|obj| Usuario.current.admin? }
  campo_formulario :papel, label: "Função", label_method: :descricao, if: Proc.new {|obj| Usuario.current.admin? }
  campo_formulario :nome, label: "Nome", required: true, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :foto, label: "Foto", required: true, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :data_nascimento, required: true, label: "Data de nascimento", as: :string, input_html: {"data-mask" => "99/99/9999"}, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :telefone, label: "Telefone", input_html: {"data-mask" => "(99)9999-9999"}, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :celular, required: true, label: "Celular", input_html: {"data-mask" => "(99)9999-9999"}, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :facebook, label: "Facebook", if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :doador_sangue, required: true, label: "Doador de sangue?", input_html: {class: "i-checks"}, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :veiculo, required: true, label: "Como conheceu?", add_registro: false, if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :outros_veiculo, label: "Outros", if: Proc.new {|obj| Usuario.current.voluntario? }
  campo_formulario :qualificacao_list, label: "Qualificacao", if: Proc.new {|obj| false }
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
