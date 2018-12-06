require 'helper'

describe Yotpo::Oauth do
  describe '#generate_token' do
    before(:all) do
      generate_token_params = {
        client_id: @app_key,
        client_secret: @secret,
        grant_type: "client_credentials"
      }
      VCR.use_cassette('generate_token') do
        @response = Yotpo.generate_token(generate_token_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :access_token }
    it { should respond_to :token_type }
  end

  describe '#validate_token' do
    before(:all) do
      validate_token_params = {
          utoken: @utoken,
          app_key: @app_key
      }
      VCR.use_cassette('validate_token') do
        @response = Yotpo.validate_token(validate_token_params)
      end
    end

    subject { @response.body }
    it { should be_a ::Hashie::Mash }
    it { should respond_to :Status }
    it { should respond_to :user_id }
    it { should respond_to :user_has_access_to_account }
    it { should respond_to :application_id }
  end
end
