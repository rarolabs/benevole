class LandpageController < ApplicationController
  layout "landpage"
  skip_before_filter :authenticate_usuario!, only: :index
  skip_authorize_resource only: :index
  


  def index
  end
end
