module Swagger::PointsApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_path '/users/{id}/points/' do
      parameter :user_id do
        key :name, :id
      end

      operation :get do
        key :description, 'ポイント取得'
        key :operationId, :user_points

        parameter do
          key :name, :id
          key :in, :path
          key :description, 'user id'
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        response 200 do
          key :description, 'ポイント取得'
          schema do
            key :points, :integer
          end
        end
      end
    end

    # 他のパス
  end
end
