module Displayname

  def display_name
    if self.name[-1] == "s"
      "#{self.name}'"
    else
      "#{self.name}'s"
    end
  end
end 
