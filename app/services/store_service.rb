require 'faye/websocket'
require 'eventmachine'

class StoreService
  def fetch_data
    Thread.new { 
      EM.run do
        ws = Faye::WebSocket::Client.new('ws://localhost:8080/')
  
        ws.on :message do |event|
          monitor(JSON.parse(event.data))
        end
      end
    }
  end

  def monitor(data)
    store = Store.find_or_create_by(name: data['store'])
    store.update!(model: data['model'], inventory: data['inventory'])
    store.update_status(data['inventory'])
  end
end
