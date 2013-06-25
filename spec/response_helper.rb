def get_response(name)
  JSON.parse(File.read("spec/responses/cbapi/#{name}"))
end

#def deep_compare_response_hashes(data_a, data_b, key)
#  response_a      = {}
#  inconsistencies = []
#
#  case data_a.class.to_s
#    when "Array"
#      data_a.each do |data_obj|
#        if response_a.has_key?(data_obj[key])
#          response_a[data_obj[key]] << data_obj
#        else
#          response_a[data_obj[key]] = [data_obj]
#        end
#      end
#    when "Hash"
#      response_a[data_a[key]] = data_a
#    else
#      raise ArgumentError.new "First data object is neither an Array nor a Hash"
#  end
#
#  case data_b.class.to_s
#    when "Array"
#      if (data_a.is_a?(Array) ? data_a.length : 1) != data_b.length
#        inconsistencies << {
#          type: "Hash counts are not the same (#{data_a.length} vs. #{data_b.length})",
#          data_a: data_a,
#          data_b: data_b
#        }
#      else
#        data_b.each do |data_obj|
#          inconsistencies = check_inconsistencies(response_a[data_obj[key]], data_obj, inconsistencies)
#        end
#      end
#    when "Hash"
#      if response_a.length != 1
#        inconsistencies << {
#          type: "Hash counts are not the same (#{data_a.length} vs. 1)",
#          data_a: data_a,
#          data_b: data_b
#        }
#      else
#        inconsistencies = check_inconsistencies(response_a[data_b[key]], data_b, inconsistencies)
#      end
#    else
#      raise ArgumentError.new "Second data object is neither an Array nor a Hash"
#  end
#
#  return {
#    passed:          inconsistencies.length == 0 ? true : false,
#    inconsistencies: inconsistencies
#  }
#end
#
#def check_inconsistencies(a, b)
#  return a == b
#  #  inconsistencies << {
#  #    type: 'Objects are not the same',
#  #    data_a: a,
#  #    data_b: b
#  #  }
#  #end
#  #
#  #return inconsistencies
#end
