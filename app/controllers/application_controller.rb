class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_usuario!, :unless => :devise_controller?
  before_filter :redirect_if_update_user
  around_filter :set_current_usuario
  
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html {
        flash[:notice] = "Acesso negado!"
        redirect_to main_app.root_path
      }
      format.js {
        flash.now[:notice] = "Acesso negado!"
        render "shared/acesso_negado"
      }
      format.pdf {
        flash[:notice] = "Acesso negado!"
        redirect_to main_app.root_path
      }
    end
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  def set_current_usuario
    Usuario.current = current_usuario
    yield 
  ensure
    Usuario.current = nil
  end
  
  def query
    @resource = Module.const_get(params[:model].classify)
    @q = @resource.search(params[:q])
    @q.sorts = 'updated_at desc' if @q.sorts.empty?
    results = @q.result(distinct: true).accessible_by(current_ability).page(params[:page])
    instance_variable_set("@#{params[:var]}", results)
    unless request.wiselinks_partial?
      if request[:controller] == "crud"
        redirect_to "/#{request[:controller]}/#{params[:model]}"
      else
        redirect_to "/#{request[:controller]}"
      end
    else
      render :partial => params[:partial]
    end
  end
  
  def redirect_if_update_user
    return true if ((params[:controller] == 'crud' && params[:model] == "usuario") || (params[:controller] == "devise/sessions" && params[:action] == "destroy") || (params[:controller] == 'api/cidades' && params[:action] == "busca"))
    if current_usuario.present? && !current_usuario.atualizado?
      flash[:notice] = "Por favor atualize seus dados para continuar"
		  redirect_to "/crud/usuario/#{current_usuario.id}/edit"
    end
  end
  
  
end
