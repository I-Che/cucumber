
Given(/^Register random user$/) do
  @browser.get 'http://demo.redmine.org'
  @browser.find_element(:class, 'register').click
  hash = {user_login:@login,
          user_password: 'password',
          user_password_confirmation: 'password',
          user_firstname: 'firstname',
          user_lastname: 'lastname',
          user_mail: @login + '@bla.bla'}
    hash.each_pair do |key,value|
    @browser.find_element(:id, key).send_keys value
  end
    @browser.find_element(:name, 'commit').click
end

Then(/^Add new user$/) do
  expect(@browser.find_element(:class, 'active').text).to include @login
end

When(/^Logout\-login$/) do
  @browser.find_element(:class, 'logout').click
  sleep (2)
  @browser.find_element(:class, 'login').click
  sleep (2)
  @browser.find_element(:id, 'username').send_keys @login
  @browser.find_element(:id, 'password').send_keys 'password'
  @browser.find_element(:name, 'login').click
end

Then(/^New user is login$/) do
  expect(@browser.find_element(:class, 'active').text).to include @login

end

When(/^Change user password$/) do
  @browser.find_element(:class,'my-account').click
  sleep (2)
  @browser.find_element(:class, 'icon-passwd').click
  sleep (3)
  @browser.find_element(:id, 'password').send_keys 'password'
  @browser.find_element(:id, 'new_password').send_keys 'password1'
  @browser.find_element(:id, 'new_password_confirmation').send_keys 'password1'
  @browser.find_element(:name, 'commit').click
  end

Then(/^User password was changed$/) do
  expect(@browser.find_element(:id, 'flash_notice').text).to include 'Пароль успешно обновлён.' #'Password was successfully updated.'
  end

When(/^Creating project and project version$/) do
  @browser.find_element(:class, 'projects').click
  sleep (3)
  @browser.find_element(:class, 'icon-add') .click
  sleep (2)
  @browser.find_element(:id, 'project_name').send_keys @project
  @browser.find_element(:id, 'project_identifier').send_keys @project
  @browser.find_element(:name, 'commit').click
  @browser.find_element(:id, 'tab-versions').click
  sleep (2)
  @browser.find_element(:xpath, "//*[@id='tab-content-versions']/p[2]/a").click
  @browser.find_element(:id, 'version_name').send_keys @version
  @browser.find_element(:name, 'commit').click
 end

Then(/^Project version is created$/) do
   expect(@browser.find_element(:id, 'flash_notice').text).to include 'Создание успешно.' #'Successful creation.'
end

When(/^Add random user to the project and edit his roles$/) do
  @browser.find_element(:class, 'logout').click
  sleep (2)
  @browser.find_element(:class, 'register').click
  @wait.until {@browser.find_element(:id => 'user_login').displayed?}
  @browser.find_element(:id, 'user_login').send_keys @login_roles
  @browser.find_element(:id, 'user_password').send_keys 'password'
  @browser.find_element(:id, 'user_password_confirmation').send_keys 'password'
  @browser.find_element(:id, 'user_firstname').send_keys 'firstname'
  @browser.find_element(:id, 'user_lastname').send_keys 'lastname'
  @browser.find_element(:id, 'user_mail').send_keys @login_roles + '@bla.bla'
  @browser.find_element(:name, 'commit').click
  @browser.find_element(:class, 'projects').click
  sleep (3)
  @browser.find_element(:class, 'icon-add') .click
  sleep (2)
  @browser.find_element(:id, 'project_name').send_keys @project
  @browser.find_element(:id, 'project_identifier').send_keys @project
  @browser.find_element(:name, 'commit').click
  @wait.until {@browser.find_element(:id => 'tab-members').displayed?}
  @browser.find_element(:id, 'tab-members').click
  @browser.find_element(:xpath, "//*[@id='tab-content-members']/p/a").click
  @wait.until {@browser.find_element(:id => 'principal_search').displayed?}
  @browser.find_element(:id, 'principal_search').send_keys @login
  sleep (2)
  @browser.find_element(:xpath, "//*[@id='principals']/label").click
  @browser.find_element(:xpath, "//*[@id='new_membership']/fieldset[2]/div/label[1]/input").click
  @browser.find_element(:id, 'member-add-submit').click
  sleep (2)
  @browser.find_element(:xpath, "(.//*[@class='icon icon-edit'])[1]").click
  @browser.find_element(:xpath, "(.//input[@value='4'])").click
  @browser.find_element(:xpath, "(.//*[@class='small'])[2]").click
  sleep (2)

end

Then(/^User's role was edited from manager to developer$/) do
  @wait.until{element = @browser.find_element(:xpath => "//span[contains (., 'Developer')]").displayed?}
  puts 'User role was edited from manager to developer'
end

When(/^Creating bug, feature and support issue$/) do
  @browser.find_element(:class, 'projects').click
  sleep (3)
  @browser.find_element(:class, 'icon-add') .click
  sleep (2)
  @browser.find_element(:id, 'project_name').send_keys @project
  @browser.find_element(:id, 'project_identifier').send_keys @project
  @browser.find_element(:name, 'commit').click
  sleep (2)
  @browser.find_element(:class, 'new-issue').click
  @wait.until {@browser.find_element(:id => 'issue_subject').displayed?}
  @browser.find_element(:id, 'issue_subject').send_keys 'bug'
  @browser.find_element(:name, 'continue').click
  sleep (2)
  option = Selenium::WebDriver::Support::Select.new(@browser.find_element(:css => "#issue_tracker_id"))
  option.select_by(:text, "Feature")
  @wait.until {@browser.find_element(:id => 'issue_subject').displayed?}
  @browser.find_element(:id, 'issue_subject').send_keys 'feature'
  @browser.find_element(:name, 'continue').click
  sleep (2)
  option = Selenium::WebDriver::Support::Select.new (@browser.find_element(:css => "#issue_tracker_id"))
  option.select_by(:text, "Support")
  @wait.until {@browser.find_element(:id => 'issue_subject').displayed?}
  sleep (2)
  @browser.find_element(:id, 'issue_subject').send_keys 'support'
  @browser.find_element(:name, 'continue').click
  @browser.find_element(:class, 'issues').click
  sleep (2)
end

Then(/^All types of issues are visible on Issues_ tab$/) do
  @wait.until {element = @browser.find_element(:xpath => "//td[contains (., 'Bug')]").displayed?}
  puts 'Test Passed: Issue Bug found'
  sleep (2)
  @wait.until {element = @browser.find_element(:xpath => "//td[contains (., 'Feature')]").displayed?}
  puts 'Test Passed: Issue Feature found'
  @wait.until {element = @browser.find_element(:xpath => "//td[contains (., 'Support')]").displayed?}
  puts 'Test Passed: Issue Support found'
end