#encoding:utf-8

module Secretar::VpfilesHelper

  def r28file_add_today(r28files_today)
    c = r28files_today.count
    if c == 0 then
      return "<div class='info'>Сегодня не добавлено ни одного файла</div>"
    else
      r = ""
      c = 1
      @vpfile_today.each do |f|
       link = link_to "Загрузить", :controller => 'secretar/vpfiles', :action => 'file', :id => f.id
       r += "
                 <div id='r28file_#{c}' class='r28file' data-id='#{f.id}'>
                   <div class='type'>#{f.file_ext}</div>
                   <div class='name'>
                     <div>#{f.file_name_ex}</div>
                     <div class=""><span>#{f.files_count_in} файлов</span><span>#{f.file_size}</span></div>
                   </div>
                   <div class='data'>#{f.file_data}</div>
                   <div class='flex'></div>
                   <div class='download'>#{link}</div>
                 </div>
       "
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
