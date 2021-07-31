require_relative "base_service"

class SessionsService < BaseService
  def get_user_id(email, password)
    payload = { email: email, password: password }
    # Em vez de HTTParty usa-se o self.class por conta do include HTTParty.
    result = self.class.post(
      "/sessions",
      body: payload.to_json,
      headers: {
        "Content-Type": "application/json",
      },
    )
    # Retorna somenteo id do usuario.
    return result.parsed_response["_id"]
  end
end
