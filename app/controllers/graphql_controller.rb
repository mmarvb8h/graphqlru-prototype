class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    # I get current user from
    # header token in the ApplicationController. Each individual
    # graphql query/mutation will have to verify. This pattern will allow
    # the signup mutation to ignore verification while the others
    # enforce it.
    context = {
      # Query context goes here, for example:
      authentication: current_authentication,
    }
    result = LibraryAppGraphqlSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue ArgumentError => e
    # Handle authentication failures coming from graphql queries/mutations. 
    render(json: {}, status: :unauthorized) if e.message == 'AuthenticationError'
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
