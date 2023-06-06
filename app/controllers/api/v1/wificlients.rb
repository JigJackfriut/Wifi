module API
  module V1
    class Wificlients < Grape::API
      include API::V1::Defaults
      resource :wificlients do
        desc "Return all wificlients"
        get "" do
          Wificlient.all
        end
      desc "Return a wificlient"
        params do
          requires :id, type: String, desc: "ID of the wificlient"
        end
        get ":id" do
          Wificlient.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
