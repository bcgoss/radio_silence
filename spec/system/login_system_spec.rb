describe 'Authentication' do
  it 'creates players' do
    # As a new player,
    # When I visit /sign_in
    visit '/'
    click_on 'Sign in'
    # I should see "Create account"
    expect(page).to have_text 'Sign up'
    # When I create an account
    click_on 'Sign up'
    fill_in 'Email', with: 'fake@example.com'
    fill_in 'Password', with: 'Password1'
    fill_in 'Password confirmation', with: 'Password1'
    click_on 'Sign up'
    # I should be logged in
    expect(page).to have_text 'Welcome! You have signed up successfully'
    # When I visit /logout
    click_on 'Sign out'
    # I should be logged out
    expect(page).to have_text 'Signed out successfully'
    # When I visit /login
    click_on 'Sign in'
    # I should be able to log in.
    fill_in 'Email', with: 'fake@example.com'
    fill_in 'Password', with: 'Password1'
    click_on 'Log in'

    expect(page).to have_text 'Signed in successfully'
  end
end
