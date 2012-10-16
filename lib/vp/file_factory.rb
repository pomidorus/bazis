module VP

  #----------------------------------------------
  class FileFactory

    def self.create(file)
      VP::FileR28.new if check_ext?(file, "r28")
      VP::File004.new if check_ext?(file, "004")
    end

    def self.check_ext?(file, ext)
      e = file.original_filename[-3,3].downcase
      e == ext ? true : false
    end

  end

  #----------------------------------------------
  class VPFile

  end

  #----------------------------------------------
  class FileR28 < VPFile

  end

  #----------------------------------------------
  class File004 < VPFile

  end


end
