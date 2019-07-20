require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }
  
  describe 'POST #create' do
    context 'with correct credential' do
      it 'should login as an existing user' do
        post :create, params: { 'email': user.email, 'password': user.password }
        validate_response(root_url, I18n.t('session.logged_in'), user.id)
      end
    
      it 'should register and login user if user does not exists' do
        expect { post :create, params: { 'email': Faker::Internet.email, 'password': Faker::Internet.password } }.to change(User, :count).by(1)
        validate_response(root_url, I18n.t('session.logged_in'), User.last.id)
      end
    end

    context 'with invalid credential' do
      it 'should not login with empty email' do
        post :create, params: { 'email': '', 'password': Faker::Internet.password }
        validate_response(root_url, I18n.t('session.empty_required_fields'))
      end
      
      it 'should not login with empty password' do
        post :create, params: { 'email': Faker::Internet.email, 'password': '' }
        validate_response(root_url, I18n.t('session.empty_required_fields'))
      end
      
      it 'should not login with invalid password' do
        post :create, params: { 'email': user.email, 'password': Faker::Internet.password }
        validate_response(root_url, I18n.t('session.invalid_email_or_pwd'))
      end
      
      it 'should not login with invalid email format' do
        post :create, params: { 'email': 'abcd', 'password': Faker::Internet.password }
        validate_response(root_url, 'Error while creating user, please try again, error: Email is invalid')
      end
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should logout a user' do
      post :create, params: { 'email': user.email, 'password': user.password }
      validate_response(root_url, I18n.t('session.logged_in'), user.id)

      delete :destroy
      validate_response(root_url, I18n.t('session.logged_out'))
    end
  end
end
