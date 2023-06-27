module API
  module V1
    class Base < Grape::API
      mount API::V1::Wificlients
      mount API::V1::Jsontests
      mount API::V1::Hellos
    end
  end
end
