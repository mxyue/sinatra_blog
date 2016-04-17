require 'settingslogic'
class Settings < Settingslogic
  source "#{Sinatra::Application.settings.root}/config/application.yml"
  namespace Sinatra::Application.settings.environment.to_s
end
