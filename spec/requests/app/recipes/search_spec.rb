require 'rails_helper'

describe 'GET api/recipes/search', type: :request do
  let(:query_params) do
    {
      ingredient_search_terms: ingredient_search_terms,
      page_number: page_number,
      page_size: page_size,
    }
  end
  let(:ingredient_search_terms) { ['Milk', 'Yogurt'] }
  let(:page_number) { 1 }
  let(:page_size) { 4 }

  let(:url) do
    resource_url = URI.parse(search_api_recipes_url)
    query = {
      ingredient_search_terms: ingredient_search_terms,
      page_number: page_number,
      page_size: page_size,
    }

    resource_url.query = query.compact.to_query

    resource_url.to_s
  end

  let(:headers) do
    {
      'CONTENT-TYPE': 'application/json',
    }
  end

  let(:body_response) { JSON.parse(response.body) }

  context 'when success' do
    it 'returns status code 200' do
      get(url, headers: headers)

      expect(response).to have_http_status(200)
    end
  end

  context 'when ingredient_search_terms is missing' do
    let(:ingredient_search_terms) { nil }

    it 'returns a validation_error error with status code 422' do
      get(url, headers: headers)

      expect(body_response.dig('data', 'id')).to eq('validation_error')
      expect(response).to have_http_status(422)
    end
  end

  context 'when page_number is missing' do
    let(:page_number) { nil }

    it 'returns a validation_error error with status code 422' do
      get(url, headers: headers)

      expect(body_response.dig('data', 'id')).to eq('validation_error')
      expect(response).to have_http_status(422)
    end
  end

  context 'when page_size is missing' do
    let(:page_size) { nil }

    it 'returns a validation_error error with status code 422' do
      get(url, headers: headers)

      expect(body_response.dig('data', 'id')).to eq('validation_error')
      expect(response).to have_http_status(422)
    end
  end

  context 'when ingredient_search_terms is missing' do
    let(:ingredient_search_terms) { nil }

    it 'returns a validation_error error with status code 422' do
      get(url, headers: headers)

      expect(body_response.dig('data', 'id')).to eq('validation_error')
      expect(response).to have_http_status(422)
    end
  end

  context 'when there is an undefined error' do
    before do
      allow_any_instance_of(Recipes::Searcher).to receive(:search).and_raise(StandardError.new('Undefined error'))
    end

    it 'returns an internal_server_error error with status code 500' do
      get(url, headers: headers)

      expect(body_response.dig('data', 'id')).to eq('internal_server_error')
      expect(response).to have_http_status(500)
    end
  end
end
