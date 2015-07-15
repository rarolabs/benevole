class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new

    alias_action :index, :show, :query, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update
    alias_action :action, :to => :create_or_update
    # alias_action :destroy_selected, :to => :destroy

    can :update, Usuario, id: usuario.id
    if usuario.root?
      can :manage, :all
    else
      if usuario.papel
        usuario.papel.permissoes.each do |permissao|
          can permissao.abilities, permissao.klass.constantize, instituicao_id: usuario.instituicao_id
        end
      end
    end
  end
end
