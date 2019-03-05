module UsersHelper

  def number_format
    int_num = self.phone_number.to_i
    formatted_number = number_to_phone(int_num, area_code: true)
    return formatted_number
  end 
