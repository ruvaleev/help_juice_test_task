# frozen_string_literal: true

require_relative 'acceptance_helper'

describe 'Search history', '
  In order to see search history
  As User (or service provider manager)
  I want to be able to see correct statistics about my queries
', type: :feature, js: true do

  before { visit root_path }

  context "when user fills search form with one attempt" do
    let(:search_query) { SecureRandom.hex }

    before { fill_new_query(search_query) }

    it 'User can see history of own queries' do
      within '#queries_history' do
        expect(page).to have_text(search_query)
      end
    end
  end

  context 'when user types one query with few attempts' do
    let(:attempt_1_query) { 'what is' }
    let(:attempt_2_query) { 'What is a' }
    let(:attempt_3_query) { 'What is a good car?' }

    before do
      fill_new_query(attempt_1_query)
      fill_new_query(attempt_2_query)
      fill_new_query(attempt_3_query)
    end

    it 'saves only result query' do
      within '#queries_history' do
        expect(page).to have_text(attempt_3_query)
        expect(page).to have_selector('.query', count: 1)
      end
    end
  end

  context 'when user types with backspaces but it still one query' do
    let(:attempt_1_query) { 'how is' }
    let(:attempt_2_query) { 'Howis emil hajric' }
    let(:attempt_3_query) { 'How is emil hajric doing?' }

    before do
      fill_new_query(attempt_1_query)
      fill_new_query(attempt_2_query)
      fill_new_query(attempt_3_query)
    end

    it 'saves only result query' do
      within '#queries_history' do
        expect(page).to have_text(attempt_3_query)
        expect(page).to have_selector('.query', count: 1)
      end
    end
  end

  context 'when user types, removes query and types again' do
    let(:attempt_1_query) { 'how is' }
    let(:attempt_2_query) { 'how' }
    let(:attempt_3_query) { '' }
    let(:attempt_4_query) { 'what' }

    before do
      fill_new_query(attempt_1_query)
      fill_new_query(attempt_2_query)
      fill_new_query(attempt_3_query)
      fill_new_query(attempt_4_query)
    end

    it 'saves both queries in their actual state' do
      within '#queries_history' do
        expect(page).to have_text(attempt_1_query)
        expect(page).to have_text(attempt_4_query)
        expect(page).to have_selector('.query', count: 2)
      end
    end
  end
end
