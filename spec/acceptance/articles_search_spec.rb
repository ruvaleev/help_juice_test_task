# frozen_string_literal: true

require_relative 'acceptance_helper'

describe 'Articles search', '
  In order to find articles
  As User
  I want to be able to use search form
', type: :feature do
  let!(:articles) { create_list(:article, rand(2..3)) }
  let(:target_article) { articles.sample }

  before { visit root_path }

  context "when user doesn't fill search form" do
    it 'User can see all articles' do
      articles.map(&:title).each do |title|
        expect(page).to have_text(title)
      end
    end
  end

  context 'when user fills search form with non found value', js: true do
    before do
      fill_in 'query', with: SecureRandom.hex
      find("input[name='commit']").click
    end

    it "User doesn't see any of articles on the page" do
      articles.map(&:title).each do |title|
        expect(page).not_to have_text(title)
      end
    end
  end

  context 'when user fills search form with existing value', js: true do
    before do
      fill_in 'query', with: target_article.title
      find("input[name='commit']").click
    end

    it "User sees only target article on the page" do
      (articles - [target_article]).map(&:title).each do |title|
        expect(page).not_to have_text(title)
      end

      expect(page).to have_text(target_article.title)
    end
  end

  context "when user doesn't submit form by button", js: true do
    before do
      fill_in 'query', with: target_article.title
      sleep(1)
    end

    it "User sees only target article on the page" do
      (articles - [target_article]).map(&:title).each do |title|
        expect(page).not_to have_text(title)
      end

      expect(page).to have_text(target_article.title)
    end
  end
end
