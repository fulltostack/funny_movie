feature 'Share' do

  background do
    user ||= FactoryBot.create :user
    login(user.email, user.password)
  end

  scenario 'When I\'m trying to share without adding url, it throws error' do
    visit share_path
    click_button 'Share'
    expect(page).to have_content "Url can't be blank and Url is invalid"
  end

  scenario 'When I\'m trying to share with invalid url, it throws error' do
    visit share_path
    fill_in 'youtube_video[url]', with: 'wrong_url'
    click_button 'Share'
    expect(page).to have_content "Url is invalid"
  end

  scenario 'When I\'m trying to share valid url, it creates record and redirects to root path' do
    visit share_path
    fill_in 'youtube_video[url]', with: 'https://youtu.be/G9TdA8d5aaU'
    click_button 'Share'
    expect(page.current_path).to eq root_path
    expect(page).to have_content "Youtube video record has been created successfully."
  end

  scenario "When I share youtube video with valid URL, page should have title, desciption and un-voted status" do
    visit share_path
    fill_in 'youtube_video[url]', with: 'https://youtu.be/G9TdA8d5aaU'
    click_button 'Share'
    expect(page.current_path).to eq root_path
    expect(page).to have_content('(un-voted)')
    expect(page).to have_css('body > main > div.video-list > div.list-items > div.video-details > h3', text: 'Apple at Work — The Underdogs')
  end
end
