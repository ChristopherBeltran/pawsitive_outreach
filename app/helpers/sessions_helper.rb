module SessionsHelper

  def admin_page?
    if request.url.include? "admin"
      return true
    end 
  end



end
