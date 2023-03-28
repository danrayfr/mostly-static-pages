require "jwt"
class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      session: session,
      current_user: current_user,
      request: request,
      response: response,
    }
    result = StaticAppSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  def current_user
    # return unless session[:token]
    secret_key = Rails.application.credentials.secret_key_base
    token = get_bearer_token
    return unless token.present?

    algorithm = 'HS256'
    decoded_token = JWT.decode(token, secret_key, true, { algorithm: algorithm })
    user_id = decoded_token.first["user_id"]
    User.find_by(id: user_id)
  rescue JWT::DecodeError => e
    nil

    # crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    # token = crypt.decrypt_and_verify session[:token]
    # user_id = token.gsub('user-id:', '').to_i
    # User.find user_id
  # rescue ActiveSupport::MessageVerifier::InvalidSignature
  end

  def get_bearer_token
    bearer = request.headers['Authorization'] || request.headers['authorization']
    if bearer.present?
      token = bearer.gsub('Bearer ', '').strip
      token = token.undump
      token
    else 
      nil
    end
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
