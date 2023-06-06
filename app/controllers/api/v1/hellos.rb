module API
  module V1
    class Hellos < Grape::API
      include API::V1::Defaults
      resource :wificlients do
        desc "Return all hellos"
        get "" do
          Wificlient.all
        end
      desc "Return a hello"
        params do
          requires :id, type: String, desc: "ID of the hello"
        end
        get ":id" do
          Wificlient.where(id: permitted_params[:id]).first!
        end
      end
      #result = { status:"unapproved"}
      #result
    end
  end
end
