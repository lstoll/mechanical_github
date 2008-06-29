# 
# automates the creation of a git repository on github.
require 'rubygems'
require 'mechanize'
 
class MechanicalGitHub
  # set up an agent witht the provided credentials, and log in to github with it.
  def initialize(username, password)
    @agent = WWW::Mechanize.new
    loginpage  = @agent.get('https://github.com/login')
    loginform  = loginpage.forms[0]
    
    loginform['login']    = username
    loginform['password'] = password
    loginform['remember_me'] = '1' # make the session 'stick' a little longer, hopefully.
    loginpage  = @agent.submit(loginform)
    return true
  end
  
  def create_repository(name, description, homepage)
    newpage = @agent.get('http://github.com/repositories/new')
    # create the repo
    newform  = newpage.forms[1]
    #p form
    newform['repository[name]']    = name
    newform['repository[description]'] = description
    newform['repository[homepage]'] = homepage
    newform['repository[public]'] = true #always want it to be public

    finishpage  = @agent.submit(newform)
  
    # TODO - error handle here - regex for error or somethinf
  
  end
end