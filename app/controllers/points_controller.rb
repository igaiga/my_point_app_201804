class PointsController < ApplicationController
  include Swagger::PointsApi

  # GET /users/1/points/points.json
  def show
    user_id = params.permit(:user_id, :format)[:user_id]
    user = User.find(user_id) # TODO: token
    respond_to do |format|
      format.json { render json: { points: user.point }, status: :ok }
    end
  end

  # POST /users/1/points/decrease.json, {"point": 10}
  def decrease
    user_id = params.permit(:user_id, :format)[:user_id]
    point = params.permit(:point)[:point].to_i
    raise ArgumentError.new("ポイントはプラスの値で頼むで") if point.nil? || point <= 0
    remain_point = ActiveRecord::Base.transaction do
      user = User.lock.find(user_id) # TODO: token
      raise ArgumentError.new("ポイントが足りません") if point > user.point
      user.decrease_point(point)
      user.point
    end
    respond_to do |format|
      format.json { render json: { points: remain_point }, status: :ok }
    end
  end

  # POST /users/1/points/increase.json, {"point": 10}
  def increase
    user_id = params.permit(:user_id, :format)[:user_id]
    point = params.permit(:point)[:point].to_i
    raise ArgumentError.new("ポイントはプラスの値で頼むで") if point.nil? || point <= 0
    remain_point = ActiveRecord::Base.transaction do
      user = User.lock.find(user_id) # TODO: token
      user.increase_point(point)
      user.point
    end
    respond_to do |format|
      format.json { render json: { points: remain_point }, status: :ok }
    end
  end
end
