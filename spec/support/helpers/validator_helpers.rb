module Helpers
  module ValidatorHelpers
    def validate_json_response(response, msg, error_attr)
      res = JSON.parse(response)
      expect(res['status']).to eq(400)
      expect(res['errors'].count).not_to eq(0)
      expect(res['errors'][error_attr]).to eq(msg)
    end

    def validate_response(url, msg, should_check_session = false, user_id = nil)
      expect(@request.session[:user_id]).to eq(user_id) if should_check_session
      expect(response.status).to eq(302)
      expect(response).to redirect_to(url)
      expect(flash[:notice]).to match(msg)
    end
  end
end
