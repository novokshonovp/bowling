# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::Contracts::ContractError, with: :contract_error
  rescue_from ::Cmd::CmdError, with: :cmd_error

  def record_not_found
    head :not_found
  end

  def contract_error(exception)
    render json: exception.resource.errors.to_h, status: :unprocessable_entity
  end

  def cmd_error(exception)
    render json: exception.resource.errors.to_h, status: :unprocessable_entity
  end
end
