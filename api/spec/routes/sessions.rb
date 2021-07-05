require_relative "base_api"

class Sessions < BaseApi
  def login(payload)
    # Em vez de HTTParty usa-se o self.class por conta do include HTTParty.
    return self.class.post(
             "/sessions",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
