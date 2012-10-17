#encoding: utf-8

module VP

  class Files

    def self.upload(file)
      vp_file_upload = VP::FileFactory.create(file)
      vp_file_upload.work
      ##tt = `arj t #{file.original_filename}`
    end


    def self.download(id)
      if !(id.nil?) then
        vpfile = VipiskaFile.find_by_id id
        "#{Rails.root}/public/upload/#{id}/#{vpfile.file_name}"
      end
    end


  end


end

