Before do
  @browser = Selenium::WebDriver.for :firefox
  @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
  @login = rand(999).to_s + 'user'
  @login_roles = rand(999).to_s + 'user'
  @project = rand(999).to_s + 'project'
  @version = rand(999).to_s + 'version'
 end

After do
  @browser.quit
end

