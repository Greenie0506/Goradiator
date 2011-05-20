class HomeController < ApplicationController

  def index
    @sponsors = APP_CONFIG['sponsors']
  end

end
