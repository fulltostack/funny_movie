module Helpers
  module ValidatorHelpers
    def validate_response(url, msg, user_id = nil)
      expect(@request.session[:user_id]).to eq(user_id)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(url)
      expect(flash[:notice]).to match(msg)
    end
  end
end
