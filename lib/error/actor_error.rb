module Error
  class ActorError < CustomError
    attr_reader :status, :error, :message
    def initialize(_message=nil)
      super(:actor_does_not_exist, 404, _message || 'Actor not found')
    end
  end
end

