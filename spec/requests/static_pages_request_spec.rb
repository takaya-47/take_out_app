require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  it 'homeアクションにリクエストすると正常にレスポンスが返ってくる' do
    get root_path
    expect(response.status).to eq 200
  end
end
