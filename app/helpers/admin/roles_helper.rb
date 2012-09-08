module Admin::RolesHelper

  def role_people_count(ruc, id)
    w = ruc[id]
    if not w == 0 then
      "#{w} people"
    else
      ""
    end

  end

end
