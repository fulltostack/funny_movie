feature 'Session' do

  given(:user) { FactoryBot.create(:user) }

  scenario 'When I\'m trying to login with empty credentials' do
    login('', '')
    expect(page).to have_content 'Email and Password are both are required'
  end

  scenario 'When I\'m trying to login with email but password as empty' do
    login(Faker::Internet.email, '')
    expect(page).to have_content 'Email and Password are both are required'
  end

  scenario 'When I\'m trying to login with empty email' do
    login('', Faker::Internet.password)
    expect(page).to have_content 'Email and Password are both are required'
  end

  scenario 'When I\'m trying to login with wrong email format' do
    login('wrong_email_format', Faker::Internet.password)
    expect(page).to have_content 'Error while creating user, please try again, error: Email is invalid'
  end

  scenario 'When I\'m trying to login with non-existent email, should create a new user' do
    expect(User.count).to eq(0)
    login(Faker::Internet.email, Faker::Internet.password)
    expect(User.count).to eq(1)
    expect(page).to have_content 'Logged in!'
  end

  scenario 'When I\'m trying to login with existing email and invalid password' do
    login(user.email, Faker::Internet.password)
    expect(page).to have_content 'Email or password is invalid'
  end

  scenario "When I\'m trying to login with existing email and password" do
    login(user.email, user.password)
    expect(page).to have_content 'Logged in!'
    expect(page).to have_content "Welcome #{user.email}"
    expect(page).to have_content 'Share'
    expect(page).to have_content 'Log Out'
  end
end
