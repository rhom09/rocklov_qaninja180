require_relative "base_api"

class Equipos < BaseApi
  def create(payload, user_id)
    # Em vez de HTTParty usa-se o self.class por conta do include HTTParty.
    return self.class.post(
             "/equipos",
             body: payload,
             headers: {
               "user_id": user_id,
             },
           )
  end
end
