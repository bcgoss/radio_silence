require 'rails_helper'
require 'system/shared_examples/navbar_spec_shared'

describe 'Navbar basic test' do
    page_url = '/' 
    let(:player) { create :player }
    
    context 'when a player is logged in' do
        it_behaves_like 'Navbar when logged in', page_url
    end
    
    context 'when a player is not logged in' do
        it_behaves_like 'Navbar when not logged in', page_url
    end
end