require 'rails_helper'

describe 'Logging in' do
  it 'works' do
    get '/players/sign_in'

    expect(response).to eq 'Hello'
  end
end
