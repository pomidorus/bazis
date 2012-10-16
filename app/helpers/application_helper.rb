module ApplicationHelper

  def menu_select(name, m, menu, role='admin')
    r = ''
    if m == menu
       r = "<li class='menu'><span>" + name + "</span></li>"
    else
       r = '<li>' + link_to(name, :controller => role + "/" + menu, :action => "index") + '</li>'
    end
    return r.html_safe
  end


end
