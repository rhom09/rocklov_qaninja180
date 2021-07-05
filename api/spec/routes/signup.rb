require_relative "base_api"

class Signup < BaseApi
  def create(payload)
    # Em vez de HTTParty usa-se o self.class por conta do include HTTParty.
    return self.class.post(
             "/signup",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
