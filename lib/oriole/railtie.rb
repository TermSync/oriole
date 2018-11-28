class OrioleRailtie < Rails::Railtie
  initializer "oriole" do |_app|
    ActiveSupport.on_load :active_record do
      require 'oriole/active_record'
    end
  end
end
