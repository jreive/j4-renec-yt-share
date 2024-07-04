class KeyRotationHelper
  # TODO: Read keys from env
  attr_reader :keys

  def initialize(keys)
    @keys = keys
  end

  # get random key using sample
  def get_random
    @keys.sample
  end

end