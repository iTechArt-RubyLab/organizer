require 'rails_helper'

RSpec.describe StaticPagesController do
  describe '#home' do
    context 'main page' do
      it 'renders template' do
        get 'home'
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#about' do
    context 'about page' do
      it 'renders template' do
        get 'about'
        expect(response).to have_http_status(200)
      end
    end
  end
end
