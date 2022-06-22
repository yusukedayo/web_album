# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'welcome_pages', type: :system do
  describe 'ログインする前' do
    context 'root_pathに遷移する' do
      it 'トップページが表示される' do
        visit root_path
        expect(current_path).to eq root_path
      end
    end
  end
end
