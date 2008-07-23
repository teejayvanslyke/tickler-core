class String
  def truncate(chars)
    self[0,chars-3]+'...'
  end
end
