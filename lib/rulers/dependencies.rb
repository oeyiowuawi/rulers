class Object
  def self.const_missing(const)
    return nil if @calling_constant_missing
    @calling_constant_missing = true
    require const.to_s.to_underscore
    klass = Object.const_get(const)
    @calling_constant_missing = false
    klass
  end
end
