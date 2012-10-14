#encoding:utf-8

module VpfilesHelper

  def r28file_add_today(r28files_today)
    c = r28files_today.count
    if c == 0 then
      return "<div class='info'>Сегодня не добавлено ни одного файла</div>"
    else
      r = ""
      c = 1
      @vpfile_today.each do |f|
       link = link_to f.file_name, :controller => '/file', :action => 'file', :id => f.id
       r += render :partial => "layouts/vpfiles/file", :locals => {:f => f, :c => c, :link => link}
       c += 1
      end
      return "<div class='r28files'>" + r.html_safe + "</div>"
    end
  end

  def today_count(count)
    if count == 0 then
      ""
    else
      "<span class='label'>#{count}</span>"
    end
  end

end
