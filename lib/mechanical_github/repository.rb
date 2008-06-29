module MechanicalGitHub
  
  # represents a project
  class Repository
    attr_reader :name, :description, :homepage, :username
    
    def initialize(name, description, homepage, username=nil, session=nil)
      @name = name
      @description = description
      @homepage = homepage
      @username = username
      @session = session
    end
    
    def url
      "https://github.com/#{@username}/#{@name}"
    end
    
    def wiki
      Wiki.new(self, @session)
    end
    
  end
end