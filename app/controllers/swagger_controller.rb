class SwaggerController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
  end

  SWAGGERED_CLASSES = [
    PointsController,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
