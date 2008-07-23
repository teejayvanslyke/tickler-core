class String

  def align_left(width)
    str = truncate(width)
    str << " " * (width - str.length)
  end

  def truncate(chars)
    if self.length > chars-3
      self[0,chars-3]+'...'
    else
      self
    end
  end
end
