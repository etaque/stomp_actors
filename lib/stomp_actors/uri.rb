module StompActors
  class URI
    attr_accessor :conf

    def initialize(conf)
      @conf = conf
    end

    def generate(safe = false)
      if failover?
        "failover:(" << conf.map{|sub_conf| URI.new(sub_conf).generate(safe) }.join(",") << ")"
      else
        if safe
          "stomp://#{conf[:host]}:#{conf[:port]}"
        else
          "stomp://#{conf[:user]}:#{conf[:password]}@#{conf[:host]}:#{conf[:port]}"
        end
      end
    end

    def failover?
      conf.is_a?(Array)
    end

  end
end
