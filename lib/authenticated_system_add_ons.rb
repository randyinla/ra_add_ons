module AuthenticatedSystemAddOns
protected
  def check_role(role)
    unless logged_in? && @current_user.has_role?(role)
      if logged_in?
        permission_denied
      else
        store_referer
        access_denied
      end
    end
  end

  def check_administrator_role
    check_role('administrator')
  end

  def store_referer
    session[:refer_to] = request.env["HTTP_REFERER"]
  end
end