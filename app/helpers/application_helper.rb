module ApplicationHelper

  def menu_select(name, m, menu)
    r = ''
    if m == menu
       r = '<li style="padding-right: 10px; padding-left: 10px;"><span style="position: relative; top: 8px; color:white; font-weight: bold;">' + name + '</span></li>'
    else
       r = '<li style="margin-right: 5px;">' + link_to(name, :controller => "admin/"+menu, :action => "index") + '</li>'
    end
    return r.html_safe
  end

end
