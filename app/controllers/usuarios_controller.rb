class UsuariosController < ApplicationController
  def edit
    @model = Module.const_get("usuario".camelize)
    @crud_helper = Module.const_get("usuario_crud".camelize)
    @record = Usuario.find(params[:id])
  end

  def create
    @model = Module.const_get("usuario".camelize)
    @crud_helper = Module.const_get("usuario_crud".camelize)
    @record = Usuario.new(params_usuario)
    password = SecureRandom.uuid
    @record.password = password
    @record.password_confirmation = password
    if @record.save
      @record.send_reset_password_instructions
      flash[:success] = "Usuário criado com sucesso. As instruções de acesso foi enviado ao email informado."
      redirect_to "/crud/usuario"
    else
      render "/crud/new"
    end
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(params_permitt)
      flash[:success] = "Usuário alterado com sucesso."
      redirect_to :home_index
    else
      @model = Module.const_get("usuario".camelize)
      @crud_helper = Module.const_get("usuario_crud".camelize)
      render action: :edit
    end
  end

  private
  def params_usuario
    params.require(:usuario).permit(:email, :instituicao_id, :papel_id)
  end

  private
  def params_permitt
    params.require(:usuario).permit(:email, :chave, :password, :password_confirmation)
  end
end
