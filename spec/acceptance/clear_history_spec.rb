# frozen_string_literal: true

require_relative 'acceptance_helper'

describe 'Search history', '
  In order to clear search history
  As User (or service provider manager)
  I want to be able to destroy all of my article_queries
', type: :feature, js: true do

  let(:search_query) { SecureRandom.hex }

  before do
    visit root_path
    fill_new_query(search_query)
  end

  it "User can clear all of his queries by click on 'clear' button" do
    expect(page).to have_text(search_query)
    find("a[data-search-target='clear_button']").click
    expect(page).not_to have_text(search_query)
  end
end
