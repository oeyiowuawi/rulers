class Object
  def self.const_missing(const)
    return nil if @calling_constant_missing
    @calling_constant_missing = true
    require Rulers.to_underscore(const.to_s)
    klass = Object.const_get(const)
    @calling_constant_missing = false
    klass
  end
end
