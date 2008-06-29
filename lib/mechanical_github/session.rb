module MechanicalGitHub
  class Session
    attr_reader :agent, :username, :logged_in
    
    # set up an agent witht the provided credentials, and log in to github with it.
    def initialize()
      @agent = WWW::Mechanize.new
      @logged_in = false
    end
    
    # will need to do this to access private repos or be able to create stuff.
    def login(username, password)
      @username = username
      
      loginpage  = @agent.get('https://github.com/login')
      loginform  = loginpage.forms[0]
    
      loginform['login']    = username
      loginform['password'] = password
      loginform['remember_me'] = '1' # make the session 'stick' a little longer, hopefully.
      loginpage  = @agent.submit(loginform)
      @logged_in = true
    end
  
    #
    def create_repository(repository)
      return nil unless @logged_in
      newpage = @agent.get('http://github.com/repositories/new')
      # create the repo
      newform  = newpage.forms[1]
      #p form
      newform['repository[name]']    = repository.name
      newform['repository[description]'] = repository.description
      newform['repository[homepage]'] = repository.homepage
      newform['repository[public]'] = true #always want it to be public

      finishpage  = @agent.submit(newform)
  
      # TODO - error handle here - regex for error or something. rtn the new repo if OK, nil if not.
    end
    
    def get_repository(repository_name, username=@username)
      return nil if username.nil?
      repoin = Repository.new(repository_name, '', '', username)
      repopage = @agent.get(repoin.url)
      description = repopage.search("//span[@id='repository_description']").inner_html
      homepage = repopage.search("//span[@id='repository_homepage']").inner_html
      # because the fields on a repo are currently immutable, we have to create a new repo and return
      Repository.new(repository_name, description, homepage, username, self)
    end
    
    
  end
end