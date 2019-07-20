feature 'Landing page' do

  background do 
    user ||= FactoryBot.create :user
    login(user.email, user.password)
  end

  scenario 'visit the landing page after login' do
    visit root_path
    expect(page).to have_content 'Log Out'
    expect(page).to have_content 'No video shared yet :('
  end


  scenario 'visit share page after login' do
    visit share_path
    expect(page).to have_content 'Share a Youtube video:'
  end
end
