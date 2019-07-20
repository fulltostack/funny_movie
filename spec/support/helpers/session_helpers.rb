module Helpers
  module SessionHelpers
    def login(email, password)
      visit root_path
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_button 'Log In'
    end
  end
end
