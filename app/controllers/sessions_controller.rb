class SessionsController < ApplicationController
  before_action :validate_params, only: :create

  def new; end

  def create
    user = User.find_or_initialize_by(email: params[:email])
    if user.new_record?
      user.password = params[:password]
      return redirect_to root_url, notice: t('session.user_creation_error', error: user.errors.full_messages.to_sentence) unless user.save
    end
    return redirect_to root_url, notice: t('session.invalid_email_or_pwd') unless user.authenticate(params[:password])

    session[:user_id] = user.id
    redirect_to root_url, notice: t('session.logged_in')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('session.logged_out')
  end

  private

  def validate_params
    return redirect_to root_url, notice: t('session.empty_required_fields') unless required_params_present?
  end

  def required_params_present?
    params[:email].present? && params[:password].present?
  end

end
