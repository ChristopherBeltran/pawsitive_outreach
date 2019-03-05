module UsersHelper

  def number_format(phone_number)
    int_num = phone_number.to_i
    formatted_number = number_to_phone(int_num, area_code: true)
    return formatted_number
  end
 
end
