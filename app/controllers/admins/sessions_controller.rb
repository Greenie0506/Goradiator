class Admins::SessionsController < Devise::SessionsController
  layout "admin"

  def after_sign_in_path_for(resource_or_scope)
    manages_path
  end
end
